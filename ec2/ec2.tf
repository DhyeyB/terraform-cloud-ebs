# EC2 Setup

resource "aws_instance" "ec2_server" {
  vpc_security_group_ids      = [var.server_security_group_id]
  subnet_id                   = var.aws_public_subnet_id
  ami                         = var.instance_ami
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  disable_api_termination     = true
  # ebs_block_device {
  #   device_name = "/dev/sda1"
  #   volume_size = var.instance_disk_size
  # }

  root_block_device {
    volume_size = 20 
    volume_type = "gp2"  # Set the desired volume type (e.g., "gp2" for General Purpose SSD)
    delete_on_termination = true  # Automatically delete the volume when the instance is terminated
  }

  lifecycle {
    create_before_destroy = true
  }

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt -y update
    sudo apt install -y libcurl4-openssl-dev libssl-dev
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get -y install python3.8
    sudo apt -y install supervisor
    sudo apt-get -y install jq
    sudo apt-get install -y git
    sudo apt-get install -y python3.8-venv
    sudo apt-get install -y nginx
    sudo service apache2 stop
    sudo systemctl disable apache2
    sudo systemctl enable nginx
    sudo service nginx restart
    sudo apt install redis-server -y
    sudo systemctl enable redis-server
    sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y install postgresql-15
    sudo systemctl start postgresql
    sudo locale-gen en_IN.UTF-8
    sudo adduser --disabled-password --gecos '' deploy
    sudo passwd -d deploy
    sudo usermod -aG sudo deploy
    sudo su deploy
    sudo sed -i -E 's/^(save\s+900\s+1)/#&/' /etc/redis/redis.conf
    sudo sed -i -E 's/^(save\s+300\s+10)/#&/' /etc/redis/redis.conf
    sudo sed -i -E 's/^(save\s+60\s+10000)/#&/' /etc/redis/redis.conf
    sudo systemctl restart redis-server
    sudo mkdir -p /home/deploy/.ssh
    sudo mkdir -p /opt/ecommpulse/apps
    sudo mkdir -p /opt/ecommpulse/scripts
    sudo mkdir -p /opt/ecommpulse/logs
    sudo mkdir -p /opt/ecommpulse/data
    sudo mkdir -p /opt/ecommpulse/logs/ecommpulse-backend/supervisor
    sudo mkdir -p /opt/ecommpulse/logs/ecommpulse-backend/app
    sudo mkdir -p /opt/ecommpulse/logs/ecommpulse-backend/nginx
    sudo mkdir -p /opt/ecommpulse/scripts/ecommpulse-backend/gunicorn
    sudo chown -R deploy:deploy /opt/ecommpulse
    touch /home/deploy/.ssh/known_hosts
    ssh-keyscan github.com >> /home/deploy/.ssh/known_hosts
    sudo chmod -R 775 /opt/ecommpulse
    sudo echo ${var.rsa_key_1} >> /home/deploy/.ssh/authorized_keys
    sudo chown -R deploy:deploy /home/deploy
    format_db_volume=${var.format_db_volume}
    elapsed_time=0
    while [ $elapsed_time -lt 300 ]; do
      NAME=$(lsblk -o NAME -n /dev/xvdb | awk '{print $1}')
      if [ -n "$NAME" ]; then
          echo "DB Volume found mounting it now."
          if [ "$format_db_volume" = "yes" ]; then
            echo "Formatting DB volume"
            sudo mkfs.ext4 -E nodiscard /dev/xvdb
          else
            echo "Skipping formatting DB volume"
          fi
          echo "DB Volume attached."
          break
      else
          echo "DB Volume not attached."
          sleep 10  # Check every 10 seconds
          elapsed_time=$((elapsed_time + 10))
      fi
    done
    sudo mkdir -p /mnt/postgresql
    sudo mount /dev/xvdb /mnt/postgresql
    sudo systemctl stop postgresql
    # Wait for a maximum of 5 minutes (300 seconds) for the filesystem to be mounted
    timeout=300
    elapsed_time=0
    while ! findmnt -rno SOURCE /mnt/postgresql &> /dev/null; do
        if [ $elapsed_time -ge $timeout ]; then
            echo "Timeout: Filesystem not mounted after 5 minutes."
            break
        fi
        sleep 1
        ((elapsed_time++))
        echo "Filesystem not mounted after $elapsed_time seconds"
    done
    df -h
    sudo ls -ltra /mnt/postgresql/main/
    if sudo [ -f "/mnt/postgresql/main/PG_VERSION" ]; then
    echo "Found existing databse mount point. So removing new one and linking with existing data source."
    sudo rm -rf /var/lib/postgresql/15/main
    sudo ln -s /mnt/postgresql/main /var/lib/postgresql/15/main
    else
    echo "Did not find existing database mount point. So setting up data source on new volume."
    sudo cp -r /var/lib/postgresql/15/main /mnt/postgresql/
    sudo rm -rf /var/lib/postgresql/15/main
    sudo ln -s /mnt/postgresql/main /var/lib/postgresql/15/
    sudo chown -R postgres:postgres /mnt/postgresql
    sudo chmod 700 /mnt/postgresql
    fi
    sudo sed -i '/data_directory/d' /etc/postgresql/15/main/postgresql.conf
    sudo sh -c 'echo "data_directory = '\'/mnt/postgresql/main\''" >> /etc/postgresql/15/main/postgresql.conf'
    sudo systemctl start postgresql
    db_exists=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='${var.db_name}';")
    if [[ $db_exists == "1" ]]; then
        echo "Database '${var.db_name}' already exists."
    else
        sudo -u postgres psql -c "CREATE DATABASE ${var.db_name} TEMPLATE=template0 LC_COLLATE = 'en_IN' ENCODING = 'UTF8' LC_CTYPE='en_IN';"
        sudo -u postgres psql -c "CREATE USER ${var.db_user} WITH PASSWORD '${var.db_password}';"
        sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ${var.db_name} TO ${var.db_user};"
        sudo -u postgres psql -c "ALTER DATABASE ${var.db_name} OWNER TO ${var.db_user};"
        echo "Database Created Successfully."
    fi

    sudo snap install core; sudo snap refresh core
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot

    echo "userdata completed"

    touch /home/deploy/deploy_complete.txt
    EOF

  tags = {
    Name = "${var.instance_name}-${var.environment}"
  }
}

resource "aws_eip" "server_elastic_ip" {
  domain   = "vpc"
  instance = aws_instance.ec2_server.id
  tags = {
    Name = "${var.instance_name} Elastic IP"
  }
}

# resource "null_resource" "wait_for_user_data" {
#   depends_on = [aws_instance.ec2_server]

#   triggers = {
#     instance_id = aws_instance.ec2_server.id
#   }

#   provisioner "local-exec" {
#     command = <<-EOT
#       result=0
#       timeout --preserve-status 4m bash -c '
#         while [ ! -f /home/deploy/deploy_complete.txt ]; do
#           sleep 10
#         done
#       ' || result=$?

#       if [ $result -eq 124 ]; then
#         echo "Timeout reached. Synchronization file not found."
#         # Handle the timeout error gracefully here, if needed
#       elif [ $result -ne 0 ]; then
#         echo "An error occurred while waiting for the synchronization file."
#         # Handle other non-timeout errors gracefully here, if needed
#       else
#         echo "Synchronization file found. Proceeding with further steps."
#         # Perform additional steps here
#       fi
#     EOT
#   }
# }

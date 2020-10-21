 
provider "google" {
 credentials = file(var.cred)
 project     = var.instance["project"]
 region      = var.instance_location["region"]
}

resource "google_compute_instance" "default" {
#	for_each = toset(["1","2"])
#	name = "${var.instance["name"]}-${each.key}"
	name = var.instance["name"]
	machine_type = var.instance["type"]
	zone = var.instance_location["zone"]

	boot_disk {
		initialize_params {
			image = "ubuntu-os-cloud/ubuntu-2004-lts"
		}
	}
	
	
	network_interface {
		network = "default"
		access_config {
		}
	}
	metadata = {
		ssh-keys = "${var.ssh_key_pub["user"]}:${file(var.ssh_key_pub["key"])}"
	}

	connection {
		host = self.network_interface[0].access_config[0].nat_ip
		user = var.ssh_key_pub["user"]
		private_key = file("~/.ssh/id_rsa")
		timeout = "500s"
	}

	provisioner "remote-exec" {
		script = "../prep.sh"

#		connection {
#			#TODO Move private key and user details to var.tf, call it here
#			host = self.network_interface.0.access_config.0.nat_ip
#			user = var.ssh_key_pub["user"]
#			private_key = file("~/.ssh/id_rsa")	
#		}
	}

}

resource "google_compute_firewall" "default" {
	name = "bipolarbot-firewall"
	network = "default"
	
	allow {
		protocol = "tcp"
		ports = ["22","8000"]
	}
	source_ranges = ["0.0.0.0/0"]
}

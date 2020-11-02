 provider "google" {
 credentials = file(var.cred)
 project     = var.instance["project"]
 region      = var.instance_location["region"]
}

resource "google_compute_instance" "default" {
	for_each = toset(var.instance_append_list)
	name = "${var.instance["name"]}-${each.key}"
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
                #TODO: Find a better way to implement the dirty string below
		ssh-keys = "${var.ssh_key_pub["user"]}:${file(var.ssh_key_pub["key"])} \n${var.ansible_ssh_key_pub["user"]}:${file(var.ansible_ssh_key_pub["key"])}"
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

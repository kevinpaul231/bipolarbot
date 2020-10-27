 provider "google" {
 credentials = file(var.cred)
 project     = var.instance["project"]
 region      = var.instance_location["region"]
}

resource "google_compute_instance" "default" {
	for_each = toset(["1","2"])
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
		ssh-keys = "${var.ssh_key_pub["user"]}:${file(var.ssh_key_pub["key"])}"
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

output "ip" {
	value = [
		for instance in google_compute_instance.default:
			instance.network_interface.0.access_config.0.nat_ip
	]
}

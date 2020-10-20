 
provider "google" {
 credentials = file("test-123-292706-09d49006a885.json")
 project     = "test-123-292706"
 region      = "us-central1"
}

resource "google_compute_instance" "default" {
	name = "bipolarbot-test-191020"
	machine_type = "e2-small"
	zone = "us-central1-a"

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
		ssh-keys = "kkodiyan:${file("~/.ssh/id_rsa.pub")}"
	}

}

resource "google_compute_firewall" "default" {
	name = "bipolarbot-firewall"
	network = "default"
	
	allow {
		protocol = "tcp"
		ports = ["6666"]
	}
}

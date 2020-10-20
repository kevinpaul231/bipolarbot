variable "cred" {
	default = "cred.json"
}

variable "instance" {
	type = map
	default = {
		"project" = "test-123-292706"
		"name" = "bipolarbot-test-201020"
		"type" = "e2-small"
	}
}

variable "instance_location" {
	type = map
	default = {
		"region" = "us-central1"
		"zone" = "us-central1-a"
	}
}

variable "ssh_key_pub" {
	type = map
	default = {
		"user" = "kkodiyan"
		"key" = "~/.ssh/id_rsa.pub"
	}
}



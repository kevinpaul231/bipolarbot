resource "local_file" "ansibleInventory" {
        content = templatefile("hosts.tmpl", 
        {
#                ips = google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip
#                ips = ["${ google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}"]
#                ips = [for i in var.instance_append_list : lookup(google_compute_instance.default, i)]
                ips = google_compute_instance.default
        }
        )
        filename = "../ansible/hosts.ini"
        file_permission = "0644"
}

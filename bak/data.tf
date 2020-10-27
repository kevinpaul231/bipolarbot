data "template_file" "script" {
  template = file("../prep.sh")
}

data "template_cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script.rendered
  }
}


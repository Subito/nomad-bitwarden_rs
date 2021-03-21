job "bitwarden" {
  region = "global"
  datacenters = ["dc1", "minipot"]

  group "bitwarden" {
    count = 1

    network {
      port "http" {
        to = 8000
      }
    }

    service {
      tags = ["bitwarden", "web"]
      name = "bitwarden"
      port = "http"
      check {
        type = "http"
        path = "/"
        interval = "10s"
        timeout = "2s"
      }
    }

    task "bitwarden-rs" {
      driver = "pot"

      config {
        image = "http://192.168.16.110:24199/registry/"
        pot = "bitwarden"
        tag = "0.1"
        command = "/bin/sh /usr/local/sbin/bitwarden_start.sh"
        port_map = {
          http = 8000,
        }
        mount = [ "/pot/bitwarden/data:/bitwarden/data" ]
      }
      resources {
        cpu = 200
        memory = 128

      }
    }
  }
}

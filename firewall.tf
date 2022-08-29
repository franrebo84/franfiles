resource "google_compute_firewall" "deny-ingress-traffic-from-internet" {
  name    = "deny-all-ingress-traffic"
  network = google_compute_network.hub.name
  project = data.google_project.hub.project_id

  deny {
    protocol  = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 2000
  direction     = "INGRESS"
}

resource "google_compute_firewall" "deny-egress-traffic-to-internet" {
  name    = "deny-all-egress-traffic"
  network = google_compute_network.hub.name
  project = data.google_project.hub.project_id

  deny {
    protocol  = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  priority    = 2000
  direction   = "EGRESS"
}

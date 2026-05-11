variable "gcp_project" {
  type        = string
  description = "GCP project ID."
  default     = "project-5ff1b0f7-ade0-446d-b22"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository in OWNER/REPO format for WIF attribute condition."
  default     = "joserodriguezthe1/cgep-capstone"
}
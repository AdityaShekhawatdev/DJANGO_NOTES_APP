terraform {
  backend "s3" {
    bucket = "django-notes-app-shekhawat-aditya-2026"
    key = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}
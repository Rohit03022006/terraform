# Dev remote
module "dev-remote" {
  source = "./remote-app"
  env = "dev"
  bucket_name = "remote-app-bucket-main"
  instance_count = 1
  instance_type = "c7i-flex.large"
  ami_id = "ami-07062e2a343acc423"
  hash_key = "student_ID"
}
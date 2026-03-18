variable "env" {
  description = "This is the Environment"
  type = string
}

variable "bucket_name" {
  description = "This is the Bucket name for my remote environment"
  type = string
}
variable "instance_count" {
  description = "This is the number of EC2 instances for my remote environment"
  type = number
}
variable "instance_type" {
  description = "This is the instance type for my remote environment"
  type = string
}
variable "ami_id" {
  description = "This the AMI ID for my remote environment"
  type = string
}
variable "hash_key" {
  description = "This is the Hash key for my remote environment" 
  type = string
}
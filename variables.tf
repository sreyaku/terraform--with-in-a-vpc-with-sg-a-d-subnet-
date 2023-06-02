 variable "region" {
  type        = string
  description = "AWS Region to deploy resources"
  default     = "ap-south-1"
}
 variable "key_name"{
  type        = string
  description = "AWS keyname to  to deploy resources"
  default     = "pgadminkeypair.pem"
    
} 
variable  "vpc_id"{
  type        = string
  default     = "vpc-0aa5bab98054bc3db"

}
variable "ami"{
  type        = string
  default     = "ami-02eb7a4783e7e9317"

}
variable "instance_type"{
  type        = string
  default     = "t2.micro"
}

variable "subnet_id"{
  type        = string
  default     = "subnet-065a1661b0492e9bf"
}

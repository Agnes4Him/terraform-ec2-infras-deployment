variable region {
    description = "AWS region to provision infrastructures"
    default = ""
    type = string
}

variable access_key {}

variable secret_key {}

variable vpc_cidr_block {
    description = "AWS VPC cidr block"
    default = ""
    type = string
}

variable subnet_cidr_block {}

variable avail_zone {}

variable env {}

variable public_key_location {
    description = "The local path to instance public key"
    default = ""
    type = string
}

variable private_key_location {
    description = "The local path to private key used in accessing instance"
    default = ""
    type = string
}
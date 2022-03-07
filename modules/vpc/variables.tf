variable "cidr_block" {
  type        = string
  description = "CIDR block"
}

variable "Tag_Name" {
  type        = string
  description = "Tag Name"
}

variable "public-AZ" {
  type        = map(string)
  description = "パブリックサブネットのAZ識別子とCIDRを紐付けたMAP変数"
}

variable "private-AZ" {
  type        = map(string)
  description = "プライベートサブネットのAZ識別子とCIDRを紐付けたMAP変数"
}

variable "eip-NAT-AZ" {
  type        = list(string)
  description = "NATに割り当てられているEIPのAZ"
}
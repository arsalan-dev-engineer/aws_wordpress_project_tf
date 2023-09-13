variable "ingress_ports" {
    type = list(number)
    default = [22, 80, 3306]
}
resource "aws_lb" "test" {
  name               =  "test-lb-tf-${var.LB_TYPE}"
  internal           =  var.INTERNAL
  load_balancer_type =  "application"
  security_groups    =  var.INTERNAL ?  aws_security_group.allow_tls_prvt_lb.*.id : aws_security_group.allow_tls_pblc_lb.*.id
  subnets            =  var.INTERNAL ?  data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLC_SUBNET_IDS
  enable_deletion_protection = false

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = var.ENV
  }
}
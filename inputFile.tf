# Configure the AWS Provider
                            variable "access_key"  {}
                            variable "secret_key" {}
                            provider "aws" {
                            access_key = "${var.access_key}"
                            secret_key = "${var.secret_key}"
                            region     = "us-east-2"
                                            }
                            
                        data "aws_instances" "test" {
                        filter {
                                name   = "instance-state-name"
                                values = ["running"]
                                }
                        instance_state_names = [ "running", "stopped" ]
                                }

                        resource "aws_eip" "test" {
                        count = "${length(data.aws_instances.test.ids)}"
                        instance = "${data.aws_instances.test.ids[count.index]}"
                        }

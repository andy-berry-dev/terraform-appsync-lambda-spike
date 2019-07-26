resource "aws_rds_cluster" "cluster" {
    cluster_identifier = "${var.cluster_name}"
    database_name = "${var.cluster_name}-db"
    master_username = "${var.master_username}"
    master_password = "${var.master_password}"
    #vpc_security_group_ids = ["${aws_security_group.aurora.id}"]
    skip_final_snapshot = true
    db_subnet_group_name = "${var.subnet_name}"
    engine_mode = "serverless"
    scaling_configuration {
        auto_pause = "${var.auto_pause}"
        max_capacity = "${var.min_capacity}"
        min_capacity = "${var.max_capacity}"
        seconds_until_auto_pause = "${var.seconds_until_auto_pause}"
    }
}
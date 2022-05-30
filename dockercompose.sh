ecs-cli configure --cluster ec2-tutorial --default-launch-type EC2 --config-name ec2-tutorial --region ap-northeast-2
# ecs-cli configure profile --access-key FILL_ME_IN --secret-key FILL_ME_IN --profile-name ec2-tutorial-profile
ecs-cli up --keypair projectju --capability-iam --size 1 --instance-type t2.medium --security-group sg-0e8b01b4716b74cbd --vpc vpc-0fcd911cef7938e9f --subnets subnet-0f694a08b9dd690a2, subnet-07433f10b9575cde5 --cluster-config ec2-tutorial --ecs-profile ec2-tutorial-profile
ecs-cli compose service up --cluster-config ec2-tutorial --ecs-profile ec2-tutorial-profile
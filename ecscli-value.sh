cd terraform
echo vpc_id :
terraform output vpc_id
echo security_group :
terraform output aws_security_group_id
echo subnet_public :
terraform output aws_subnet_public_id
echo subnet_private :
terraform output aws_subnet_private_id
echo taget_group :
terraform output aws_tg_id
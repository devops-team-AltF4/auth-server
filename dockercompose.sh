# 도커 빌드 푸쉬 명령어
# aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com
# docker build --platform linux/amd64 -t pj4-auth .
# docker tag pj4-auth:latest 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest
# docker push 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest

#ecs 올리는 명령어 
# ecs-cli configure --cluster project4-devterr --default-launch-type EC2 --config-name project4-devterr --region ap-northeast-2
# ecs-cli configure profile --access-key FILL_ME_IN --secret-key FILL_ME_IN --profile-name project4-devterr
ecs-cli up --keypair projectju --capability-iam --size 1 --instance-type t2.medium --cluster-config project4-devterr --ecs-profile project4-devterr --vpc vpc-0df90a1ab0fc11825 --security-group sg-07da5f154b06ec072 --subnets subnet-017da35bd76404302,subnet-0f2478bfa3bd03b9b
ecs-cli compose service up --cluster-config project4-devterr --ecs-profile project4-devterr --target-groups "targetGroupArn=arn:aws:elasticloadbalancing:ap-northeast-2:060701521359:targetgroup/dev-app-dev-tg2/a684b396dda35c01,containerName=node-app,containerPort=3005" --vpc vpc-0df90a1ab0fc11825

# 삭제 명령어
# ecs-cli compose service rm --cluster-config project4-devterr --ecs-profile project4-devterr
# ecs-cli compose down --cluster-config project4-devterr --ecs-profile project4-devterr
# ecs-cli down --force --cluster-config project4-devterr --ecs-profile project4-devterr
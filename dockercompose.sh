# 도커 빌드 푸쉬 명령어
# aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com
# docker build --platform linux/amd64 -t pj4-auth .
# docker tag pj4-auth:latest 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest
# docker push 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest

#ecs 올리는 명령어 
# ecs-cli configure --cluster project4-devterr --default-launch-type EC2 --config-name project4-devterr --region ap-northeast-2
# ecs-cli configure profile --access-key FILL_ME_IN --secret-key FILL_ME_IN --profile-name project4-devterr
# ecs-cli up --keypair FILL_ME_IN --capability-iam --size 1 --instance-type t2.medium --cluster-config project4-devterr --ecs-profile project4-devterr --vpc FILL_ME_IN --security-group FILL_ME_IN --subnets FILL_ME_IN,FILL_ME_IN
# ecs-cli compose service up --cluster-config project4-devterr --ecs-profile project4-devterr --target-groups "targetGroupArn=FILL_ME_IN,containerName=node-app,containerPort=3005" --vpc FILL_ME_IN

# 삭제 명령어
# ecs-cli compose service rm --cluster-config project4-devterr --ecs-profile project4-devterr
# ecs-cli down --force --cluster-config project4-devterr --ecs-profile project4-devterr
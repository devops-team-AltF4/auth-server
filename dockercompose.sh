#!/bin/bash

# 도커 빌드 푸쉬 명령어
# aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com
# docker build --platform linux/amd64 -t pj4-auth .
# docker tag pj4-auth:latest 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest
# docker push 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth:latest

#ecs 올리는 명령어 
# ecs-cli configure --cluster project4-dev --default-launch-type EC2 --config-name project4-dev --region ap-northeast-2
# ecs-cli configure profile --access-key FILL_ME_IN --secret-key FILL_ME_IN --profile-name project4-dev
ecs-cli up --keypair projectju --capability-iam --size 1 --instance-type t2.medium --cluster-config project4-dev --ecs-profile project4-dev --vpc vpc-0e5396ed9cc3ae48c --security-group sg-098d956e568fda953 --subnets subnet-057a319cd0a0fd0d0,subnet-0fb9e41432ec73fe9
ecs-cli compose service up --cluster-config project4-dev --ecs-profile project4-dev --target-groups "targetGroupArn=arn:aws:elasticloadbalancing:ap-northeast-2:060701521359:targetgroup/dev-app-dev-tg2/509b951524217429,containerName=node-app,containerPort=3005" --vpc vpc-0e5396ed9cc3ae48c

# 삭제 명령어
ecs-cli compose down --cluster-config project4-dev --ecs-profile project4-dev
ecs-cli compose service rm --cluster-config project4-dev --ecs-profile project4-dev
ecs-cli down --force --cluster-config project4-dev --ecs-profile project4-dev
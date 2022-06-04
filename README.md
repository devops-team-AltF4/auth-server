# Auth-server

## 프로젝트 목표
**목표**
Git repository의 소스코드 CI / CD 기존의 파이프 라인을 병목현상이 발생하는 곳들을 분석하여 그 과정에서 필요하다고 생각하는 부분을 크게 3가지로 나눌 수 있었습니다. 특히 auth-server repository 에서는 인프라 구축의 자동화와 앱 애플리케이션 배포 자동화에 초점을 두었고 그런 부분들을 IaC tool로서 선택한 스택으로 Terraform과 ECS-CLI, EKS-CLI 등을 Git action과 연동시켜 repository의 변화를 즉각적으로 배포할 수 있도록 구성하였습니다. 새로운 빌드 이미지 Build & Push 과정은 Git action이나 ECS로 실행 시 푸쉬가 적용이 되며 git action의 결과를 Slack으로 알 수 있도록 설계했습니다.  
## 시스템 아키텍쳐
**Staging & Production**
![SA](https://user-images.githubusercontent.com/98368480/171760930-75b19efc-68b0-4fd4-92a1-290d2034625c.png)

**Development**
![Dev](https://user-images.githubusercontent.com/98368480/171761476-2079f0d2-0790-4808-8bb4-ccb09f27c3a6.png)

## 배포 파이프라인
![백엔드, 2022-06-02 23-52-32](https://user-images.githubusercontent.com/98368480/171760373-27ded2ff-8c24-4904-9773-8e83add37391.png)
인프라 구축 -> ecscli 클러스터 생성, 서비스 생성

## getting started
esc-cli 설치
공식 문서 참고 https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/ECS_CLI_installation.html


## 환경별 기능
**dev**
- 깃 레포에 푸시하면 깃액션 테라폼ci를 실행하여 인프라가 없으면 vpc, 로밸, 보안그룹등 필요한 인프라를 구축함
- auth레포와 api레포는 동일한 테라폼클라우드를 사용하여 tfstate 파일을 공유하게끔 하여 인프라를 2번 생성되지 않도록 함 
- 깃액션을 job1,2로 구분하여 terraform ci가 먼저 실행되고 ecscli를 통해 ecs클러스트 생성하여 서비스를 구축함 
- ecs는 dev팀에 요구 사항에 의해 ec2로 구성했으며 ec2의 사용자 권한을 공유하여 ec2를 모든 개발팀이 하나의 ec2를 다함께 이용 할 수 있도록 하여 컨테이너가 잘 돌아가는지 디버깅 할 수 있는 환경을 구성하였음.

**staging/production**
- eks 아마존 쿠버네티스 서비스를 이용하여 만들어진 쿠버네티스 서비스를 이용하여 product환경을 업데이트할때 다운타임 없이 배포가능하게끔 함
- argoci 오픈소스를 이용하여 깃 푸시를 할때 자동으로 쿠버네티스 깃레포에 있는 서비스를 자동으로 업데이트 시키도록 배포 자동화를 구축하였음
- 그라파나 모니터링 시스템을 성능 분석및 트래픽 확인이 가능하도록 함
- eks 마스터 권한 나누기

## Terraform iac (auth, api)
서비스를 합쳐서 관리하기 때문에 테라폼 구성이 동일
VPC, subnet, ALB, tagetgroup, RDS 등 인프라 구축

## 명령어

#### ecs-cli 사용
**local 환경에서 ecs-cli 사용법**
- ecscli-value.sh를 실행 시킨다
ecs-cli.sh에 필요한 부분을 주석처리를 해제하고 FILL_ME_IN 부분을 ecscli-value를 참고하여 수정해서 사용

**git action을 이용한 ecs-cli 배포**
- 첫 인프라 구성에 한해 Terraform에서 생성된 리소스를 ecscli-value이나 terrform oupput을 확인하여 (AWS_SECURITY_GROUP, AWS_SUBNETS_1, AWS_SUBNETS_2, AWS_TARGET_GROUP_ARN,AWS_VPC)  Git Actions secrets의 환경변수를 업데이트 하여 사용해주셔야함


ec2 사용자 권한 주는 순서

1. ec2를 만든 유저가 .pem키로 ssh 접속합니다

2. 다음을 입력합니다

```
sudo adduser -m testuser
sudo su - testuser
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```
3. 추가하려는 사람의 pc에서 id_rsa를 생성합니다.
```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```
4. 출력은 다음과 비슷합니다.
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTvTnCzaaIPChWXgvxlyswcNzzTjlYUcfNExm6zGGJRtEcjvHMpV6vg9XMOb9ZgRNhgpWQqitQ9yLy+mjznDerfuK9RsEIdu5wb7uVFXs6TGHy8b9sqid0PH6PYuWiZ1/pA6cRrtQudeqlZuVV5wyimPFKZONW3v+BOp+AtIvChPhZI+rWn0T3vxi2NTHfdqW93VqsQ7ReEkzd1RGxJZ+1X0kADmCJKjwAoju0DvvVz3/xdsc2UT3rjRsUTxDR1bH4GBQr7U1pwCGAqZqvEl72TLpUdWRECG42qIPsut95c237gtzkwlU7iAOeiPWJduMV/bPxXnrB/YqF+XwRMuiz testuser@testEC2
```
5. ec2를 만든 유저가 testuser의 .ssh/authorized_keys에 id_rsa.pub을 붙여 넣습니다.

6. 접속
testuser는 다음과 같이 접속할 수 있습니다.
```ssh testuser@ec2 퍼블릭 IP주소 ```


eks 권한 주는 순서 <br/>
블로그 참고
- https://mtou.tistory.com/132


## OutPut
dev환경 
http://api.devops-altf4.click:3005/auth
<img width="818" alt="스크린샷 2022-06-03 오전 10 54 42" src="https://user-images.githubusercontent.com/50437623/171771699-b174ee59-3525-4491-a192-94579d3fd41c.png">

staging환경
https://eks.devops-altf4.click/auth
<img width="818" alt="스크린샷 2022-06-03 오전 10 54 42" src="https://user-images.githubusercontent.com/50437623/171771833-f9632876-77f2-4e01-b269-5d7085410fd5.png">

front에서 visits를 들어가서 확인한 화면
https://staging.devops-altf4.click/
<img width="1332" alt="스크린샷 2022-06-03 오전 10 48 58" src="https://user-images.githubusercontent.com/50437623/171771236-8b7fc52d-3132-4175-ba4b-e78751367390.png">


## Redis와 auth 서버 연결 설정

1. Redis-server을 로컬로 띄울 때 host는 다음과 같습니다.

```
const redis_client = new Redis({
  host : 'localhost',
  port : '6379'
});
```

2. docker-compose로 띄우고자 할 때는 compose파일에 컨테이너 이름과 host 이름이 같아야 합니다.
```
# docker-compose.yaml
  myRedis:
    image: redis
    ports:
      - "6379:6379"
 ```
```
const redis_client = new Redis({
  host : 'myRedis',
  port : '6379'
});
```

3. auth-server와 redis를 ECS에 올리고자 할 때, auth서버에서 link를 redis로 해줍니다.
![image](https://user-images.githubusercontent.com/50416571/171988821-53fa9f79-cc4f-4bab-b600-4b53c1ae8f46.png)

4. ecs-cli 명령어를 통해 compose 파일을 ecs로 올릴 때는 docker-compose.yaml에서 다음과 같이 link를 걸어줍니다.
```
version: '3'
services:
  node-app:
    image: 060701521359.dkr.ecr.ap-northeast-2.amazonaws.com/pj4-auth
    ports:
      - "3005:3005"
    networks:
      - web-net
    links:
      - redis
```


## Code 설명

캐시 기능을 사용하고자 할 때는 다음과 같이 설정합니다.

```
#app.js

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
  
  // 캐시 체크를 위한 미들웨어
checkCache = (req, res, next) => {
  redis_client.get(req.url, (err, data) => {
    if (err) {
      console.log(err);
      res.status(500).send(err);
    }
      // Redis에 저장된게 존재한다.
    if (data != null) {
      res.send(data);
    } else {
        // Redis에 저장된게 없기 때문에 다음 로직 실행
      next();
    }
  });
};

app.get('/auth' ,checkCache ,async (req, res) => {

```

ECS로 배포시 visits(key)의 value가 NAN, Undifiend가 나와 ++가 안되는 현상이 있었습니다.
그래서 다음과 같이 if문을 걸어 0으로 초기화 했습니다.

```
    redis_client.get("visits", (err, value) => {
      console.log(value)
      if (value === "NaN" || value === null || value === "undefined"){
        redis_client.set("visits", 0)
        value = 0
      }
      res.send("Number of visit is " + value)
      value++
      redis_client.set("visits", value)
  });
})
```

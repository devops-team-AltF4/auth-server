const Redis = require('ioredis');
const express = require('express');
//const axios = require('axios');
const bodyParser = require('body-parser');
const port = 3005;

const cors = require('cors');

let corsOptions = {
  origin: "*", // 출처 허용 옵션

  credential: true, // 사용자 인증이 필요한 리소스(쿠키 ..등) 접근
};





const redis_client = new Redis({
  host : 'redis',
  port : '6379'
});


const app = express();

app.use(cors(corsOptions));

  // Body Parser 미들웨어
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

  //  [GET] /university/turkey
  //  미들웨어 추가
  app.get('/auth' ,async (req, res) => {
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


  
  // express 서버를 3005번 포트로 실행;
  app.listen(port, () => console.log(`Server running on Port ${port}`));
const express = require("express")
const redis = require("redis")

const app = express()

const client = redis.createClient({
  host: "redis-server",
  port: 6379,
})

app.get("/", (req, res) => {
  client.get("visits", (err, visits) => {
    res.send("Number of visit is " + visits)
    client.set("visits", parseInt(visits) + 1)
  })
})

app.listen(3005, () => {
  console.log("Listening 3005 port")
})
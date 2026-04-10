const express = require("express");//using express framework
const router = express.Router();//mini route system
const { register, login } = require("../controllers/authController");//importing 2 functions -> 1.register(signup) 2.login(authentication)

router.post("/register", register);//when request come to post/register,, it runs- register controllers 
router.post("/login", login);//when request come to POST/login It runs: login controller

module.exports = router;//so it can be used in main server
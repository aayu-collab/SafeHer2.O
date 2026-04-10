const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

exports.register = async (req, res) => {//this function runs when a user signup
  const { name, email, password, phone } = req.body;//getting user data

  try {
    const hashed = await bcrypt.hash(password, 10);//VERRY IMPORTENT // converts passward into hashed(encrypted)

    const user = new User({//creating new user object
      name,
      email,
      password: hashed,
      phone,
    });

    await user.save();//saving user in mongoDB

    res.json({ msg: "User Registered" });//sending succes response
  } 
                                     ////////Error Handling///

  catch (err) {
    res.status(500).json({ msg: "Error registering user" });
  }
};

exports.login = async (req, res) => { //runs when user login 
  const { email, password } = req.body;//get login credentials

  try {
    const user = await User.findOne({ email });//check if user exist
    if (!user) return res.status(400).json({ msg: "User not found" });//email is not registered -> Error

    const isMatch = await bcrypt.compare(password, user.password);///(Entered passward,,stored hash passward)
    if (!isMatch) return res.status(400).json({ msg: "Wrong password" });//if passward is incorrect 

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);//CORE concept : JWT (JSON Web Token)(creats a token using -> i. user ID , ii. secret key),,this token is used for authentication

    res.json({ token });// send token to frontened
  } 
  /////UPDATED error handling (helps in debugging)
  catch (err) {
  console.error("🔥 Login Error:", err.message);
  res.status(500).json({ msg: err.message });
}
};
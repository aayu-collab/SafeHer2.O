const mongoose = require("mongoose");//this imports moongose ,which helps Node.js talk to MongoDB easily

const connectDB = async () => { //it is creating a function named connectDB(async is used bcz database connection takes time(it's asynchronoumous))
  try {
    await mongoose.connect(process.env.MONGO_URI);// this connects to MongoDB(process.env.Mongo_URI means(your database Url is stored in .env file))
    console.log("✅ MongoDB Connected");// if connection is succesful print this message
  } catch (err) {//isf any errror happens print the below msg
    console.error("❌ DB Error:", err.message);
    process.exit(1);//stops the server if DB connection is fails
  }
};

module.exports = connectDB;
const express = require("express"); //to crete backend server and APIs
const dotenv = require("dotenv"); // to use .env file in which secret file is stored 
const cors = require("cors"); //to connect frontend to backend otherwise brouser will block us
const connectDB = require("./config/db");// imorting MongoDB connnection function which has been written in config/db.js

dotenv.config();//to active .enev file
connectDB();// to connect database

const app = express();// our main server object ( creating express app)

// Middleware
app.use(cors()); //CORS middleware enable (flutter will be able to call backend)
app.use(express.json());// incoming data reading (JSON formated data)

// Routes
app.use("/api/auth", require("./routes/authRoutes")); //to connect auth routes (login/ register APIs will be handaled )
app.use("/api/contact", require("./routes/contactRoutes"));// to connect related APIs(add contact, get contact)
app.use("/api/alert", require("./routes/alertRoutes"));// SOS alert APIs(to send emegrency alerts )

app.get("/", (req, res) => {
  res.send("SafeHer Backend Running 🚀");
});/// to check server is running or not (while opening in brouser it will be shown)

const PORT = process.env.PORT || 5000;//// deciding port (.env me ho to use karo otherwise default 5000)

/////mongo DB
require('dotenv').config();

mongoose.connect(process.env.MONGO_URI)



app.listen(PORT, () =>
  console.log(`Server running on port ${PORT}`)
);/// server is starting 
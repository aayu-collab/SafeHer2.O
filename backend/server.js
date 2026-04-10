const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const path = require("path");
const cors = require("cors");

dotenv.config({ path: path.resolve(__dirname, ".env"), override: true });

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// ✅ IMPORT ROUTES
const authRoutes = require("./routes/authRoutes");
const alertRoutes = require("./routes/alertRoutes");
const contactRoutes = require("./routes/contactRoutes");

// ✅ USE ROUTES (VERY IMPORTANT)
app.use("/api/auth", authRoutes);
app.use("/api/alerts", alertRoutes);
app.use("/api/contacts", contactRoutes);

// MongoDB connect
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("✅ MongoDB Connected"))
  .catch((err) => console.error("❌ DB Connection Error:", err));

// Test route (optional)
app.get("/", (req, res) => {
  res.send("API running...");
});

// Server start
app.listen(5000, () => console.log("Server running "));
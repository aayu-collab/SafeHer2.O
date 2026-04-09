const mongoose = require("mongoose");

const alertSchema = new mongoose.Schema({
  userId: mongoose.Schema.Types.ObjectId,
  latitude: Number,
  longitude: Number,
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Alert", alertSchema);
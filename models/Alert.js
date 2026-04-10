const mongoose = require("mongoose");///importing mongoose 

const alertSchema = new mongoose.Schema({//creting the structure of data
  userId: mongoose.Schema.Types.ObjectId,
  latitude: Number,
  longitude: Number,
  createdAt: { type: Date, default: Date.now },//stores time of alert
});

module.exports = mongoose.model("Alert", alertSchema);//creating module named alert
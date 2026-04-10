const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },//user ka naam ,,required -> must fill
  email: { type: String, unique: true, required: true },//unique-> must be unique
  password: { type: String, required: true },
  phone: { type: String },//optional

  // Emergency contacts array
  emergencyContacts: [
    {
      name: String,
      phone: String,
    }
  ],

  // Location / Maps
  location: {//stores users current location
    latitude: Number,
    longitude: Number,
  },
}, {
  timestamps: true
});

module.exports = mongoose.model("User", userSchema);//crets model user ,,here User is the actual tool which uses the blueprint,,userSchema->actual tool to use that blueprint
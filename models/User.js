const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, unique: true, required: true },
  password: { type: String, required: true },
  phone: { type: String },

  // Emergency contacts array
  emergencyContacts: [
    {
      name: String,
      phone: String,
    }
  ],

  // Location / Maps
  location: {
    latitude: Number,
    longitude: Number,
  },
}, {
  timestamps: true
});

module.exports = mongoose.model("User", userSchema);
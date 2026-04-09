const mongoose = require("mongoose");

const contactSchema = new mongoose.Schema({
  userId: mongoose.Schema.Types.ObjectId,
  name: String,
  phone: String,
});

module.exports = mongoose.model("Contact", contactSchema);
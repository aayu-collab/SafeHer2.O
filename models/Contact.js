const mongoose = require("mongoose");

const contactSchema = new mongoose.Schema({//to crete a structure of data
  userId: mongoose.Schema.Types.ObjectId,//shows which user owns this contact
  name: String,
  phone: String,
});

module.exports = mongoose.model("Contact", contactSchema);//create model contact
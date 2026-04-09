const Contact = require("../models/Contact");

exports.addContact = async (req, res) => {
  const { name, phone } = req.body;

  const contact = new Contact({
    userId: req.user.id,
    name,
    phone,
  });

  await contact.save();
  res.json({ msg: "Contact Added" });
};

exports.getContacts = async (req, res) => {
  const contacts = await Contact.find({ userId: req.user.id });
  res.json(contacts);
};
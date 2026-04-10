const Contact = require("../models/Contact");

exports.addContact = async (req, res) => {//runs when user add a new contact
  const { name, phone } = req.body;//getting contact details from frontend
   
  const contact = new Contact({// creating a new contact object
    userId: req.user.id,///IMPORTANT (links contacts to the logged-in-user)(means every user have their own contact list)
    name,//saving contact details
    phone,
  });

  await contact.save();//saves contact in mongoDB
  res.json({ msg: "Contact Added" });//send succces reponse
};

exports.getContacts = async (req, res) => {//runs when user wants to see saved contacts
  const contacts = await Contact.find({ userId: req.user.id });////(fetches only those contacts belongs to that user)
  res.json(contacts);//sends contact list to fronted
};
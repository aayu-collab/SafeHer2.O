const Alert = require("../models/Alert");
const Contact = require("../models/Contact");
const twilio = require("twilio");

exports.sendAlert = async (req, res) => {
  const { latitude, longitude } = req.body;

  try {
    const alert = new Alert({
      userId: req.user.id,
      latitude,
      longitude,
    });
    await alert.save();

    // Fetch user contacts
    const contacts = await Contact.find({ userId: req.user.id });
    
    // Twist into action if Twilio keys exist
    if (process.env.TWILIO_SID && process.env.TWILIO_AUTH_TOKEN && process.env.TWILIO_PHONE) {
      const client = twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN);
      const messageBody = `🚨 SAFEHER EMERGENCY: I AM IN DANGER! Please help me. Location: https://maps.google.com/?q=${latitude},${longitude}`;

      for (let contact of contacts) {
        await client.messages.create({
          body: messageBody,
          from: process.env.TWILIO_PHONE,
          to: contact.phone
        }).catch(err => console.error("SMS Error:", err.message));
      }
    }

    res.json({ msg: "🚨 SOS Alert & SMS Sent" });
  } catch (err) {
    res.status(500).json({ msg: "Error sending alert" });
  }
};
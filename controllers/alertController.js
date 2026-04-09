const Alert = require("../models/Alert");

exports.sendAlert = async (req, res) => {
  const { latitude, longitude } = req.body;

  const alert = new Alert({
    userId: req.user.id,
    latitude,
    longitude,
  });

  await alert.save();

  res.json({ msg: "🚨 SOS Alert Sent" });
};
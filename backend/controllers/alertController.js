const Alert = require("../models/Alert");//importing the alert model (MongoDB scheme)(this is where data alert will be stored)

exports.sendAlert = async (req, res) => {// creating a function sendalert ,,,export means u can use it in ur routes,, async bcz database operations take time
  const { latitude, longitude } = req.body;// getting location from frontened 

  const alert = new Alert({// creating a new alert object
    userId: req.user.id,// IMPORTANT bcz it gets logged in IDs from authentication middleware (that means user must be logged in )
    latitude,//saving location in database
    longitude,
  });

  await alert.save();//saving alert in mongoDB 

  res.json({ msg: "🚨 SOS Alert Sent" });//sending response back to frontend(shows succes message)
};
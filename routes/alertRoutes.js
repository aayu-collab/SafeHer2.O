const express = require("express");
const router = express.Router();
const auth = require("../middleware/authMiddleware");
const { sendAlert } = require("../controllers/alertController");

router.post("/send", auth, sendAlert);

module.exports = router;
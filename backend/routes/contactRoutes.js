const express = require("express");
const router = express.Router();
const auth = require("../middleware/authMiddleware");
const {
  addContact,
  getContacts,
} = require("../controllers/contactController");

router.post("/add", auth, addContact);
router.get("/", auth, getContacts);

module.exports = router;
const express = require("express");
const {
  postSerialNumberController,
  getSerialNumberController,
  consumeSerialNumberController,
} = require("../controllers/serialNumberController");
const {
  getPendingCommissionController,
} = require("../controllers/commisionController");
const router = express.Router();

router.post("/verify/serial-numbers", postSerialNumberController);
router.get("/verify/serial-numbers/:serialNumber", getSerialNumberController);
router.post("/verify/consume ", consumeSerialNumberController);

router.get(
  "/verify/users/:userId/commission/pending",
  getPendingCommissionController
);

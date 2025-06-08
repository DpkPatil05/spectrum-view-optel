const express = require("express");
const {
  postSerialNumberController,
  getSerialNumberController,
  consumeSerialNumberController,
} = require("../controllers/serialNumberController");
const {
  getPendingCommissionController,
  redeemCommissionController,
} = require("../controllers/commisionController");
const { getStockSummaryController } = require("../controllers/stockController");
const {
  getUserSummaryController,
} = require("../controllers/userSummaryController");
const { loginController, registerController } = require("../controllers/authController");
const router = express.Router();

router.post("/auth/register", registerController);
router.post("/auth/login", loginController);
router.post("/verify/serial-numbers", postSerialNumberController);
router.get("/verify/serial-numbers/:serialNumber", getSerialNumberController);
router.post("/verify/consume ", consumeSerialNumberController);

router.get(
  "/verify/users/:userId/commission/pending",
  getPendingCommissionController
);

router.post(
  "/verify/users/:userId/commission/redeem",
  redeemCommissionController
);

router.get("/verify/stock-summary", getStockSummaryController);

router.get("/verify/users/summary", getUserSummaryController);

module.exports = router;

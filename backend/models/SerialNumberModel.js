const mongoose = require("mongoose");

const SerialNumberSchema = new mongoose.Schema(
  {
    serialNumber: {
      type: String,
      required: true,
      unique: true,
    },
    mrp: {
      type: Number,
      required: true,
    },
    consumedBy: { type: [String], required: false },
    quantity: {
      type: Number,
      required: true,
      default: 10,
    },
    status: {
      type: String,
      enum: ["inStock", "outOfStock"],
      default: "inStock",
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("SerialNumber", SerialNumberSchema);

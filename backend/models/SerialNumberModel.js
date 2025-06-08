const mongoose = require("mongoose");

const SerialNumberSchema = new mongoose.Schema(
  {
    serial_number: {
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
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("SerialNumber", SerialNumberSchema);

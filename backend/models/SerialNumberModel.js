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
    consumedBy: { type: String, required: false },
    status: {
      type: String,
      enum: ["inStock", "consumed"],
      default: "inStock",
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("SerialNumber", SerialNumberSchema);

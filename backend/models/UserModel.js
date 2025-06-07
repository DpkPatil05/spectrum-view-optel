const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
    unique: true,
  },
  commissionAmount: {
    type: Number,
    required: false,
  },
  consumedSerialNumbers: {
    type: [String],
    required: false,
  },
});

module.exports = mongoose.model("User", UserSchema);

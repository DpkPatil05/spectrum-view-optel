const User = require("../models/UserModel");
const bcrypt = require("bcrypt");

exports.loginController = async (req, res) => {
  const { userId, password } = req.body;
  console.log("Login attempt with userId:", userId);

  if (!userId || !password) {
    return res.status(400).json({
      success: false,
      message: "userId and password are required.",
    });
  }

  try {
    const user = await User.findOne({ userId });
    if (!user) {
      return res.status(401).json({
        success: false,
        message: "Invalid credentials.",
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid credentials.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Login successful.",
      user: {
        userId: user.userId,
        commissionAmount: user.commissionAmount,
        consumedSerialNumbers: user.consumedSerialNumbers,
      },
    });
  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error.",
    });
  }
};

// Simple regex to validate email format
const isValidEmail = (email) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

exports.registerController = async (req, res) => {
  const { userId, password } = req.body;

  if (!userId || !password) {
    return res.status(400).json({
      success: false,
      message: "userId and password are required.",
    });
  }

  if (!isValidEmail(userId)) {
    return res.status(400).json({
      success: false,
      message: "Invalid email format.",
    });
  }

  try {
    const existingUser = await User.findOne({ userId });
    if (existingUser) {
      return res.status(409).json({
        success: false,
        message: "User already exists.",
      });
    }

    const salt = await bcrypt.genSalt(12);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = new User({
      userId,
      password: hashedPassword,
      commissionAmount: 0,
      consumedSerialNumbers: [],
    });

    await newUser.save();

    return res.status(201).json({
      success: true,
      message: "User registered successfully.",
      user: {
        userId: newUser.userId,
        commissionAmount: newUser.commissionAmount,
        consumedSerialNumbers: newUser.consumedSerialNumbers,
      },
    });
  } catch (error) {
    console.error("Registration error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error.",
    });
  }
};

const SerialNumber = require("../models/SerialNumberModel");
const User = require("../models/UserModel");

/**
 * Controller to fetch the summary of serial numbers in stock and consumed.
 *
 * @async
 * @function getStockSummaryController
 * @param {Object} req - The request object.
 * @param {Object} res - The response object used to send back the result.
 *
 * @returns {void} Sends a JSON response containing inStock and outOfStock counts.
 *
 * @throws {Error} Returns a 500 status in case of server errors.
 */
exports.getStockSummaryController = async (req, res) => {
  try {
    // Get total in-stock quantity from all serial numbers
    const allSerials = await SerialNumber.find({}, "quantity");
    let inStock = allSerials.reduce(
      (sum, serial) => sum + (serial.quantity || 0),
      0
    );

    // Get all users and count consumed serial numbers
    const allUsers = await User.find({}, "consumedSerialNumbers");
    let consumed = allUsers.reduce(
      (sum, user) => sum + (user.consumedSerialNumbers?.length || 0),
      0
    );

    // Final response
    res.status(200).json({
      inStock,
      consumed,
      success: true,
    });
  } catch (error) {
    console.error("Error fetching stock summary:", error);
    res.status(500).json({
      error: "Internal server error",
      success: false,
    });
  }
};

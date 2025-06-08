const SerialNumber = require("../models/SerialNumberModel");

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
    const allSerials = await SerialNumber.find({}, "quantity consumedBy");

    let inStock = 0;
    let consumed = 0;

    allSerials.forEach((serial) => {
      inStock += serial.quantity;
      consumed += serial.consumedBy?.length || 0;
    });

    res.status(200).json({ inStock, consumed, success: true });
  } catch (error) {
    console.error("Error fetching stock summary:", error);
    res.status(500).json({ error: "Internal server error", success: false });
  }
};

/**
 * Controller to fetch the summary of serial numbers in stock and consumed.
 *
 * @async
 * @function getStockSummaryController
 * @param {Object} req - The request object.
 * @param {Object} res - The response object used to send back the result.
 *
 * @returns {void} Sends a JSON response containing inStock and consumed counts.
 *
 * @throws {Error} Returns a 500 status in case of server errors.
 */
export const getStockSummaryController = async (req, res) => {
  try {
    const inStock = await SerialNumber.countDocuments({ status: "inStock" });
    const consumed = await SerialNumber.countDocuments({ status: "consumed" });

    res.status(200).json({ inStock, consumed, success: true });
  } catch (error) {
    console.error("Error fetching stock summary:", error);
    res.status(500).json({ error: "Internal server error", success: false });
  }
};

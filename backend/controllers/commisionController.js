import UserSchema from "../models/UserModel";

/**
 * Controller to fetch the pending commission for a user based on their consumed serial numbers.
 *
 * @async
 * @function getPendingCommissionController
 * @param {Object} req - The request object containing parameters and other data.
 * @param {Object} req.params - The parameters from the request.
 * @param {string} req.params.userId - The ID of the user whose pending commission is to be fetched.
 * @param {Object} res - The response object used to send back the result.
 *
 * @returns {void} Sends a JSON response containing the pending commission amount and success status.
 *
 * @throws {Error} Returns a 400 status if the user ID is missing, or a 500 status in case of server errors.
 */
export const getPendingCommissionController = async (req, res) => {
  try {
    const userId = req.params.userId;

    // Validate userId
    if (!userId) {
      return res
        .status(400)
        .json({ error: "User ID is required", success: false });
    }

    // Fetch consumed serial numbers and calculate pending commission
    const consumedSerialNumbers = await UserSchema.find({
      userId,
      status: "consumed",
    });
    const pendingCommission = consumedSerialNumbers.reduce((total, serial) => {
      return total + serial.commissionAmount;
    }, 0);

    // Respond with the pending commission
    res
      .status(201)
      .json({ pendingCommission: pendingCommission, success: true });
  } catch (error) {
    console.error("Error fetching pending commission:", error);
    res.status(500).json({ error: "Internal server error", success: false });
  }
};

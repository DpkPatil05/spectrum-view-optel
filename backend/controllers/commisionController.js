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
    const pendingCommission = consumedSerialNumbers.reduce((_total, serial) => {
      return serial.commissionAmount;
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

/**
 * Controller to redeem accumulated commission points for a user.
 *
 * @async
 * @function redeemCommissionController
 * @param {Object} req - The request object containing parameters and body data.
 * @param {Object} req.params - The parameters from the request.
 * @param {string} req.params.userId - The ID of the user redeeming commission.
 * @param {Object} req.body - The request body containing points to redeem.
 * @param {number} req.body.pointsToRedeem - The number of points to redeem.
 * @param {Object} res - The response object used to send back the result.
 *
 * @returns {void} Sends a JSON response with redemption status and amount.
 */
export const redeemCommissionController = async (req, res) => {
  try {
    const userId = req.params.userId;
    const { pointsToRedeem } = req.body;

    if (!userId) {
      return res.status(400).json({
        success: false,
        message: "User ID is required",
        redeemedAmount: 0,
      });
    }
    if (!pointsToRedeem || isNaN(pointsToRedeem) || pointsToRedeem <= 0) {
      return res.status(400).json({
        success: false,
        message: "Valid pointsToRedeem is required",
        redeemedAmount: 0,
      });
    }

    // Fetch consumed serial numbers and calculate pending commission
    const consumedSerialNumbers = await UserSchema.find({
      userId,
      status: "consumed",
    });
    const pendingCommission = consumedSerialNumbers.reduce((_total, serial) => {
      return serial.commissionAmount;
    }, 0);

    if (pointsToRedeem > pendingCommission) {
      return res.status(400).json({
        success: false,
        message: "Insufficient pending commission points to redeem",
        redeemedAmount: 0,
      });
    }

    const pointsLeft = pendingCommission - pointsToRedeem;

    // Update the commissionAmount for the user's consumed serial numbers
    await UserSchema.update({ $set: { commissionAmount: pointsLeft } });

    res.status(200).json({
      success: true,
      message: "Commission points redeemed successfully",
      redeemedAmount: pointsToRedeem,
    });
  } catch (error) {
    console.error("Error redeeming commission:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
      redeemedAmount: 0,
    });
  }
};

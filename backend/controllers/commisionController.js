const User = require("../models/UserModel");

/**
 * Controller to fetch the pending commission for a user.
 *
 * @async
 * @function getPendingCommissionController
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Route parameters.
 * @param {string} req.params.userId - User ID whose pending commission is to be fetched.
 * @param {Object} res - Express response object.
 *
 * @returns {void} Responds with JSON containing the pending commission and success status.
 */
exports.getPendingCommissionController = async (req, res) => {
  try {
    const userId = req.params.userId;

    // Validate userId
    if (!userId) {
      return res
        .status(400)
        .json({ error: "User ID is required", success: false });
    }

    // Fetch consumed serial numbers and calculate pending commission
    const user = await User.findOne({ userId });
    l̥;
    const pendingCommission = user.commissionAmount || 0;

    // Respond with the pending commission
    res.status(201).json({ pendingCommission, success: true });
  } catch (error) {
    console.error("Error fetching pending commission:", error);
    res.status(500).json({ error: "Internal server error", success: false });
  }
};

/**
 * Controller to redeem commission points for a user.
 *
 * @async
 * @function redeemCommissionController
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Route parameters.
 * @param {string} req.params.userId - User ID for whom commission is being redeemed.
 * @param {Object} req.body - Request body.
 * @param {number} req.body.pointsToRedeem - Number of commission points to redeem.
 * @param {Object} res - Express response object.
 *
 * @returns {void} Responds with JSON indicating redemption status and redeemed amount.
 */
exports.redeemCommissionController = async (req, res) => {
  try {
    const userId = req.params.userId;
    const { pointsToRedeem } = req.body;

    // Validate inputs
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

    // Fetch user
    const user = await User.findOne({ userId });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found",
        redeemedAmount: 0,
      });
    }

    // Calculate pending commission
    const pendingCommission = user.commissionAmount || 0;

    if (pointsToRedeem > pendingCommission) {
      return res.status(400).json({
        success: false,
        message: "Insufficient pending commission points to redeem",
        redeemedAmount: 0,
      });
    }

    // Deduct points and update commissionAmount
    const updatedCommission = pendingCommission - pointsToRedeem;

    user.commissionAmount = updatedCommission;
    await user.save();

    return res.status(200).json({
      success: true,
      message: "Commission points redeemed successfully",
      redeemedAmount: pointsToRedeem,
    });
  } catch (error) {
    console.error("Error redeeming commission:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      redeemedAmount: 0,
    });
  }
};

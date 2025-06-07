const User = require("../models/UserModel");

/**
 * Controller to fetch a summary of users, including total sold items, claimed commission, and pending commission.
 *
 * @async
 * @function getUserSummaryController
 * @param {import('express').Request} req - Express request object.
 * @param {import('express').Response} res - Express response object.
 * @returns {Promise<void>} Sends a JSON response with user summary data or an error message.
 *
 * @throws {Error} Returns a 500 status code if an error occurs during data fetching.
 */
exports.getUserSummaryController = async (req, res) => {
  try {
    const users = await User.find();

    const summary = users.map((user) => {
      const totalSold = user.consumedSerialNumbers?.length || 0;
      const claimedCommission = user.commissionAmount || 0;
      const pendingCommission = totalSold - claimedCommission;

      return {
        userId: user.userId,
        totalSold,
        claimedCommission,
        pendingCommission,
      };
    });

    res.status(200).json({
      success: true,
      data: summary,
      message: "Data fetched successfully",
    });
  } catch (error) {
    console.error("Error fetching user summary:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

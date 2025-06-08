const SerialNumber = require("../models/SerialNumberModel");
const User = require("../models/UserModel");

/**
 * Handles the creation of a new serial number record in the database.
 *
 * This controller validates the request body to ensure `serialNumber` and `mrp` are provided.
 * If the `serialNumber` already exists, it returns an error response.
 * Otherwise, it creates a new serial number record with default values for `consumedBy`.
 * Additionally, it includes error handling for unique index violations and logs server errors.
 *
 * @async
 * @function postSerialNumberController
 * @param {Object} req - The HTTP request object.
 * @param {Object} req.body - The request body containing `serialNumber` and `mrp`.
 * @param {string} req.body.serialNumber - The serial number to be added.
 * @param {number} req.body.mrp - The MRP (Maximum Retail Price) associated with the serial number.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} Sends a JSON response indicating success or failure.
 *
 * @throws {Error} Returns a 400 status code if required fields are missing, the serial number already exists,
 * or violates unique constraints. Returns a 500 status code for unexpected server errors.
 */
exports.postSerialNumberController = async (req, res) => {
  const { serialNumber, mrp } = req.body;

  if (!serialNumber || !mrp) {
    return res
      .status(400)
      .json({ message: "serialNumber and mrp are required", success: false });
  }

  try {
    const existingSerial = await SerialNumber.findOne({ serialNumber });
    if (existingSerial) {
      return res.status(400).json({
        message: "This serial number already exists",
        data: {},
        success: false,
      });
    }

    const newSerial = new SerialNumber({
      serialNumber,
      mrp,
      consumedBy: "",
    });
    await newSerial.save();
    res.status(201).json({
      message: "Serial number added successfully",
      data: newSerial,
      success: true,
    });
  } catch (error) {
    // The pre-check above makes the duplicate error (11000) less likely for this specific field,
    // but this is still a good fallback for other potential unique index violations.
    if (error.code === 11000) {
      return res
        .status(400)
        .json({ message: "Serial number must be unique.", success: false });
    }
    console.error("Server Error:", error); // Log the detailed error
    res.status(500).json({ message: "An internal server error occurred." });
  }
};

/**
 * Controller to handle requests for retrieving serial number details.
 *
 * @async
 * @function getSerialNumberController
 * @param {Object} req - The request object from the client.
 * @param {Object} req.params - The parameters from the request URL.
 * @param {string} req.params.serialNumber - The serial number to be retrieved.
 * @param {Object} res - The response object to send data back to the client.
 *
 * @returns {void} Sends a JSON response with the serial number details if found,
 * or an appropriate error message if not found or if an error occurs.
 *
 * @throws {Error} Returns a 500 status code if an internal server error occurs.
 */
exports.getSerialNumberController = async (req, res) => {
  const { serialNumber } = req.params;

  if (!serialNumber) {
    return res
      .status(400)
      .json({ message: "SerialNumber is required", success: false });
  }

  try {
    const existingSerial = await SerialNumber.findOne({ serialNumber });
    if (!existingSerial) {
      return res.status(404).json({
        message: "Serial number not found.",
        data: { exists: false },
        success: false,
      });
    }
    return res.status(201).json({
      message: "Found serial number.",
      data: { exists: true, mrp: existingSerial.mrp },
      success: true,
    });
  } catch (error) {
    console.error("Server Error:", error); // Log the detailed error
    res
      .status(500)
      .json({ message: "An internal server error occurred.", success: false });
  }
};

/**
 * Handles the consumption of a serial number by a user.
 *
 * Validates that both `userId` and `serialNumber` are present in the request body.
 * Checks if the serial number exists and whether the user has already consumed it.
 * If not already consumed, adds the user to the `consumedBy` array, decrements quantity,
 * updates the serial number's status if needed, and awards commission to the user.
 *
 * @async
 * @function consumeSerialNumberController
 * @param {Object} req - Express request object containing `userId` and `serialNumber` in the body.
 * @param {Object} res - Express response object.
 * @returns {Promise<void>} Sends a JSON response indicating success, failure, and commission earned.
 *
 * @throws {Error} Returns a 400 or 404 status code for validation errors or missing resources,
 * and a 500 status code for unexpected server errors.
 */
exports.consumeSerialNumberController = async (req, res) => {
  const { userId, serialNumber } = req.body;

  if (!userId || !serialNumber) {
    return res.status(400).json({
      message: "userId and serialNumber are required",
      success: false,
    });
  }

  try {
    const existingSerial = await SerialNumber.findOne({
      serialNumber: serialNumber,
    });
    if (!existingSerial) {
      return res.status(404).json({
        message: "Serial number not found.",
        success: false,
        commissionEarned: 0,
      });
    }

    const user = await User.findOne({ userId });
    if (!user) {
      return res.status(404).json({
        message: "User not found.",
        success: false,
        commissionEarned: 0,
      });
    }

    let commissionEarned = 0;

    // Only award commission if user hasn't already consumed this serial
    const hasConsumedSerial = existingSerial.consumedBy?.includes(userId);
    if (!hasConsumedSerial) {
      commissionEarned = 1;

      existingSerial.consumedBy = existingSerial.consumedBy || [];
      existingSerial.consumedBy.push(userId);
    }

    // Add serialNumber to user's consumedSerialNumbers
    user.consumedSerialNumbers = user.consumedSerialNumbers || [];
    user.consumedSerialNumbers.push(serialNumber);

    // Decrement quantity
    existingSerial.quantity = Math.max((existingSerial.quantity || 0) - 1, 0);

    // Update status if quantity is 0
    if (existingSerial.quantity === 0) {
      existingSerial.status = "outOfStock";
    }

    // Save both documents
    await existingSerial.save();
    user.commissionAmount = (user.commissionAmount || 0) + commissionEarned;
    await user.save();

    return res.status(201).json({
      message: "Serial number successfully consumed.",
      success: true,
      commissionEarned,
    });
  } catch (error) {
    console.error("Server Error:", error);
    res.status(500).json({
      message: "An internal server error occurred.",
      success: false,
    });
  }
};

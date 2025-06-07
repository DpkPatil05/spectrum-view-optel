import SerialNumber from "../models/SerialNumberModel";
const User = require("../models/UserModel");

/**
 * Handles the creation of a new serial number record in the database.
 *
 * This controller validates the request body to ensure `serial_number` and `mrp` are provided.
 * If the `serial_number` already exists, it returns an error response.
 * Otherwise, it creates a new serial number record with default values for `consumedBy`.
 * Additionally, it includes error handling for unique index violations and logs server errors.
 *
 * @async
 * @function postSerialNumberController
 * @param {Object} req - The HTTP request object.
 * @param {Object} req.body - The request body containing `serial_number` and `mrp`.
 * @param {string} req.body.serial_number - The serial number to be added.
 * @param {number} req.body.mrp - The MRP (Maximum Retail Price) associated with the serial number.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} Sends a JSON response indicating success or failure.
 *
 * @throws {Error} Returns a 400 status code if required fields are missing, the serial number already exists,
 * or violates unique constraints. Returns a 500 status code for unexpected server errors.
 */
export const postSerialNumberController = async (req, res) => {
  const { serial_number, mrp } = req.body;

  if (!serial_number || !mrp) {
    return res
      .status(400)
      .json({ message: "serial_number and mrp are required", success: false });
  }

  try {
    const existingSerial = await SerialNumber.findOne({ serial_number });
    if (existingSerial) {
      return res.status(400).json({
        message: "This serial number already exists.",
        data: {},
        success: false,
      });
    }

    const newSerial = new SerialNumber({
      serial_number,
      mrp,
      consumedBy: [],
    });
    await newSerial.save();
    res.status(201).json({
      message: "Serial number added successfully.",
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
export const getSerialNumberController = async (req, res) => {
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
 * Controller to handle the consumption of a serial number by a user.
 *
 * This function validates the request body to ensure `userId` and `serialNumber` are provided.
 * It checks if the serial number exists and whether it has already been consumed by the user.
 * If valid, it marks the serial number as consumed by the user and updates the user's commission amount.
 *
 * @async
 * @function consumeSerialNumberController
 * @param {Object} req - The HTTP request object.
 * @param {Object} req.body - The request body containing `userId` and `serialNumber`.
 * @param {string} req.body.userId - The ID of the user consuming the serial number.
 * @param {string} req.body.serialNumber - The serial number to be consumed.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} Sends a JSON response indicating success or failure.
 *
 * @throws {Error} Returns a 500 status code if an internal server error occurs.
 */
export const consumeSerialNumberController = async (req, res) => {
  const { userId, serialNumber } = req.body;

  if (!userId || !serialNumber) {
    return res.status(400).json({
      message: "userId and serialNumber are required",
      success: false,
    });
  }

  try {
    const existingSerial = await SerialNumber.findOne({
      serial_number: serialNumber,
    });

    if (!existingSerial) {
      return res.status(404).json({
        message: "Serial number not found.",
        success: false,
        commissionEarned: 0,
      });
    }

    if (
      existingSerial.consumedBy &&
      existingSerial.consumedBy.includes(userId)
    ) {
      return res.status(400).json({
        message: "This serial number has already been consumed by this user.",
        success: false,
        commissionEarned: 0,
      });
    }

    // Mark the serial number as consumed by the user
    existingSerial.consumedBy = existingSerial.consumedBy || [];
    existingSerial.consumedBy.push(userId);
    await existingSerial.save();

    const commissionEarned = 10;

    // Update the user's commission in the UserSchema
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({
        message: "User not found.",
        success: false,
        commissionEarned: 0,
      });
    }

    user.commissionAmount = (user.commissionAmount || 0) + commissionEarned;
    await user.save();

    return res.status(201).json({
      message: "Serial number successfully consumed.",
      success: true,
      commissionEarned: commissionEarned,
    });
  } catch (error) {
    console.error("Server Error:", error); // Log the detailed error
    res
      .status(500)
      .json({ message: "An internal server error occurred.", success: false });
  }
};

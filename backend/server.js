require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors()); // Enable CORS for all routes
app.use(express.json()); // Middleware to parse JSON bodies

// --- Encapsulated DB Connection ---
const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("MongoDB Connected...");
  } catch (err) {
    console.error(`MongoDB Connection Error: ${err.message}`);
    // Exit process with failure code
    process.exit(1);
  }
};

app.use("/", require("./routes/index"));

// --- Start Server Function ---
const startServer = async () => {
  await connectDB(); // Ensure DB is connected before starting the server

  const PORT = process.env.PORT || 5000;
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
};

// --- Run the Application ---
startServer();

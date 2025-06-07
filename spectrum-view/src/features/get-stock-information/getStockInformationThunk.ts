import { getStockInformation } from "@/api/getStockInformation";
import { createAsyncThunk } from "@reduxjs/toolkit";

// Thunk to get stock information
export const getStockInformationThunk = createAsyncThunk(
  "verify/stock-summary",
  async (_, { rejectWithValue }) => {
    try {
      const response = await getStockInformation({
        rejectWithValue,
      });

      return response;
    } catch (error: unknown) {
      if (error instanceof Error) {
        return rejectWithValue(error.message);
      }
      return rejectWithValue("An unknown error occurred");
    }
  }
);

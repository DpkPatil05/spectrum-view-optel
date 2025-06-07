import { getMobileUsersSalesAndCommission } from "@/api/getMobileUsersSalesAndCommission";
import { createAsyncThunk } from "@reduxjs/toolkit";

// Thunk to get stock information
export const getMobileUsersSalesAndCommissionThunk = createAsyncThunk(
  "verify/users/summary",
  async (_, { rejectWithValue }) => {
    try {
      const response = await getMobileUsersSalesAndCommission({
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

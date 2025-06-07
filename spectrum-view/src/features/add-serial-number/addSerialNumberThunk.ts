import { createAsyncThunk } from "@reduxjs/toolkit";
import { SerialNumbersData } from "@/interfaces/SerialNumbersData";
import { postSerialNumber } from "@/api/postSerialNumber";

// Thunk to handle form submission
export const addSerialNumberThunk = createAsyncThunk(
  "verify/serial-numbers",
  async (formData: SerialNumbersData, { rejectWithValue }) => {
    try {
      const response = await postSerialNumber(formData, {
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

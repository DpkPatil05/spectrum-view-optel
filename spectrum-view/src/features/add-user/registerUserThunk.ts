import { createAsyncThunk } from "@reduxjs/toolkit";
import { AuthData } from "@/interfaces/AuthData";
import { registerUser } from "@/api/registerUser";

// Thunk to handle form submission
export const addUserThunk = createAsyncThunk(
  "auth/register",
  async (userData: AuthData, { rejectWithValue }) => {
    try {
      const response = await registerUser(userData, {
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

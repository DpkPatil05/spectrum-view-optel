import { createSlice } from "@reduxjs/toolkit";
import { AuthData } from "@/interfaces/AuthData";
import { addUserThunk } from "./registerUserThunk";

interface RegisterUserFormState {
  userData: AuthData;
  loading: boolean;
  success: boolean;
  error: string | null;
}

const initialState: RegisterUserFormState = {
  loading: false,
  success: false,
  error: null,
  userData: {
    userId: "",
    password: "",
  },
};

const registerUserSlice = createSlice({
  name: "registerUser",
  initialState,
  reducers: {
    setFormData(state, action) {
      state.userData = action.payload;
    },
    resetState: (state) => {
      state.userData = {
        userId: "",
        password: "",
      };
      state.loading = false;
      state.success = false;
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(addUserThunk.pending, (state) => {
        state.loading = true;
        state.success = false;
        state.error = null;
      })
      .addCase(addUserThunk.fulfilled, (state) => {
        state.loading = false;
        state.success = true;
        state.error = null;
      })
      .addCase(addUserThunk.rejected, (state, action) => {
        state.loading = false;
        state.success = false;
        state.error = action.payload as string;
      });
  },
});

export const { resetState, setFormData } = registerUserSlice.actions;

export default registerUserSlice.reducer;

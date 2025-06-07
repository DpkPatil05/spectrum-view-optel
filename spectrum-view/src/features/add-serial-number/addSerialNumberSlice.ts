import { SerialNumbersData } from "@/interfaces/SerialNumbersData";
import { createSlice } from "@reduxjs/toolkit";
import { addSerialNumberThunk } from "./addSerialNumberThunk";

interface AddSerialNumberFormState {
  formData: SerialNumbersData;
  loading: boolean;
  success: boolean;
  error: string | null;
}

const initialState: AddSerialNumberFormState = {
  loading: false,
  success: false,
  error: null,
  formData: {
    serial_number: "",
    mrp: "",
  },
};

const addSerialNumberSlice = createSlice({
  name: "addSerialNumber",
  initialState,
  reducers: {
    setFormData(state, action) {
      state.formData = action.payload;
    },
    resetState: (state) => {
      state.formData = {
        serial_number: "",
        mrp: "",
      };
      state.loading = false;
      state.success = false;
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(addSerialNumberThunk.pending, (state) => {
        state.loading = true;
        state.success = false;
        state.error = null;
      })
      .addCase(addSerialNumberThunk.fulfilled, (state) => {
        state.loading = false;
        state.success = true;
        state.error = null;
      })
      .addCase(addSerialNumberThunk.rejected, (state, action) => {
        state.loading = false;
        state.success = false;
        state.error = action.payload as string;
      });
  },
});

export const { resetState, setFormData } = addSerialNumberSlice.actions;

export default addSerialNumberSlice.reducer;

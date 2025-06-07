import { createSlice } from "@reduxjs/toolkit";
import { getStockInformationThunk } from "./getStockInformationThunk";

interface GetStockInformationState {
  inStock: number | null;
  consumed: number | null;
  loading: boolean;
  success: boolean;
  error: string | null;
}

const initialState: GetStockInformationState = {
  loading: false,
  success: false,
  error: null,
  inStock: 0,
  consumed: 0,
};

const getStockInformationSlice = createSlice({
  name: "getStockInformation",
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(getStockInformationThunk.pending, (state) => {
        state.loading = true;
        state.success = false;
        state.error = null;
      })
      .addCase(getStockInformationThunk.fulfilled, (state, action) => {
        state.loading = false;
        state.success = true;
        state.inStock = action.payload.inStock;
        state.consumed = action.payload.consumed;
      })
      .addCase(getStockInformationThunk.rejected, (state, action) => {
        state.loading = false;
        state.success = false;
        state.error = action.payload as string;
      });
  },
});

export default getStockInformationSlice.reducer;

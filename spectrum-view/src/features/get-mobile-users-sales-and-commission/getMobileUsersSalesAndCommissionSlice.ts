import { createSlice } from "@reduxjs/toolkit";
import { getMobileUsersSalesAndCommissionThunk } from "./getMobileUsersSalesAndCommissionThunk";

interface GetMobileUsersSalesAndCommissionState {
  data: Array<{
    userId: string;
    totalSold: number;
    claimedCommission: number;
    pendingCommission: number;
  }>;
  loading: boolean;
  success: boolean;
  error: string | null;
}

const initialState: GetMobileUsersSalesAndCommissionState = {
  data: [],
  loading: false,
  success: false,
  error: null,
};

const getMobileUsersSalesAndCommissionSlice = createSlice({
  name: "getMobileUsersSalesAndCommission",
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(getMobileUsersSalesAndCommissionThunk.pending, (state) => {
        state.loading = true;
        state.success = false;
        state.error = null;
      })
      .addCase(
        getMobileUsersSalesAndCommissionThunk.fulfilled,
        (state, action) => {
          state.loading = false;
          state.success = true;
          state.data = action.payload.data;
        }
      )
      .addCase(
        getMobileUsersSalesAndCommissionThunk.rejected,
        (state, action) => {
          state.loading = false;
          state.success = false;
          state.error = action.payload as string;
        }
      );
  },
});

export default getMobileUsersSalesAndCommissionSlice.reducer;

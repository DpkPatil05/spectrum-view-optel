import { configureStore } from "@reduxjs/toolkit";
import addSerialNumberReducer from "../features/add-serial-number/addSerialNumberSlice";
import getStockInformationReducer from "../features/get-stock-information/getStockInformationSlice";
import getMobileUsersSalesAndCommissionReducer from "../features/get-mobile-users-sales-and-commission/getMobileUsersSalesAndCommissionSlice";
import registerUserReducer from "../features/add-user/registerUserSlice";

export const store = configureStore({
  reducer: {
    registerUser: registerUserReducer,
    addSerialNumber: addSerialNumberReducer,
    getStockInformation: getStockInformationReducer,
    getMobileUsersSalesAndCommission: getMobileUsersSalesAndCommissionReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

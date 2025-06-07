import { configureStore } from "@reduxjs/toolkit";
import addSerialNumberReducer from "../features/add-serial-number/addSerialNumberSlice";
import getStockInformationReducer from "../features/get-stock-information/getStockInformationSlice";

export const store = configureStore({
  reducer: {
    addSerialNumber: addSerialNumberReducer,
    getStockInformation: getStockInformationReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

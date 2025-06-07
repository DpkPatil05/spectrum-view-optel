import { configureStore } from "@reduxjs/toolkit";
import addSerialNumberReducer from "../features/add-serial-number/addSerialNumberSlice";

export const store = configureStore({
  reducer: {
    addSerialNumber: addSerialNumberReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

import { axiosInstance } from "./axiosInstance";

export const getStockInformation = async ({
  rejectWithValue,
}: {
  rejectWithValue: (value: string) => void;
}) => {
  try {
    const response = await axiosInstance.get("/verify/stock-summary");

    return response.data;
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (error: any) {
    if (error.response && error.response.status === 400) {
      return error.response.data;
    }
    if (error instanceof Error) {
      return rejectWithValue(error.message);
    }
    return rejectWithValue("An unknown error occurred");
  }
};

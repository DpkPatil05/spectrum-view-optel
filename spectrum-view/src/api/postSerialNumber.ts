import { SerialNumbersData } from "@/interfaces/SerialNumbersData";
import { axiosInstance } from "./axiosInstance";

export const postSerialNumber = async (
  formData: SerialNumbersData,
  { rejectWithValue }: { rejectWithValue: (value: string) => void }
) => {
  try {
    const response = await axiosInstance.post("/verify/serial-numbers", {
      serial_number: formData.serial_number.trim(),
      mrp: parseFloat((formData.mrp ?? "0").toString()),
    });

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

import { SerialNumbersData } from "@/interfaces/SerialNumbersData";
import { axiosInstance } from "./axiosInstance";

export const postSerialNumber = async (
  formData: SerialNumbersData,
  { rejectWithValue }: { rejectWithValue: (value: string) => void }
) => {
  try {
    const response = await axiosInstance.post("/serial-numbers", {
      serial_number: formData.serial_number.trim(),
      mrp: parseFloat((formData.mrp ?? "0").toString()),
    });

    return response.data;
  } catch (error: unknown) {
    if (error instanceof Error) {
      return rejectWithValue(error.message);
    }
    return rejectWithValue("An unknown error occurred");
  }
};

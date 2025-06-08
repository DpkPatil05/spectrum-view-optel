import { axiosInstance } from "./axiosInstance";
import { AuthData } from "@/interfaces/AuthData";

export const registerUser = async (
  userData: AuthData,
  { rejectWithValue }: { rejectWithValue: (value: string) => void }
) => {
  try {
    const response = await axiosInstance.post("/auth/register", {
      userId: userData.userId.trim(),
      password: userData.password.trim(),
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

import axios from "axios";

const apiUrl = import.meta.env.VITE_BASE_URL;

const axiosInstance = axios.create({
  baseURL: apiUrl,
});

axiosInstance.interceptors.request.use(
  (config) => {
    config.headers.Accept = "application/json";
    config.headers["Content-Type"] = "application/json";
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export { axiosInstance };

export const axiosS3Instance = axios.create();

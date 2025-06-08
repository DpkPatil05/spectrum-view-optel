import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { toast } from "sonner";
import PrimaryButton from "@/components/PrimaryButton";
import PrimaryInputField from "@/components/PrimaryInputField";
import { addUserThunk } from "@/features/add-user/registerUserThunk";
import { AppDispatch } from "@/store";
import { useDispatch } from "react-redux";
import { resetState } from "@/features/add-serial-number/addSerialNumberSlice";

const AddUsers: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();
  const [userData, setFormData] = useState({
    userId: "",
    password: "",
  });

  const [errors, setErrors] = useState({
    userId: "",
    password: "",
  });

  const [loading, setLoading] = useState(false);

  const validateForm = (): boolean => {
    const newErrors: typeof errors = { userId: "", password: "" };
    let isValid = true;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(userData.userId)) {
      newErrors.userId = "Invalid email format.";
      isValid = false;
    }

    if (userData.password.length < 6) {
      newErrors.password = "Password must be at least 6 characters.";
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
    setErrors((prev) => ({ ...prev, [name]: "" }));
  };

  const handleReset = () => {
    dispatch(resetState());
    setErrors({ userId: "", password: "" });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      toast.error("Please fix validation errors before submitting.");
      return;
    }

    setLoading(true);
    try {
      const result = await dispatch(addUserThunk(userData)).unwrap();
      if (result && result.success) {
        toast.success("User added successfully.");
        handleReset();
      } else {
        toast.error(result?.message || "Failed to add user.");
      }
    } catch {
      toast.error("Something went wrong.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-full h-full flex justify-center items-start px-4 md:px-0">
      <Card className="w-full max-w-md bg-white/10 backdrop-blur-md border border-white/20 shadow-2xl rounded-xl mt-6 text-white">
        <CardHeader>
          <CardTitle className="text-2xl font-semibold">
            Create Account
          </CardTitle>
          <p className="text-sm text-gray-200">
            Register using your email and password.
          </p>
        </CardHeader>

        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-6">
            <PrimaryInputField
              id="email"
              label="Email"
              name="userId"
              placeholder="you@example.com"
              value={userData.userId}
              onChange={handleChange}
              errors={errors.userId}
            />
            <PrimaryInputField
              id="password"
              label="Password"
              name="password"
              type="password"
              placeholder="Enter a secure password"
              value={userData.password}
              onChange={handleChange}
              errors={errors.password}
            />

            <PrimaryButton type="submit" disabled={loading} className="w-full">
              {loading ? "Registering..." : "Register"}
            </PrimaryButton>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default AddUsers;

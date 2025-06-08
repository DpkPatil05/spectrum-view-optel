import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { toast } from "sonner";
import PrimaryButton from "@/components/PrimaryButton";
import PrimaryInputField from "@/components/PrimaryInputField";
import { SerialNumbersData } from "@/interfaces/SerialNumbersData";
import { useDispatch, useSelector } from "react-redux";
import { AppDispatch, RootState } from "@/store";
import {
  resetState,
  setFormData,
} from "@/features/add-serial-number/addSerialNumberSlice";
import { addSerialNumberThunk } from "@/features/add-serial-number/addSerialNumberThunk";

const AddSerialNumberPage: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();

  const { formData, loading, error } = useSelector(
    (state: RootState) => state.addSerialNumber
  );

  const [errors, setErrors] = useState<Partial<SerialNumbersData>>({
    serialNumber: "",
    mrp: "",
  });

  const validateForm = (): boolean => {
    const newErrors: Partial<SerialNumbersData> = {};
    let isValid = true;

    if (formData.serialNumber.trim().length < 5) {
      newErrors.serialNumber =
        "Serial number must be at least 5 characters long.";
      isValid = false;
    }

    if (!formData.mrp || isNaN(parseFloat(formData.mrp.toString()))) {
      newErrors.mrp = "Cost is required and must be a valid number.";
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    dispatch(setFormData({ ...formData, [name]: value }));
    setErrors((prev) => ({ ...prev, [name]: "" }));
  };

  const handleReset = () => {
    dispatch(resetState());
    setErrors({ serialNumber: "", mrp: "" });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      toast.error("Please fix validation errors before submitting.");
      return;
    }

    try {
      // Submit to mongo DB
      const numericMrp = parseFloat((formData.mrp ?? "0").toString());
      if (isNaN(numericMrp)) {
        toast.error("MRP must be a valid number.");
        return;
      }
      const result = await dispatch(addSerialNumberThunk(formData)).unwrap();
      if (result && result.success) {
        toast.success("Serial number added successfully.");
        handleReset();
      } else {
        toast.error(result?.message || "Failed to add serial number.");
      }
    } catch (error) {
      toast.error((error as Error).message || "Something went wrong.");
    }
  };

  return (
    <div className="w-full h-full flex justify-center items-start px-4 md:px-0">
      <Card className="w-full max-w-2xl bg-white/10 backdrop-blur-md border border-white/20 shadow-2xl rounded-xl mt-6 text-white">
        <CardHeader>
          <CardTitle className="text-2xl font-semibold">
            Add New Serial Number
          </CardTitle>
          <p className="text-sm text-gray-200">
            Fill in the details to register a new product.
          </p>
        </CardHeader>

        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-6">
            <PrimaryInputField
              id="serialNumber"
              label=" Serial Number"
              name="serialNumber"
              placeholder="e.g. SN123456789"
              value={formData.serialNumber}
              onChange={handleChange}
              errors={errors.serialNumber}
            />
            <PrimaryInputField
              id="cost"
              label="MRP"
              name="mrp"
              placeholder="e.g. 299.99"
              value={formData.mrp?.toString() || ""}
              onChange={handleChange}
              errors={errors.mrp?.toString() || ""}
            />

            {error && (
              <p className="text-sm text-red-400 font-medium">{error}</p>
            )}

            <PrimaryButton type="submit" disabled={loading} className="w-full">
              {loading ? "Submitting..." : "Submit"}
            </PrimaryButton>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default AddSerialNumberPage;

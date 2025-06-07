import React from "react";
import { Input } from "./ui/input";
import { FormItem } from "./ui/form";
import { Label } from "./ui/label";

interface PrimaryInputFieldProps {
  label?: string;
  className?: string;
  errors?: string;
  [key: string]: unknown;
}

const PrimaryInputField: React.FC<PrimaryInputFieldProps> = ({
  label,
  className,
  errors,
  ...props
}) => {
  const inputClass = `p-6 rounded-lg bg-gray-700 border border-primary text-white placeholder-gray-400 ${
    errors && "border-red-500"
  }`;

  return (
    <FormItem className="place-items-start">
      <Label className="pb-2 mb-2">{label}</Label>
      <Input className={`${inputClass} ${className}`} {...props} />
      {errors && <p className="text-red-500 text-sm">{errors}</p>}
    </FormItem>
  );
};

export default PrimaryInputField;

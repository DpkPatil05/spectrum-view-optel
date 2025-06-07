import React from "react";
import { Input } from "./ui/input";
import { FormItem } from "./ui/form";
import { Label } from "./ui/label";
import { cn } from "@/lib/utils";

interface PrimaryInputFieldProps
  extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  className?: string;
  errors?: string;
}

const PrimaryInputField: React.FC<PrimaryInputFieldProps> = ({
  label,
  className,
  errors,
  type = "text",
  ...props
}) => {
  return (
    <FormItem className="place-items-start w-full">
      {label && <Label className="pb-2 mb-2">{label}</Label>}
      <Input
        type={type}
        className={cn(
          "p-6 rounded-lg bg-gray-700 border text-white placeholder-gray-400",
          errors ? "border-red-500" : "border-primary",
          className
        )}
        {...props}
      />
      {errors && <p className="text-red-500 text-sm mt-1">{errors}</p>}
    </FormItem>
  );
};

export default PrimaryInputField;

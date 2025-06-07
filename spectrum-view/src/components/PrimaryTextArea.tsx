import React from "react";
import { FormItem } from "./ui/form";
import { Label } from "./ui/label";
import { Textarea } from "./ui/textarea";

interface PrimaryTextAreaProps {
  label?: string;
  className?: string;
  errors?: string;
  [key: string]: unknown;
}

const PrimaryTextArea: React.FC<PrimaryTextAreaProps> = ({
  label,
  className,
  errors,
  ...props
}) => {
  const inputClass = `p-6 rounded-lg bg-gray-700 text-white placeholder-gray-400 ${
    errors && "border border-red-500"
  }`;

  return (
    <FormItem className="place-items-start">
      {label && <Label>{label}</Label>}
      <Textarea rows={4} className={`${inputClass} ${className}`} {...props} />
      {errors && <p className="text-red-500 text-sm">{errors}</p>}
    </FormItem>
  );
};

export default PrimaryTextArea;

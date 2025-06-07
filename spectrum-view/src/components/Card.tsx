import React from "react";
import { cn } from "@/lib/utils";

interface CardProps {
  title: string;
  value: string | number;
  className?: string;
}

const Card: React.FC<CardProps> = ({ title, value, className }) => (
  <div
    className={cn(
      "bg-card p-4 rounded-lg shadow-sm border border-border",
      className
    )}
  >
    <h3 className="text-sm text-gray-600 mb-2">{title}</h3>
    <p className="text-2xl font-semibold">{value}</p>
  </div>
);

export default Card;

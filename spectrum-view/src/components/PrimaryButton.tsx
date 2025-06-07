import { Button, ButtonProps } from "@/components/ui/button";
import React from "react";

const PrimaryButton: React.FC<ButtonProps> = ({
  children,
  onClick,
  className,
  ...props
}) => {
  const buttonClass =
    "relative px-6 py-3 my-2 flex items-center justify-center gap-3 text-primary-foreground font-semibold bg-primary/20 border border-primary rounded-lg backdrop-blur-lg transition-all duration-300 ease-in-out transform hover:scale-105 hover:bg-primary/30 hover:border-secondary focus:ring-2 focus:ring-primary/60 drop-shadow-[0_5px_15px_rgba(26,115,232,0.3)] after:absolute after:inset-0 after:rounded-lg after:bg-primary/40 after:blur-lg after:opacity-0 after:transition-opacity after:duration-500 hover:after:opacity-30 active:scale-95";

  return (
    <Button
      onClick={onClick}
      className={`${buttonClass} ${className}`}
      {...props}
    >
      {children}
    </Button>
  );
};

export default PrimaryButton;

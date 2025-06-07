import { cn } from "@/lib/utils"; // or use clsx directly

interface NavItemProps {
  icon: React.ReactNode;
  label: string;
  onClick?: () => void;
  className?: string;
}

const NavItem: React.FC<NavItemProps> = ({
  icon,
  label,
  onClick,
  className,
}) => (
  <button
    onClick={onClick}
    className={cn(
      "flex items-center gap-2 px-3 py-2 rounded-md text-sm font-medium transition-colors hover:bg-muted",
      className
    )}
  >
    {icon}
    {label}
  </button>
);

export default NavItem;

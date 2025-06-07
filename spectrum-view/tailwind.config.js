/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ["class"],
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        // Restore your original theme colors
        primary: {
          DEFAULT: "#1A73E8", // Your original primary color
          foreground: "#ffffff", // Assuming white foreground for primary
        },
        secondary: {
          DEFAULT: "#34A853", // Your original secondary color
          foreground: "#ffffff", // Assuming white foreground for secondary
        },
        tertiary: "#FBBC05",
        background: "#0b1120", // Your original background color
        "dark-navy-blue": "#1a2a44",
        foreground: "#ffffff", // Assuming white foreground globally
        card: {
          DEFAULT: "#1e293b", // Dark card background
          foreground: "#ffffff", // Foreground for cards
        },
        popover: {
          DEFAULT: "#1f2937", // Assuming popover uses dark gray
          foreground: "#ffffff",
        },
        muted: {
          DEFAULT: "#6b7280", // Muted gray color
          foreground: "#e5e7eb", // Light gray foreground
        },
        accent: {
          DEFAULT: "#3b82f6", // Blue for accents
          foreground: "#ffffff",
        },
        destructive: {
          DEFAULT: "#ef4444", // Red for destructive actions
          foreground: "#ffffff",
        },
        border: "#d1d5db", // Light border color
        input: "#374151", // Input background
        ring: "#3b82f6", // Blue ring color
        chart: {
          1: "#1E3A8A", // Chart colors
          2: "#9333EA",
          3: "#10B981",
          4: "#F59E0B",
          5: "#EF4444",
        },
        "cityscape-text": "#e5e7eb",
      },
      backdropBlur: {
        xs: "2px",
        sm: "4px",
        md: "8px",
        lg: "12px",
        xl: "16px",
      },
      borderRadius: {
        lg: "16px", // Customize radius as per original theme
        md: "12px",
        sm: "8px",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};

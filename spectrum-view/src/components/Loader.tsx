import { motion } from "framer-motion";

const Loader = () => {
  return (
    <div
      role="status"
      aria-live="polite"
      className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-75 z-50"
    >
      <div className="relative flex items-center justify-center w-32 h-32">
        <span className="sr-only">Loading...</span>

        {/* Pulsating Rings */}
        <motion.div
          className="absolute w-20 h-20 border-4 border-tertiary rounded-full"
          animate={{ scale: [1, 1.4, 1], opacity: [0.7, 0.3, 0.7] }}
          transition={{ repeat: Infinity, duration: 1.5, ease: "easeInOut" }}
        />
        <motion.div
          className="absolute w-28 h-28 border-4 border-secondary rounded-full"
          animate={{ scale: [1, 1.6, 1], opacity: [0.6, 0.2, 0.6] }}
          transition={{ repeat: Infinity, duration: 1.5, ease: "easeInOut", delay: 0.3 }}
        />
        <motion.div
          className="absolute w-32 h-32 border-4 border-primary rounded-full"
          animate={{ scale: [1, 1.8, 1], opacity: [0.5, 0.1, 0.5] }}
          transition={{ repeat: Infinity, duration: 1.5, ease: "easeInOut", delay: 0.6 }}
        />

        {/* Circular Moving Text with Color Animation */}
        <motion.svg
          className="absolute w-48 h-48"
          viewBox="0 0 120 120"
          animate={{ rotate: 360 }}
          transition={{ repeat: Infinity, duration: 3.5, ease: "anticipate" }}
        >
          <path
            id="textPath"
            d="M 60,60 m -45,0 a 45,45 0 1,1 90,0 a 45,45 0 1,1 -90,0"
            fill="transparent"
          />
          <motion.text
            className="text-xs font-bold"
            animate={{
              fill: ["#3b82f6", "#34a853", "#fbbc05"], // Primary, Secondary, Tertiary
            }}
            transition={{ repeat: Infinity, duration: 3, ease: "easeInOut" }}
          >
            <textPath href="#textPath" startOffset="0%">
              Loading... or buffering life? 🤔
            </textPath>
          </motion.text>
        </motion.svg>
      </div>
    </div>
  );
};

export default Loader;

import React, { useEffect } from "react";
import { getStockInformationThunk } from "@/features/get-stock-information/getStockInformationThunk";
import { useDispatch, useSelector } from "react-redux";
import { AppDispatch, RootState } from "@/store";
import Card from "@/components/Card";

const DashboardPage: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();
  const { inStock, consumed, loading, error } = useSelector(
    (state: RootState) => state.getStockInformation
  );

  // Initial fetch + auto-refresh every 30 seconds
  useEffect(() => {
    dispatch(getStockInformationThunk()); // initial call

    const interval = setInterval(() => {
      dispatch(getStockInformationThunk()); // fetch again every 30 seconds
    }, 30000); // 30,000ms = 30 seconds

    return () => clearInterval(interval); // cleanup on unmount
  }, [dispatch]);

  return (
    <div className="grid gap-4 grid-cols-1 md:grid-cols-2 xl:grid-cols-3">
      <Card
        title="In Stock"
        value={loading ? "Loading..." : inStock?.toLocaleString() || "0"}
        className="bg-green-100 text-green-900 border-green-300"
      />

      <Card
        title="Consumed"
        value={loading ? "Loading..." : consumed?.toLocaleString() || "0"}
        className="bg-blue-100 text-blue-900 border-blue-300"
      />

      {error && (
        <div className="col-span-full text-red-500 font-medium">
          Error: {error}
        </div>
      )}
    </div>
  );
};

export default DashboardPage;

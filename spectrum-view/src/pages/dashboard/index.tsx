import React, { useEffect } from "react";
import { getStockInformationThunk } from "@/features/get-stock-information/getStockInformationThunk";
import { useDispatch, useSelector } from "react-redux";
import { AppDispatch, RootState } from "@/store";
import Card from "@/components/Card";
const Dashboard: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();
  const { inStock, consumed, loading, error } = useSelector(
    (state: RootState) => state.getStockInformation
  );

  useEffect(() => {
    dispatch(getStockInformationThunk());
  }, [dispatch]);

  return (
    <div className="grid gap-4 grid-cols-1 md:grid-cols-2 xl:grid-cols-3">
      <Card
        title="In Stock"
        value={loading ? "Loading..." : inStock?.toLocaleString() || "0"}
      />
      <Card
        title="Consumed"
        value={loading ? "Loading..." : consumed?.toLocaleString() || "0"}
      />
      {error && (
        <div className="col-span-full text-red-500 font-medium">
          Error: {error}
        </div>
      )}
    </div>
  );
};

export default Dashboard;

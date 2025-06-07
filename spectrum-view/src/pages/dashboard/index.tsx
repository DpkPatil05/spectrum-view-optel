import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { AppDispatch, RootState } from "@/store";
import { getStockInformationThunk } from "@/features/get-stock-information/getStockInformationThunk";
import Card from "@/components/Card";
import { getMobileUsersSalesAndCommissionThunk } from "@/features/get-mobile-users-sales-and-commission/getMobileUsersSalesAndCommissionThunk";

type SortKey =
  | "userId"
  | "totalSold"
  | "claimedCommission"
  | "pendingCommission";
type SortOrder = "asc" | "desc";

const DashboardPage: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();

  const {
    inStock,
    consumed,
    loading: stockLoading,
    error: stockError,
  } = useSelector((state: RootState) => state.getStockInformation);

  const {
    data: mobileUsers,
    loading: userLoading,
    error: userError,
  } = useSelector((state: RootState) => state.getMobileUsersSalesAndCommission);

  const [sortKey, setSortKey] = useState<SortKey>("totalSold");
  const [sortOrder, setSortOrder] = useState<SortOrder>("desc");

  useEffect(() => {
    dispatch(getStockInformationThunk());
    dispatch(getMobileUsersSalesAndCommissionThunk());

    const interval = setInterval(() => {
      dispatch(getStockInformationThunk());
      dispatch(getMobileUsersSalesAndCommissionThunk());
    }, 30000);

    return () => clearInterval(interval);
  }, [dispatch]);

  const sortedData = [...mobileUsers].sort((a, b) => {
    const valueA = a[sortKey];
    const valueB = b[sortKey];

    if (valueA < valueB) return sortOrder === "asc" ? -1 : 1;
    if (valueA > valueB) return sortOrder === "asc" ? 1 : -1;
    return 0;
  });

  const handleSort = (key: SortKey) => {
    if (sortKey === key) {
      setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortOrder("asc");
    }
  };

  return (
    <div className="space-y-6">
      {/* Cards */}
      <div className="grid gap-4 grid-cols-1 md:grid-cols-2 xl:grid-cols-3">
        <Card
          title="In Stock"
          value={stockLoading ? "Loading..." : inStock?.toLocaleString() || "0"}
          className="bg-green-100 text-green-900 border-green-300"
        />
        <Card
          title="Consumed"
          value={
            stockLoading ? "Loading..." : consumed?.toLocaleString() || "0"
          }
          className="bg-blue-100 text-blue-900 border-blue-300"
        />
      </div>

      {/* Error */}
      {(stockError || userError) && (
        <div className="text-red-500 font-medium">
          {stockError && <div>Error fetching stock: {stockError}</div>}
          {userError && <div>Error fetching mobile user data: {userError}</div>}
        </div>
      )}

      {/* Table */}
      <div className="bg-white/5 border border-white/10 rounded-xl overflow-auto">
        <table className="w-full text-sm text-left">
          <thead className="bg-white/10 text-white">
            <tr>
              <th
                className="px-4 py-2 cursor-pointer"
                onClick={() => handleSort("userId")}
              >
                Painter ID{" "}
                {sortKey === "userId" && (sortOrder === "asc" ? "↑" : "↓")}
              </th>
              <th
                className="px-4 py-2 cursor-pointer"
                onClick={() => handleSort("totalSold")}
              >
                Total Sold{" "}
                {sortKey === "totalSold" && (sortOrder === "asc" ? "↑" : "↓")}
              </th>
              <th
                className="px-4 py-2 cursor-pointer"
                onClick={() => handleSort("claimedCommission")}
              >
                Claimed ₹{" "}
                {sortKey === "claimedCommission" &&
                  (sortOrder === "asc" ? "↑" : "↓")}
              </th>
              <th
                className="px-4 py-2 cursor-pointer"
                onClick={() => handleSort("pendingCommission")}
              >
                Pending ₹{" "}
                {sortKey === "pendingCommission" &&
                  (sortOrder === "asc" ? "↑" : "↓")}
              </th>
            </tr>
          </thead>
          <tbody className="divide-y divide-white/10 text-white">
            {userLoading ? (
              <tr>
                <td colSpan={4} className="px-4 py-4 text-center">
                  Loading data...
                </td>
              </tr>
            ) : sortedData.length === 0 ? (
              <tr>
                <td
                  colSpan={4}
                  className="px-4 py-4 text-center text-muted-foreground"
                >
                  No painters found.
                </td>
              </tr>
            ) : (
              sortedData.map((user) => (
                <tr key={user.userId}>
                  <td className="px-4 py-2">{user.userId}</td>
                  <td className="px-4 py-2">{user.totalSold}</td>
                  <td className="px-4 py-2">
                    ₹ {user.claimedCommission.toLocaleString()}
                  </td>
                  <td className="px-4 py-2">
                    ₹ {user.pendingCommission.toLocaleString()}
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default DashboardPage;

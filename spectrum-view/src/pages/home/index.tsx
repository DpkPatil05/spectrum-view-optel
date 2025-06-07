import React from "react";
import Card from "@/components/Card";

const Home: React.FC = () => {
  return (
    <div className="grid gap-4 grid-cols-1 md:grid-cols-2 xl:grid-cols-3">
      <Card title="Total Users" value="1,230" />
      <Card title="Monthly Revenue" value="$12,450" />
      <Card title="Active Sessions" value="87" />
    </div>
  );
};

export default Home;

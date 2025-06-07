import { FC, useState } from "react";
import {
  LayoutDashboard,
  Settings,
  LogOut,
  UserCircle,
  PlusCircle,
} from "lucide-react";
import NavItem from "@/components/NavItem";
import AddSerialNumberForm from "../add-serial-number";
import Home from "../home";
import { NavItems } from "@/constants";
import { Toaster } from "sonner";

const Dashboard: FC = () => {
  const [activeView, setActiveView] = useState<NavItems>(NavItems.Dashboard);

  return (
    <div className="min-h-screen flex bg-gradient-to-br from-[#0b1120] via-[#111827] to-[#0b1120] text-foreground">
      {/* Sidebar */}
      <aside className="w-64 hidden md:flex flex-col border-r border-white/10 bg-white/5 backdrop-blur-md shadow-md rounded-r-xl">
        <div className="p-6 text-xl font-bold text-white">SpectrumView</div>
        <nav className="flex flex-col gap-2 px-4">
          <NavItem
            icon={<LayoutDashboard className="w-5 h-5" />}
            label="Dashboard"
            onClick={() => setActiveView(NavItems.Dashboard)}
            className={`transition-colors ${
              activeView === NavItems.Dashboard
                ? "bg-white/10 text-white"
                : "text-muted"
            } hover:text-white`}
          />

          <NavItem
            icon={<PlusCircle className="w-5 h-5" />}
            label="Add Products"
            onClick={() => setActiveView(NavItems.AddProducts)}
            className={`transition-colors ${
              activeView === NavItems.AddProducts
                ? "bg-white/10 text-white"
                : "text-muted"
            } hover:text-white`}
          />

          <NavItem
            icon={<Settings className="w-5 h-5" />}
            label="Settings"
            onClick={() => setActiveView(NavItems.Settings)}
            className={`transition-colors ${
              activeView === NavItems.Settings
                ? "bg-white/10 text-white"
                : "text-muted"
            } hover:text-white`}
          />

          <NavItem
            icon={<LogOut className="w-5 h-5" />}
            label="Logout"
            onClick={() => setActiveView(NavItems.Logout)}
            className={`transition-colors ${
              activeView === NavItems.Logout
                ? "bg-white/10 text-white"
                : "text-muted"
            } hover:text-white`}
          />
        </nav>
      </aside>

      {/* Main Content */}
      <main className="flex-1 flex flex-col">
        {/* Header */}
        <header className="h-16 flex items-center justify-between px-6 border-b border-white/10 bg-white/5 backdrop-blur-md shadow-sm">
          <h1 className="text-lg font-semibold capitalize text-white">
            {activeView}
          </h1>
          <div className="flex items-center gap-2 text-white">
            <UserCircle className="w-8 h-8 text-white/60" />
            <span className="text-sm">John Doe</span>
          </div>
        </header>

        {/* Body */}
        <div className="p-6 backdrop-blur-md bg-white/5 shadow-xl rounded-lg m-4 border border-white/10 min-h-[calc(100vh-96px)]">
          <Toaster richColors position="bottom-right" closeButton />
          {activeView === NavItems.Dashboard && <Home />}
          {activeView === NavItems.AddProducts && <AddSerialNumberForm />}
          {activeView === NavItems.Settings && (
            <div className="text-muted-foreground">Settings coming soon...</div>
          )}
          {activeView === NavItems.Logout && (
            <div className="text-muted-foreground">Logging out...</div>
          )}
        </div>
      </main>
    </div>
  );
};

export default Dashboard;

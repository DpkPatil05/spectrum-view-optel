import { FC, useState } from "react";
import {
  LayoutDashboard,
  Settings,
  LogOut,
  UserCircle,
  PlusCircle,
} from "lucide-react";
import { useNavigate } from "react-router-dom";
import NavItem from "@/components/NavItem";
import AddSerialNumberPage from "../add-serial-number";
import { NavItems } from "@/constants";
import { Toaster } from "sonner";
import DashboardPage from "../dashboard";
import {
  AlertDialog,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogCancel,
  AlertDialogAction,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import useCovidData from "@/hooks/useCovidData";
import Loader from "@/components/Loader";

const HomePage: FC = () => {
  const [activeView, setActiveView] = useState<NavItems>(NavItems.Dashboard);
  const [showLogoutDialog, setShowLogoutDialog] = useState(false);
  const navigate = useNavigate();
  const newCases = useCovidData();

  const handleLogout = () => {
    setShowLogoutDialog(false);
    navigate("/");
  };

  if (newCases === null) {
    // Show loader while fetching data
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#0b1120]">
        <Loader />
      </div>
    );
  }

  const covidBgGlass = (() => {
    if (newCases < 500) return "bg-green-200/10 border-green-400/30";
    if (newCases <= 5000) return "bg-orange-300/10 border-orange-500/30";
    return "bg-red-500/10 border-red-500/30 animate-pulse shadow-lg shadow-red-500/20";
  })();

  return (
    <div className="min-h-screen flex bg-[#0b1120] text-white transition-colors duration-500">
      {/* Sidebar */}
      <aside
        className={`w-64 hidden md:flex flex-col backdrop-blur-md shadow-md rounded-r-xl border ${covidBgGlass}`}
      >
        <div className="p-6 text-xl font-bold">SpectrumView</div>
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

          {/* Logout */}
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <NavItem
                icon={<LogOut className="w-5 h-5" />}
                label="Logout"
                onClick={() => setShowLogoutDialog(true)}
                className={`transition-colors ${
                  activeView === NavItems.Logout
                    ? "bg-white/10 text-white"
                    : "text-muted"
                } hover:text-white`}
              />
            </AlertDialogTrigger>
            {showLogoutDialog && (
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>Are you sure?</AlertDialogTitle>
                  <AlertDialogDescription>
                    You will be logged out and redirected to the login screen.
                  </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel onClick={() => setShowLogoutDialog(false)}>
                    Cancel
                  </AlertDialogCancel>
                  <AlertDialogAction onClick={handleLogout}>
                    Yes, Logout
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            )}
          </AlertDialog>
        </nav>
      </aside>

      {/* Main Content */}
      <main className="flex-1 flex flex-col">
        {/* Header */}
        <header
          className={`h-16 flex items-center justify-between px-6 border-b backdrop-blur-md shadow-sm ${covidBgGlass}`}
        >
          <h1 className="text-lg font-semibold capitalize">{activeView}</h1>
          <div className="flex items-center gap-2">
            <UserCircle className="w-8 h-8 text-white/60" />
            <span className="text-sm">Admin</span>
          </div>
        </header>

        {/* Body */}
        <div
          className={`m-4 p-6 rounded-xl backdrop-blur-md shadow-xl border min-h-[calc(100vh-96px)] ${covidBgGlass}`}
        >
          <Toaster richColors position="bottom-right" closeButton />
          {activeView === NavItems.Dashboard && <DashboardPage />}
          {activeView === NavItems.AddProducts && <AddSerialNumberPage />}
          {activeView === NavItems.Settings && (
            <div className="text-muted-foreground">Settings coming soon...</div>
          )}
        </div>
      </main>
    </div>
  );
};

export default HomePage;

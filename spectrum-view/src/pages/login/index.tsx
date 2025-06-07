import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import PrimaryInputField from "@/components/PrimaryInputField";
import PrimaryButton from "@/components/PrimaryButton";

const LoginPage: React.FC = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });

  const [error, setError] = useState("");

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    if (error) setError("");
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    const { email, password } = formData;

    if (!email || !password) {
      setError("Email and password are required.");
      return;
    }

    // TODO: Add actual login logic here (API call, etc)
    navigate("/home");
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background px-4">
      <Card className="max-w-md w-full bg-card/90 backdrop-blur-md border border-border shadow-xl rounded-xl">
        <CardHeader>
          <CardTitle className="text-3xl font-semibold text-foreground text-center">
            Login
          </CardTitle>
        </CardHeader>

        <CardContent>
          {error && (
            <p className="mb-4 text-center text-destructive font-medium">
              {error}
            </p>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            <PrimaryInputField
              id="email"
              label="Email"
              name="email"
              placeholder="you@example.com"
              type="email"
              value={formData.email}
              onChange={handleChange}
              errors={error && !formData.email ? "Email is required" : ""}
            />

            <PrimaryInputField
              id="password"
              label="Password"
              name="password"
              placeholder="••••••••"
              type="password"
              value={formData.password}
              onChange={handleChange}
              errors={error && !formData.password ? "Password is required" : ""}
            />

            <PrimaryButton type="submit" className="w-full">
              Login
            </PrimaryButton>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default LoginPage;

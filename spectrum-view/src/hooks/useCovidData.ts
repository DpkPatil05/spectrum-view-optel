import { useEffect, useRef, useState } from "react";

const useCovidData = () => {
  const [newCases, setNewCases] = useState<number | null>(null);
  const [stateName, setStateName] = useState<string | null>(null);
  const lastTotalRef = useRef<number | null>(null);

  // Get user location and determine the state name
  const fetchUserState = async () => {
    try {
      const geo = await new Promise<GeolocationPosition>((resolve, reject) =>
        navigator.geolocation.getCurrentPosition(resolve, reject)
      );

      const { latitude, longitude } = geo.coords;

      // Use OpenStreetMap Nominatim to reverse geocode lat/lng to state
      const res = await fetch(
        `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=5&addressdetails=1`
      );
      const json = await res.json();
      const state = json?.address?.state;
      if (state) setStateName(state);
    } catch (err) {
      console.error("Failed to get user location:", err);
    }
  };

  useEffect(() => {
    fetchUserState();
  }, []);

  useEffect(() => {
    if (!stateName) return;

    const fetchCovidCases = async () => {
      try {
        const res = await fetch(
          "https://api.rootnet.in/covid19-in/stats/latest"
        );
        const data = await res.json();

        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const stateData = data?.data?.regional?.find((region: any) =>
          region?.loc?.toLowerCase().includes(stateName.toLowerCase())
        );

        const totalCases = stateData?.totalConfirmed || 0;

        if (lastTotalRef.current !== null) {
          const diff = totalCases - lastTotalRef.current;
          if (diff >= 0) setNewCases(diff); // Only set if new cases are added
        }

        lastTotalRef.current = totalCases;
      } catch (err) {
        console.error("Error fetching COVID data:", err);
      }
    };

    fetchCovidCases();
    const interval = setInterval(fetchCovidCases, 30000);
    return () => clearInterval(interval);
  }, [stateName]);

  return newCases;
};

export default useCovidData;

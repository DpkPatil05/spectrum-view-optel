import { useEffect, useRef, useState } from "react";

const useCovidData = () => {
  const [newCases, setNewCases] = useState<number | null>(null);
  const [stateName, setStateName] = useState<string | null>(null);
  const lastTotalRef = useRef<number | null>(null);

  /**
   * Attempts to determine the user's current state (region) using the browser's geolocation API
   * and reverse geocoding via the OpenStreetMap Nominatim service.
   *
   * - Requests the user's current geographic coordinates.
   * - Uses these coordinates to perform a reverse geocoding lookup to obtain address details.
   * - Extracts the 'state' property from the resulting address and updates the local state if found.
   * - Handles and logs any errors that occur during the process.
   *
   * @remarks
   * This function relies on browser support for the Geolocation API and network access to the
   * OpenStreetMap Nominatim service. User permission is required for geolocation.
   *
   * @returns {Promise<void>} A promise that resolves when the operation is complete.
   */
  const fetchUserState = async () => {
    try {
      const geo = await new Promise<GeolocationPosition>((resolve, reject) =>
        navigator.geolocation.getCurrentPosition(resolve, reject)
      );

      const { latitude, longitude } = geo.coords;

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

        if (lastTotalRef.current === null) {
          // First time fetch, set newCases to 0
          setNewCases(0);
        } else {
          // Subsequent fetches, calculate diff
          const diff = totalCases - lastTotalRef.current;
          if (diff >= 0) setNewCases(diff);
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

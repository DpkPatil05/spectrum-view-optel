// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyD3tP3qbOtUStocyGtWi_9_QQ2zv6F50EI",
  authDomain: "asian-paints-optel-group.firebaseapp.com",
  projectId: "asian-paints-optel-group",
  storageBucket: "asian-paints-optel-group.firebasestorage.app",
  messagingSenderId: "648381256831",
  appId: "1:648381256831:web:0162b065a651ba7fd49b4a",
  measurementId: "G-FLCSDP1T55"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export const db = getFirestore(app);
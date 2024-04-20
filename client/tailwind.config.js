/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx,vue}"],
  theme: {
    extend: {
      colors: {
        "blue-primary": "#1728B3",
        "yellow-primary": "#FBB03B",
      },
    },
  },
  plugins: [],
};

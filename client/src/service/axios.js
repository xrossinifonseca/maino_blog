import axios from "axios";

const service = axios.create({
  baseURL: "https://mainoblog-production.up.railway.app/api/v1",
  withCredentials: true,
});

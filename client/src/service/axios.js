import axios from "axios";

const service = axios.create({
  baseURL: "https://mainoblog-production.up.railway.app/api/v1",
  withCredentials: true,
});

export const getPosts = async (page, tags) => {
  let path = `posts?page=${page}`;

  if (tags) {
    let query = tags
      .split(",")
      .flatMap((item) => {
        return item.trim().includes(" ") ? item.trim().split(" ") : item.trim();
      })
      .join("+");
    path = `posts?tags=${query}&page=${page}`;
  }

  return service.get(path);
};

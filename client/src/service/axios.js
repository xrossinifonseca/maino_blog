import axios from "axios";

// baseURL: "https://mainoblog-production.up.railway.app/api/v1",

const service = axios.create({
  baseURL: "http://localhost:3000/api/v1",
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

export const login = async (body) => {
  return service.post("/session/login", body);
};

export const signup = async (body) => {
  return service.post("/customers", body);
};

export const recoverPassword = async (email) => {
  return await service.post("/password/reset", {
    email_address: email,
  });
};

export const createPost = async (body) => {
  return await service.post("posts", body);
};

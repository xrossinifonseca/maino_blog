import axios from "axios";
const service = axios.create({
  baseURL: "https://backend.rossinicode.com/api/v1",
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

export const logout = async () => {
  return service.post("/session/logout");
};

export const signup = async (body) => {
  return service.post("/customers", body);
};

export const recoverPassword = async (email) => {
  return service.post("/password/reset", {
    email_address: email,
  });
};

export const createPost = async (body) => {
  return service.post("posts", body);
};

export const getPost = async (id) => {
  return service.get(`posts/${id}`);
};

export const commentPost = async (id, body) => {
  return service.post(`comments/${id}`, body);
};

export const customerPosts = async () => {
  return service.get("my-posts");
};

export const profile = async () => {
  return service.get("profile");
};

export const deletePost = async (id) => {
  return service.delete(`posts/${id}`);
};

export const updatePost = async (id, body) => {
  return service.put(`posts/${id}`, body);
};

export const resetPassword = async (body) => {
  return service.patch("password/update", body);
};

export const updateProfile = async (body) => {
  return service.patch("/customer/update", body);
};

export const uploadContent = async (file) => {
  const formData = new FormData();

  if (file) {
    formData.append("upload", file);
  }

  const response = await service.post("post/upload", formData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });
  return response.data;
};

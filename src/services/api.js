import axios from "axios";

const API = axios.create({
  baseURL: import.meta.env.VITE_API_URL
});

export default {
  getExamples() {
    return API.get("/examples");
  },

  addExample(data) {
    return API.post("/examples", data);
  },

  deleteExample(id) {
    return API.delete(`/examples/${id}`);
  },

  toggleSelect(id) {
    return API.put(`/examples/${id}/toggle`);
  },

  search(keyword) {
  return API.get(`/examples/search?keyword=${keyword}`);
  }
};
import axios from "axios";

const API = axios.create({
  baseURL: "http://localhost:8080/api"
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
  }
};
import { ref } from "vue";
import { login } from "../service/axios";
import router from "../router";

const isAuthenticated = ref(document.cookie.includes("check_session"));
const customer = ref(null);

const authenticate = async (credentials) => {
  try {
    const { data } = await login(credentials);

    isAuthenticated.value = true;
    customer.value = data.customer;
    router.push("/");
  } catch (error) {
    const {
      response: { data },
    } = error;

    throw new Error(data.error);
  }
};

const logout = () => {
  isAuthenticated.value = false;
  customer.value = null;
};

export { isAuthenticated, customer, authenticate, logout };

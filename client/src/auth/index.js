import { ref } from "vue";
import { login, logout, profile } from "../service/axios";
import router from "../router";

const isAuthenticated = ref(document.cookie.includes("check_session"));
const customer = ref(null);

const authenticate = async (credentials) => {
  try {
    credentials.email = credentials.email.toLowerCase();
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

const check_session = async () => {
  try {
    if (document.cookie.includes("check_session")) {
      const { data } = await profile();
      customer.value = data;
      isAuthenticated.value = true;
    }
  } catch (error) {
    console.log(error);
  }
};

const desconect = () => {
  logout();
  isAuthenticated.value = false;
  customer.value = null;
  router.push("/");
};

export { isAuthenticated, customer, authenticate, desconect, check_session };

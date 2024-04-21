<script setup>
import { reactive, ref } from "vue";
import Input from "../components/Input.vue";
import Button from "../components/Button.vue";
import { RouterLink } from "vue-router";
import { authenticate } from "../auth";

const values = reactive({
  email: "",
  password: "",
});

const errors = reactive({ ...values });
const loading = ref(false);

const onSubmit = async () => {
  errors.email = "";
  errors.password = "";

  if (!values.password || !values.email) {
    if (!values.email) {
      errors.email = "E-mail inválido";
    }
    if (!values.password) {
      errors.password = "Necessário informar sua senha.";
    }
    return;
  }
  try {
    loading.value = true;
    await authenticate(values);
  } catch (error) {
    if (error.message === "invalid credentials") {
      errors.email = "Email ou senha inválidos";
    }
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="flex justify-center">
    <div class="w-full max-w-[600px] p-5 bg-white space-y-5 py-20">
      <h1 class="font-bold text-3xl text-blue-primary text-center">Login</h1>

      <form class="space-y-10" @submit.prevent="onSubmit">
        <Input
          v-model="values.email"
          autocomplete="email"
          placeholder="E-mail"
          name="email"
          :error="errors.email"
        />
        <div>
          <Input
            type="password"
            v-model="values.password"
            placeholder="Senha"
            autocomplete="current-password"
            name="password"
            :error="errors.password"
          />
          <RouterLink
            to="recover-password"
            class="text-sm font-medium text-slate-500"
          >
            Esqueceu sua senha?
          </RouterLink>
        </div>
        <div class="flex justify-center">
          <Button :loading="loading" type="submit"> Entrar </Button>
        </div>
      </form>
    </div>
  </div>
</template>

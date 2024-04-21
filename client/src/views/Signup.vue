<script setup>
import { reactive, ref } from "vue";
import Button from "../components/Button.vue";
import Input from "../components/Input.vue";
import { signup } from "../service/axios";
import router from "../router";

const values = reactive({
  name: "",
  email: "",
  password: "",
});

const errors = reactive({ ...values });
const loading = ref(false);
const messageSuccess = ref("");

const onSubmit = async () => {
  errors.name = "";
  errors.email = "";
  errors.password = "";

  if (!values.password || !values.email || !values.name) {
    if (!values.name) {
      errors.name = "Informe seu Nome";
    }

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
    const { data } = await signup(values);
    messageSuccess.value = data.message;

    values.email = "";
    values.name = "";
    values.password = "";

    setTimeout(() => {
      router.push("login");
    }, 1000);
  } catch (error) {
    const {
      response: { data },
    } = error;

    errors.name = data.error;
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="flex justify-center">
    <div class="w-full max-w-[600px] p-5 bg-white space-y-5 py-20">
      <h1 class="font-bold text-3xl text-blue-primary text-center">
        Cadastrar
      </h1>

      <div class="text-center text-xl" v-if="messageSuccess">
        <h1 class="text-green-600">{{ messageSuccess }}</h1>
      </div>
      <form class="space-y-10" @submit.prevent="onSubmit">
        <Input
          v-model="values.name"
          autocomplete="name"
          placeholder="Seu Nome"
          name="name"
          :error="errors.name"
        />
        <Input
          v-model="values.email"
          autocomplete="email"
          placeholder="E-mail"
          name="email"
          :error="errors.email"
        />
        <Input
          type="password"
          v-model="values.password"
          placeholder="Senha"
          autocomplete="current-password"
          name="password"
          :error="errors.password"
        />

        <div class="flex justify-center">
          <Button :loading="loading" type="submit"> Cadastrar </Button>
        </div>
      </form>
    </div>
  </div>
</template>

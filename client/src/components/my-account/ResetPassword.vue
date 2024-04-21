<script setup>
import { reactive, ref } from "vue";
import Button from "../Button.vue";
import Input from "../Input.vue";
import { resetPassword } from "../../service/axios";

const loading = ref(false);
const password = reactive({
  current_password: "",
  new_password: "",
});

const errors = reactive({ ...password });
const messageSuccess = ref("");

const submit = async () => {
  errors.current_password = "";
  errors.new_password = "";
  messageSuccess.value = "";

  if (!password.current_password || !password.new_password) {
    if (!password.current_password) {
      errors.current_password = "Informe sua senha atual";
    }

    if (!password.new_password) {
      errors.new_password = "Informe sua nova senha";
    }

    return;
  }

  try {
    loading.value = true;
    const { data } = await resetPassword(password);
    messageSuccess.value = data?.message;

    password.current_password = "";
    password.new_password = "";
  } catch (error) {
    const {
      response: { data },
    } = error;
    errors.current_password = data.error;
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="w-full max-w-[500px]">
    <h1 class="text-3xl font-medium text-blue-primary text-center">
      Alterar senha
    </h1>

    <h1 class="text-green-600 text-center">{{ messageSuccess }}</h1>

    <form class="space-y-5 mt-5" @submit.prevent="submit">
      <Input
        type="password"
        autocomplete="current-password"
        placeholder="senha atual"
        :error="errors.current_password"
        v-model="password.current_password"
      />
      <Input
        type="password"
        autocomplete="new-password"
        placeholder="nova senha"
        :error="errors.new_password"
        v-model="password.new_password"
      />

      <div class="flex justify-center">
        <Button type="submit" :loading="loading">Alterar</Button>
      </div>
    </form>
  </div>
</template>

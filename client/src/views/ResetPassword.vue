<script setup>
import { useRouter } from "vue-router";
import Input from "../components/Input.vue";
import Button from "../components/Button.vue";
import { reactive, ref } from "vue";
import { recoverEditPassword } from "../service/axios";
import router from "../router";

const currentRouter = useRouter();
const { token } = currentRouter.currentRoute.value.query;
const loading = ref(false);
const values = reactive({
  password: "",
  confirm_password: "",
});

const message = reactive({
  type: "",
  text: "",
});

const onSubmit = async () => {
  message.text = "";
  message.type = "";

  if (!values.confirm_password || !values.password) {
    (message.text = "Preencha todos os campos abaixo para salvar sua senha"),
      (message.type = "error");
    return;
  }

  if (values.password !== values.confirm_password) {
    (message.text = "As senhas não correspondem"), (message.type = "error");
    return;
  }

  try {
    loading.value = true;
    await recoverEditPassword(token, values.password);
    message.text = "Senha salva com sucesso";
    message.type = "success";
    values.confirm_password = "";
    values.password = "";
    setTimeout(() => {
      router.push("/login");
    }, 2000);
  } catch (error) {
    console.log(error);
    message.text = "Falha ao tentar criar senha";
    message.type = "error";
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="h-screen flex flex-col mt-10 items-center p-2">
    <h1 class="text-3xl font-medium text-blue-primary">Nova senha</h1>
    <form
      class="space-y-5 mt-10 w-full max-w-[500px]"
      @submit.prevent="onSubmit"
    >
      <h2
        v-if="message.text"
        :data-status="message.type"
        class="text-center text-xl data-[status=error]:text-red-600 data-[status=success]:text-green-600"
      >
        {{ message.text }}
      </h2>
      <Input
        type="password"
        placeholder="Nova senha"
        v-model="values.password"
        autocomplete="current-password"
      />
      <Input
        type="password"
        placeholder="Confirmar senha"
        autocomplete="current-password"
        v-model="values.confirm_password"
      />
      <div class="flex justify-center">
        <Button type="submit" :loading="loading">Salvar</Button>
      </div>
    </form>
  </div>
</template>

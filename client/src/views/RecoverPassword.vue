<script setup>
import { reactive, ref } from "vue";
import Button from "../components/Button.vue";
import Input from "../components/Input.vue";
import { recoverPassword } from "../service/axios";

const values = reactive({
  email: "",
});

const errors = reactive({ ...values });
const loading = ref(false);
const messageSuccess = ref("");

const onSubmit = async () => {
  errors.email = "";

  if (!values.email) {
    return (errors.email = "Informe seu email");
  }

  try {
    loading.value = true;
    const { data } = await recoverPassword(values.email);
    messageSuccess.value =
      "Um email de recuperação de senha foi enviado para o seu endereço de email. Por favor, verifique sua caixa de entrada.";
    values.email = "";

    setTimeout(() => {
      messageSuccess.value = "";
    }, 2000);
  } catch (error) {
    errors.email = "Falha ao tentar enviar email";
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="flex justify-center">
    <div class="w-full max-w-[600px] p-5 bg-white space-y-5 py-20">
      <h1 class="font-bold text-3xl text-blue-primary text-center">
        Recuperar senha
      </h1>

      <div class="text-center text-xl" v-if="messageSuccess">
        <h1 class="text-green-600">{{ messageSuccess }}</h1>
      </div>
      <form class="space-y-10" @submit.prevent="onSubmit">
        <Input
          v-model="values.email"
          autocomplete="email"
          placeholder="E-mail"
          name="email"
          :error="errors.email"
        />

        <div class="flex justify-center">
          <Button :loading="loading" type="submit"> Enviar </Button>
        </div>
      </form>
    </div>
  </div>
</template>

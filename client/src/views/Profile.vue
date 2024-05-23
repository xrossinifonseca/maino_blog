<script setup>
import { reactive, ref } from "vue";
import { customer } from "../auth";
import Input from "../components/Input.vue";
import ResetPassword from "../components/my-account/ResetPassword.vue";
import Button from "../components/Button.vue";
import { updateProfile } from "../service/axios";

const disabled = ref(true);
const loading = ref(false);
const values = reactive({
  name: "",
  email: "",
});

const messageSuccess = ref("");

const onSubmit = async () => {
  if (!values.email) {
    values.email = customer.value.email;
  }

  if (!values.name) {
    values.name = customer.value.name;
  }

  loading.value = true;
  const { data } = await updateProfile(values);
  messageSuccess.value = data.message;
  loading.value = false;

  customer.value.name = values.name;
  customer.value.email = values.email;
};
</script>

<template>
  <div class="min-h-screen">
    <div class="flex items-center justify-center gap-2">
      <h1 class="text mt-5 text-3xl font-medium text-blue-primary text-center">
        Meus Dados
      </h1>
      <button
        @click="disabled = !disabled"
        :data-edit="disabled"
        class="w-10 data-[edit=true]:bg-slate-400 bg-blue-primary mt-5 rounded"
      >
        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
          <g
            id="SVGRepo_tracerCarrier"
            stroke-linecap="round"
            stroke-linejoin="round"
          ></g>
          <g id="SVGRepo_iconCarrier">
            <g id="Edit / Edit_Pencil_01">
              <path
                id="Vector"
                d="M12 8.00012L4 16.0001V20.0001L8 20.0001L16 12.0001M12 8.00012L14.8686 5.13146L14.8704 5.12976C15.2652 4.73488 15.463 4.53709 15.691 4.46301C15.8919 4.39775 16.1082 4.39775 16.3091 4.46301C16.5369 4.53704 16.7345 4.7346 17.1288 5.12892L18.8686 6.86872C19.2646 7.26474 19.4627 7.46284 19.5369 7.69117C19.6022 7.89201 19.6021 8.10835 19.5369 8.3092C19.4628 8.53736 19.265 8.73516 18.8695 9.13061L18.8686 9.13146L16 12.0001M12 8.00012L16 12.0001"
                class="stroke-white"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              ></path>
            </g>
          </g>
        </svg>
      </button>
    </div>
    <div class="flex justify-center my-10">
      <form class="w-full max-w-[500px]" @submit.prevent="onSubmit">
        <div class="text-center text-xl" v-if="messageSuccess">
          <h1 class="text-green-600">{{ messageSuccess }}</h1>
        </div>
        <div class="flex flex-col">
          <label for="name" class="px-2 text-lg">Nome</label>
          <Input
            :disabled="disabled"
            name="name"
            v-model="values.name"
            :placeholder="customer?.name"
          />
        </div>
        <div class="flex flex-col">
          <label for="name" class="px-2 text-xl">Email</label>
          <Input
            :disabled="disabled"
            :placeholder="customer?.email"
            v-model="values.email"
          />
        </div>

        <div class="flex justify-center mt-5" v-show="!disabled">
          <Button type="submit" :loading="loading">Editar</Button>
        </div>
      </form>
    </div>

    <div class="flex justify-center bg-white mt-10 p-5">
      <ResetPassword />
    </div>
  </div>
</template>

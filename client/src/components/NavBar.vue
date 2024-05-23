<script setup>
import { RouterLink } from "vue-router";
import Button from "./Button.vue";
import { isAuthenticated, customer, desconect } from "../auth";
import { ref } from "vue";

const drop = ref(false);

const toggleDrop = () => {
  drop.value = !drop.value;
};
</script>

<template>
  <div class="container p-5 gap-2 flex flex-wrap justify-between w-full">
    <div>
      <RouterLink to="/">
        <h1 class="font-bold text-3xl text-white">Rails Blog</h1></RouterLink
      >
    </div>

    <div v-show="!isAuthenticated">
      <ul class="flex items-center gap-4">
        <RouterLink
          to="/login"
          class="font-bold text-blue-primary bg-white p-2 text-xl rounded-sm px-5"
          >Login</RouterLink
        >
        <RouterLink to="/signup">
          <button
            class="font-bold text-xl bg-yellow-primary text-white p-2 rounded-sm bg-"
          >
            Cadastrar
          </button>
        </RouterLink>
      </ul>
    </div>

    <div
      v-if="isAuthenticated && customer"
      class="flex gap-2 items-center relative cursor-pointer"
      @click="toggleDrop"
    >
      <h1 class="text-xl text-white font-medium">
        Olá,
        <span class="capitalize">{{ customer?.name }}</span>
      </h1>

      <div :data-open="drop" class="w-4 rotate-180 data-[open=true]:rotate-0">
        <svg fill="#fff" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
          <g
            id="SVGRepo_tracerCarrier"
            stroke-linecap="round"
            stroke-linejoin="round"
          ></g>
          <g id="SVGRepo_iconCarrier">
            <path
              d="M3 19h18a1.002 1.002 0 0 0 .823-1.569l-9-13c-.373-.539-1.271-.539-1.645 0l-9 13A.999.999 0 0 0 3 19z"
            ></path>
          </g>
        </svg>
      </div>

      <div
        :data-open="drop"
        class="absolute text-blue-primary w-full px-2 bg-white top-10 data-[open=true]:h-28 h-0 flex flex-col gap-1 items-start overflow-y-hidden"
      >
        <RouterLink to="/my-posts" class="mt-2">Meus Posts</RouterLink>
        <RouterLink to="/my-account">Minha conta</RouterLink>
        <button @click="desconect">Sair</button>
      </div>
    </div>
  </div>
</template>

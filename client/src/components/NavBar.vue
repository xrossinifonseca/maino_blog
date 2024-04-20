<script setup>
import { RouterLink } from "vue-router";
import Button from "./Button.vue";
</script>

<template>
  <div class="container p-5 flex flex-wrap justify-between w-full">
    <div>
      <RouterLink to="/">
        <h1 class="font-bold text-3xl text-slate-800">
          Mainô Blog
        </h1></RouterLink
      >
    </div>

    <ul class="flex items-center gap-4">
      <RouterLink to="login" class="font-bold text-xl text-slate-800"
        >Login</RouterLink
      >
      <RouterLink to="signup">
        <Button> Cadastrar </Button>
      </RouterLink>
    </ul>
  </div>
</template>

<script setup>
import { RouterView } from "vue-router";
import NavBar from "../components/NavBar.vue";
</script>

<template>
  <div class="bg-gray-100 min-h-screen">
    <nav class="flex justify-center w-full">
      <NavBar />
    </nav>

    <main class="w-full flex justify-center">
      <div class="container mt-10">
        <RouterView />
      </div>
    </main>

    <footer class="text-center mt-10 pb-2">
      <a class="text-font-bold text-blue-primary"
        >Desenvolvimento Rossini Fonseca</a
      >
    </footer>
  </div>
</template>

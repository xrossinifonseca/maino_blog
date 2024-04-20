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
      <div class="container">
        <RouterView />
      </div>
    </main>

    <footer>footer</footer>
  </div>
</template>

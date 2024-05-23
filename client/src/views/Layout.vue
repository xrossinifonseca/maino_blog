<script setup>
import { RouterView } from "vue-router";
import NavBar from "../components/NavBar.vue";
import { check_session } from "../auth/";
import { onBeforeMount, ref } from "vue";

const loading = ref(true);
onBeforeMount(async () => {
  await check_session();
  loading.value = false;
});
</script>

<template>
  <div class="bg-gray-100 min-h-screen">
    <nav class="flex justify-center w-full bg-blue-primary">
      <NavBar />
    </nav>

    <main class="w-full flex justify-center" v-show="!loading">
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

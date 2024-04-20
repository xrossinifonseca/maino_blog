<script setup>
import CardPost from "../components/posts/CardPost.vue";
import Button from "../components/Button.vue";
</script>

<template>
  <div class="mt-10 p-2">
    <div class="flex flex-wrap gap-10 justify-center">
      <CardPost
        title="Loirem ipusom lorem self josl lorem poesad"
        author="rossini fonseca"
        date="24 Abril 2024"
      /><CardPost
        title="Loirem ipusom lorem self josl lorem poesad"
        author="rossini fonseca"
        date="24 Abril 2024"
      /><CardPost
        title="Loirem ipusom lorem self josl lorem poesad"
        author="rossini fonseca"
        date="24 Abril 2024"
      />
    </div>

    <div class="flex justify-end mt-10">
      <div class="space-y-2">
        <span class="text-slate-600 text-sm">Página 1 de 2</span>
        <Button>Próximo</Button>
      </div>
    </div>
  </div>
</template>

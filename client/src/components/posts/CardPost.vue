<script setup>
defineProps(["img", "title", "author", "date", "tags", "id"]);
</script>

<template>
  <div class="w-full max-w-[390px] space-y-4">
    <RouterLink :to="'/post/' + id">
      <div class="w-full bg-gray-300 h-[320px] rounded-xl"></div>

      <div>
        <h1 class="text-start text-lg font-bold text-slate-800">
          {{ title }}
        </h1>
      </div>

      <ul class="flex flex-wrap gap-2 items-center" v-if="tags.length > 0">
        <li
          class="p-2 bg-slate-300 rounded-xl text-sm text-blue-primary"
          v-for="tag in tags"
          :key="tag.id"
        >
          {{ tag.name }}
        </li>
      </ul>

      <div class="flex items-center gap-2 justify-between text-slate-600">
        <h2>{{ author }}</h2>
        <h3>{{ date }}</h3>
      </div>
    </RouterLink>
  </div>
</template>

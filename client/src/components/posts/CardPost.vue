<script setup>
const props = defineProps([
  "img",
  "title",
  "author",
  "date",
  "tags",
  "id",
  "content",
]);

const created = new Date(props.date);
const sliceContet = (content) => content.slice(0, 300) + "...";
</script>

<template>
  <div class="w-full max-w-[390px] space-y-4 bg-white p-3 rounded">
    <RouterLink :to="'/post/' + id">
      <div class="space-y-2 mb-2">
        <h1 class="text-start text-lg font-bold text-slate-800">
          {{ title }}
        </h1>
        <p class="w-full rounded-xl text-sm text-slate-500">
          {{ sliceContet(content) }}
        </p>

        <button class="bg-yellow-primary p-2 rounded text-white px-5">
          Ler
        </button>
      </div>

      <ul
        class="flex flex-wrap gap-2 justify-center items-center"
        v-if="tags.length > 0"
      >
        <li
          class="p-2 bg-slate-300 rounded-xl text-sm text-blue-primary"
          v-for="(name, index) in tags"
          :key="index"
        >
          {{ name }}
        </li>
      </ul>

      <div class="flex items-center gap-2 justify-between text-slate-600">
        <h2>{{ author }}</h2>
        <h3>{{ created.toLocaleDateString("pt-BR") }}</h3>
      </div>
    </RouterLink>
  </div>
</template>

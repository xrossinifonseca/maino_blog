<script setup>
defineProps(["img", "title", "author", "date"]);
</script>

<template>
  <div class="w-full max-w-[390px] space-y-4">
    <div class="w-full bg-gray-300 h-[320px] rounded-xl"></div>

    <div>
      <h1 class="text-start text-lg font-bold text-slate-800">
        {{ title }}
      </h1>
    </div>

    <div class="flex items-center gap-2 justify-between text-slate-600">
      <h2>{{ author }}</h2>
      <h3>{{ date }}</h3>
    </div>
  </div>
</template>

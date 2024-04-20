<script setup>
defineProps(["loading"]);
</script>

<template>
  <button
    v-bind="$attrs"
    class="flex items-center justify-center text-white bg-blue-primary py-2 px-4 rounded"
  >
    <span v-if="loading"> Loading.. </span>

    <span v-else>
      <slot></slot>
    </span>
  </button>
</template>

<script setup></script>

<template>
  <button
    v-bind="$attrs"
    class="flex items-center justify-center text-white bg-blue-primary py-2 px-4 rounded"
  >
    <slot></slot>
  </button>
</template>

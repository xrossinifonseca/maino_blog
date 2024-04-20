<script setup>
defineProps(["error", "modelValue"]);
const emit = defineEmits(["update:modelValue"]);
</script>

<template>
  <div class="w-full">
    <input
      :value="modelValue"
      v-bind="$attrs"
      @input="emit('update:modelValue', $event.target.value)"
      class="p-2 w-full outline-none bg-transparent border-b-2"
    />
    <span v-if="error" class="text-medium text-red-500 text-lg">{{
      error
    }}</span>
  </div>
</template>

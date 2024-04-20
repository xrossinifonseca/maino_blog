<script setup>
import { reactive, ref } from "vue";
import Button from "../components/Button.vue";
import { createPost } from "../service/axios";

const values = reactive({
  title: "",
  content: "",
  tags: "",
});

const errors = reactive({ ...values });
const loading = ref(false);
const messageSuccess = ref("");

const onSubmit = async () => {
  errors.content = "";
  errors.title = "";

  if (!values.content || !values.title) {
    if (!values.title) {
      errors.title = "Informe o Título";
    }

    if (!values.content) {
      errors.content = "Informe o conteúdo";
    }

    return;
  }
  try {
    loading.value = true;
    const { data } = await createPost(values);
    messageSuccess.value = data.message;

    values.title = "";
    values.tags = "";
    values.content = "";
  } catch (error) {
    const {
      response: { data },
    } = error;
    errors.title = data.error;
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="px-5 lg:px-10">
    <h1 class="text-3xl font-bold text-blue-primary text-center">Novo Post</h1>
    <form
      @submit.prevent="onSubmit"
      class="mt-10 w-full bg-white py-10 max-sm:px-5 px-20 rounded-xl space-y-5"
    >
      <div class="text-center text-xl" v-if="messageSuccess">
        <h1 class="text-green-600">{{ messageSuccess }}</h1>
      </div>
      <div class="flex flex-col gap-2">
        <label for="title" class="text-slate-900 font-bold text-2xl"
          >Título</label
        >
        <input
          type="text"
          v-model="values.title"
          name="title"
          autocomplete="organization-title"
          class="p-5 bg-slate-300 rounded-xl outline-none"
        />
        <span v-if="errors.title" class="text-medium text-red-500 text-lg">{{
          errors.title
        }}</span>
      </div>

      <div class="flex flex-col gap-2">
        <label for="tags" class="text-slate-900 font-bold text-2xl">Tags</label>
        <input
          type="text"
          v-model="values.tags"
          name="tags"
          autocomplete="organization-title"
          class="p-5 bg-slate-300 rounded-xl outline-none"
        />
      </div>

      <div class="flex flex-col gap-2">
        <label for="content" class="text-slate-900 font-bold text-2xl"
          >Conteúdo</label
        >
        <textarea
          type="text"
          v-model="values.content"
          name="content"
          class="p-5 bg-slate-300 rounded-xl outline-none min-h-40"
        ></textarea>
        <span v-if="errors.content" class="text-medium text-red-500 text-lg">{{
          errors.content
        }}</span>
      </div>

      <div class="flex justify-end">
        <Button :loading="loading" type="submit"> Publicar </Button>
      </div>
    </form>
  </div>
</template>

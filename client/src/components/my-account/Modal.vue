<script setup>
import { onMounted, reactive, ref } from "vue";
import Button from "../Button.vue";
import { deletePost, updatePost } from "../../service/axios";
import router from "../../router";

const props = defineProps(["post"]);
const emit = defineEmits(["close-modal"]);
const values = reactive({
  title: "",
  content: "",
});
const errors = reactive({ ...values });
const loading = reactive({
  edit: false,
  delete: false,
});
const messageSuccess = ref("");

onMounted(() => {
  values.content = props.post?.content;
  values.title = props.post?.title;
});

const remove = async () => {
  try {
    loading.delete = true;

    const { data } = await deletePost(props.post?.id);
    messageSuccess.value = data.message;
    setTimeout(() => {
      router.push("/");
    }, 1000);
  } catch (error) {
    console.log(error);
  } finally {
    loading.delete = false;
  }
};

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
    loading.edit = true;
    const { data } = await updatePost(props.post?.id, values);
    messageSuccess.value = data?.message;

    props.post.title = values.title;
    props.post.content = values.content;
  } catch (error) {
    const {
      response: { data },
    } = error;
    errors.title = data.error;
  } finally {
    loading.edit = false;
  }
};
</script>

<template>
  <div
    class="fixed w-full h-screen left-0 top-0 z-30 flex justify-center items-center"
  >
    <div
      class="absolute bg-black opacity-40 w-full h-screen left-0 top-0 -z-10"
    ></div>

    <form
      class="max-w-[500px] w-full bg-white p-5 rounded space-y-5"
      @submit.prevent="onSubmit"
    >
      <div class="flex justify-end">
        <button
          type="button"
          @click="$emit('close-modal')"
          class="btn bg-transparent hover:bg-transparent border-none"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 512 512"
            class="w-10"
          >
            <path
              class="fill-red-600"
              d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM175 175c9.4-9.4 24.6-9.4 33.9 0l47 47 47-47c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9l-47 47 47 47c9.4 9.4 9.4 24.6 0 33.9s-24.6 9.4-33.9 0l-47-47-47 47c-9.4 9.4-24.6 9.4-33.9 0s-9.4-24.6 0-33.9l47-47-47-47c-9.4-9.4-9.4-24.6 0-33.9z"
            />
          </svg>
        </button>
      </div>

      <h2
        class="text-xl font-medium text-green-600 text-center"
        v-if="messageSuccess"
      >
        {{ messageSuccess }}
      </h2>

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

      <div class="flex gap-2 justify-end">
        <Button :loading="loading.edit" type="submit" @click="toggleModal"
          >Editar</Button
        >
        <button
          @click.capture="remove"
          class="flex items-center justify-center text-white bg-red-600 py-2 px-4 rounded"
        >
          <span v-if="loading.delete"> Loading.. </span>

          <span v-else>Apgar</span>
        </button>
      </div>
    </form>
  </div>
</template>

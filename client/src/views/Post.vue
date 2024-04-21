<script setup>
import { onBeforeMount, ref } from "vue";
import { useRouter } from "vue-router";
import Button from "../components/Button.vue";
import { getPost, commentPost } from "../service/axios";
import { customer } from "../auth";
import Modal from "../components/my-account/Modal.vue";

const routerParams = useRouter();
const notfoud = ref(false);
const postId = routerParams.currentRoute.value.params.id;
const loading = ref(true);
const post = ref({});
const textComment = ref("");
const modal = ref(false);
const messageSuccess = ref("");

const fetchPost = async () => {
  try {
    const { data } = await getPost(postId);
    post.value = data;
  } catch (error) {
    const {
      response: { status },
    } = error;

    if (status === 404) {
      notfoud.value = true;
    }
  } finally {
    loading.value = false;
  }
};

onBeforeMount(() => {
  fetchPost();
});

const commentSubmit = async () => {
  if (!textComment) return;

  let newComment = {
    author_name: customer.value?.name,
    content: textComment.value,
  };

  commentPost(postId, newComment);

  post.value.comments.push({
    ...newComment,
    author_name: customer.value === null ? "anonymous" : customer.value.name,
  });

  textComment.value = "";
};

const toggleModal = () => {
  modal.value = !modal.value;
};
</script>

<template>
  <div>
    <div class="px-2 lg:px-5 min-h-screen" v-if="!loading && !notfoud">
      <Modal v-if="modal" :post="post" @close-modal="toggleModal" />
      <div class="space-y-10 bg-white p-10 rounded">
        <h2
          class="text-center text-green-600 font-medium"
          v-if="messageSuccess"
        >
          {{ messageSuccess }}
        </h2>
        <div class="flex justify-between">
          <h1 class="text-2xl font-bold">
            {{ post.title }}
          </h1>

          <div
            v-if="customer?.id === post?.author_id"
            class="flex gap-2 flex-wrap"
          >
            <Button @click="toggleModal">Editar</Button>
          </div>
        </div>

        <p>
          {{ post.content }}
        </p>

        <div class="text-sm font-medium">
          <h2>{{ post.author }}</h2>
          <h2>{{ post.created_at }}</h2>
        </div>
      </div>

      <div class="mt-10 bg-white p-10">
        <h1 class="text-xl">Comentarios</h1>
        <div
          class="mt-5 border-b pb-5"
          v-for="comment in post.comments"
          :key="comment.id"
        >
          <h2 class="text-sm font-bold">{{ comment.author_name }}</h2>
          <p class="text-sm text-slate-800">
            {{ comment.content }}
          </p>
        </div>

        <form class="mt-10 space-y-5" @submit.prevent="commentSubmit">
          <textarea
            type="text"
            v-model="textComment"
            placeholder="faça um comentario"
            name="content"
            class="p-5 bg-slate-200 text-black rounded-xl outline-none min-h-40 w-full"
          ></textarea>
          <div class="flex justify-end">
            <Button type="submit">Comentar</Button>
          </div>
        </form>
      </div>
    </div>

    <div v-else class="h-screen">
      <div v-if="notfoud">
        <h1 class="text-gray-500 font-medium text-3xl text-center">
          Post Não encontrado
        </h1>
      </div>
    </div>
  </div>
</template>

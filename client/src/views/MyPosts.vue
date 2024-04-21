<script setup>
import CardPost from "../components/posts/CardPost.vue";
import Button from "../components/Button.vue";
import { customerPosts } from "../service/axios";
import { onBeforeMount, reactive, ref, watch } from "vue";

const posts = ref([]);
const loading = ref(true);
const pages = reactive({
  totalPages: 1,
  currentPage: 1,
});
const query = ref("");

const fetchPosts = async () => {
  loading.value = true;
  const { data } = await customerPosts();
  posts.value = data.posts;
  pages.totalPages = data.total_pages;
  loading.value = false;
};

onBeforeMount(() => {
  fetchPosts();
});

const nextPage = () => {
  if (pages.totalPages <= pages.currentPage) {
    pages.currentPage = pages.totalPages;
    return;
  }

  pages.currentPage = pages.currentPage + 1;
};

const prevPage = () => {
  if (pages.currentPage > 1) {
    pages.currentPage = pages.currentPage - 1;
  }
};

watch(
  () => pages.currentPage,
  () => {
    fetchPosts(query.value);
  }
);
</script>

<template>
  <div class="mt-10 p-2">
    <div
      class="max-sm:flex-col-reverse flex sm:justify-between items-center gap-2 px-2 my-5"
    >
      <div class="text-center">
        <h2 class="text-blue-primary font-medium text-2xl">
          Seus Posts publicados
        </h2>
      </div>

      <RouterLink
        to="post/new"
        class="p-2 bg-yellow-primary text-xl text-white rounded shadow-sm"
      >
        Novo Post
      </RouterLink>
    </div>
    <div v-if="!loading">
      <div class="flex flex-wrap gap-10 justify-center" v-if="posts.length > 0">
        <CardPost
          v-for="post in posts"
          :key="post.id"
          :id="post.id"
          :title="post.title"
          :author="post.author"
          :tags="post.tags"
          :date="post.date"
        />
      </div>

      <div v-else class="my-10">
        <h1 class="text-center font-medium text-slate-800 text-xl">
          Nenhum Post publicado até o momento.
        </h1>
      </div>

      <div class="flex justify-end mt-10">
        <div class="space-y-2">
          <span class="text-slate-600 text-sm"
            >Página {{ pages.currentPage }} de {{ pages.totalPages }}</span
          >
          <div class="flex flex-wrap gap-4">
            <Button @click="prevPage">Anterior</Button>
            <Button @click="nextPage">Próxima</Button>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="min-h-80 mt-10">
      <h1 class="font-bold text-gray-500 text-xl text-center">Loading...</h1>
    </div>
  </div>
</template>

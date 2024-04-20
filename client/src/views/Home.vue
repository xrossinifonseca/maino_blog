<script setup>
import CardPost from "../components/posts/CardPost.vue";
import Button from "../components/Button.vue";
import { getPosts } from "../service/axios";
import { computed, onBeforeMount, reactive, ref, watch } from "vue";
import { useRouter } from "vue-router";

const posts = ref([]);
const loading = ref(true);
const pages = reactive({
  totalPages: 1,
  currentPage: 1,
});
const query = ref("");
const router = useRouter();

const fetchPosts = async (query) => {
  loading.value = true;
  const { data } = await getPosts(pages.currentPage, query);
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

watch(
  () => pages.currentPage,
  () => {
    fetchPosts(query.value);
  }
);

const queryPath = computed(() => {
  if (query.value) {
    const modifiedQuery = query.value;

    router.replace({ query: { tags: modifiedQuery }, replace: true });
  } else {
    return router.replace();
  }
});

watch(query, () => {
  queryPath.value;
});

const filterPosts = () => {
  pages.currentPage = 1;
  fetchPosts(query.value);
};
</script>

<template>
  <div class="mt-10 p-2">
    <div
      class="max-sm:flex-col-reverse flex sm:justify-between items-center gap-2 px-2 my-5"
    >
      <div>
        <h2
          class="text-slate-800 font-medium text-xl"
          v-if="pages.currentPage == 1"
        >
          Mais Recentes
        </h2>
      </div>

      <div class="flex gap-2">
        <input
          type="text"
          v-model="query"
          class="p-2 rounded shadow-sm outline-none text-sm font-light"
          placeholder="Filtrar por tag ex: cinema, cozinha.."
        />
        <Button @click="filterPosts(query)">Filtrar</Button>
      </div>
    </div>
    <div v-if="!loading">
      <div class="flex flex-wrap gap-10 justify-center" v-if="posts.length > 0">
        <CardPost
          v-for="post in posts"
          :key="post.id"
          :title="post.title"
          :author="post.author"
          :tags="post.tags"
          date="24 Abril 2024"
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
          <Button @click="nextPage">Próximo</Button>
        </div>
      </div>
    </div>

    <div v-else class="min-h-80 mt-10">
      <h1 class="font-bold text-gray-500 text-xl text-center">Loading...</h1>
    </div>
  </div>
</template>

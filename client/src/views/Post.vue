<script setup>
import { reactive } from "vue";
import { useRouter } from "vue-router";
import Button from "../components/Button.vue";

const router = useRouter();

// console.log(router.currentRoute.value.params.id);
</script>

<template>
  <div class="px-2 lg:px-5 min-h-screen">
    <div class="space-y-10 bg-white p-10 rounded">
      <h1 class="text-2xl font-bold">
        Como aprender javascript da forma corrreta?
      </h1>

      <p>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Alias repellat
        aliquid id facilis voluptatem doloribus illo asperiores quo, at modi
        itaque saepe dignissimos deleniti blanditiis accusantium harum nam
        repellendus. Sequi. Lorem ipsum dolor sit amet consectetur adipisicing
        elit. Veritatis necessitatibus, amet unde eum blanditiis quam quisquam
        qui tempore neque odit enim ea est quidem aliquam sequi, temporibus fuga
        recusandae sint!
      </p>

      <div class="text-sm font-medium">
        <h2>Rossini fonseca</h2>
        <h2>20 Abrl 2024</h2>
      </div>
    </div>

    <div class="mt-10 bg-white p-10">
      <h1 class="text-xl">Comentarios</h1>

      <div class="mt-5 border-b pb-5" v-for="item in [1, 2]" :key="item">
        <h2 class="text-sm font-bold">Anônimo</h2>
        <p class="text-sm text-slate-800">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet
          voluptatibus odio incidunt praesentium dolores sint, culpa aliquid,
          ipsam nulla repudiandae quasi laboriosam quibusdam fuga quas adipisci
          quam, dolore temporibus labore!
        </p>
      </div>

      <form class="mt-10 space-y-5">
        <textarea
          type="text"
          placeholder="faça um comentario"
          name="content"
          class="p-5 bg-slate-200 text-black rounded-xl outline-none min-h-40 w-full"
        ></textarea>
        <div class="flex justify-end">
          <Button>Comentar</Button>
        </div>
      </form>
    </div>
  </div>
</template>

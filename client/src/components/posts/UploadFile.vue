<script setup>
import { reactive, ref } from "vue";
import { uploadContent } from "../../service/axios";

const props = defineProps(["values"]);

const file = ref(null);
const message = reactive({
  type: "",
  text: "",
});
const loading = ref(false);

const handleChange = (event) => {
  file.value = event.target.files[0];
};

const sendFile = async () => {
  message.text = "";
  message.type = "";

  if (file.value === null) {
    message.text = "Necessário enviar um arquivo .txt";
    message.type = "error";
    return;
  }
  try {
    loading.value = true;
    const response = await uploadContent(file.value);

    props.values.content = response?.content;

    message.type = "success";
    message.text = "Conteúdo encontrado com sucesso";

    setTimeout(() => {
      message.type = "";
      message.text = "";
    }, 2000);
  } catch (error) {
    message.type = "error";
    message.text = "Falha eu ler arquivo";
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div>
    <h2
      v-if="message.text"
      :data-status="message.type"
      class="data-[status=error]:text-red-400 data-[status=success]:text-green-600 text-sm font-medium"
    >
      {{ message.text }}
    </h2>
    <div
      class="flex flex-col items-center space-y-2"
      v-if="message.type !== 'success'"
    >
      <label class="text-xl">
        Envie um arquivo de texto do seu conteúdo para acelerar sua publicação!
      </label>

      <input type="file" @change="handleChange" />
      <button
        type="button"
        @click="sendFile"
        class="text-white bg-yellow-primary p-2 font-medium text-lg rounded"
      >
        <span v-if="loading">Aguarde..</span>
        <span v-else> Enviar </span>
      </button>
    </div>
  </div>
</template>

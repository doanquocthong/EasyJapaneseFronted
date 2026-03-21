<template>
  <div class="bg-white p-4 rounded-2xl shadow">

    <input v-model="form.situation" placeholder="🍡 Tình huống"
      class="input" />

    <input v-model="form.romaji" placeholder="📝 Romaji"
      class="input" />

    <input v-model="form.japanese" placeholder="Phiên âm tiếng Nhật"
      class="input" />

    <input v-model="form.meaning" placeholder="💬 Nghĩa"
      class="input" />

    <input v-model="form.grammar" placeholder="📚 Ngữ pháp"
      class="input" />

    <input v-model="form.level" placeholder="🏷 Level"
      class="input" />

    <button @click="submit"
      class="mt-3 bg-pink-400 text-white px-4 py-2 rounded-xl">
      🌸 Add
    </button>

  </div>
</template>

<script setup>
import { reactive } from "vue";
import api from "../services/api";

const emit = defineEmits(["added"]);

const form = reactive({
  situation: "",
  japanese: "",
  romaji: "",
  meaning: "",
  grammar: "",
  level: ""
});

const submit = async () => {
  await api.addExample(form);

  Object.keys(form).forEach(k => form[k] = "");

  emit("added");
};
</script>

<style>
.input {
  display: block;
  width: 100%;
  margin-top: 8px;
  padding: 8px;
  border-radius: 10px;
  border: 1px solid #ddd;
}
</style>
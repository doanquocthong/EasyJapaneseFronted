<template>
  <div class="bg-white p-4 rounded-2xl shadow hover:scale-105 transition">

    <h3 class="text-lg font-semibold text-pink-400">
      🍡 {{ example.situation }}
    </h3>

    <p class="mt-2">🇯🇵 {{ example.japanese }}</p>
    <p>📝 {{ example.romaji }}</p>
    <p>💬 {{ example.meaning }}</p>

    <p class="mt-2 text-sm text-blue-500">
      📚 {{ example.grammar }}
    </p>

    <span class="inline-block mt-2 px-3 py-1 bg-pink-200 rounded-full text-sm">
      {{ example.level }}
    </span>

    <button
      @click="remove"
      class="mt-3 text-red-400 hover:underline"
    >
      ❌ Delete
    </button>

  </div>
</template>

<script setup>
import api from "../services/api";

const props = defineProps(["example"]);
const emit = defineEmits(["deleted"]);

const remove = async () => {
  await api.deleteExample(props.example.id);
  emit("deleted");
};
</script>
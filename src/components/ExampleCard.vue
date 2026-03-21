<template>
  <div
    @click="toggleSelect"
    :class="[
      'relative p-5 rounded-2xl border transition cursor-pointer duration-300',
      example.isSelect
        ? 'bg-yellow-100 border-yellow-300 shadow-lg scale-[1.03]'
        : 'bg-white border-gray-200 hover:shadow-md hover:scale-[1.02]'
    ]"
  >

    <!-- Badge selected -->
    <div
      v-if="example.isSelect"
      class="absolute top-3 right-3 text-yellow-500 text-xl"
    >
      ⭐
    </div>

    <!-- Title -->
    <h3 class="text-lg font-bold text-pink-400 flex items-center gap-2">
      🍡 {{ example.situation }}
    </h3>

    <!-- Japanese -->
    <p class="mt-3 text-lg font-medium text-gray-800">
      🇯🇵 {{ example.japanese }}
    </p>

    <!-- Romaji -->
    <p class="text-gray-500 italic">
      📝 {{ example.romaji }}
    </p>

    <!-- Meaning -->
    <p class="mt-2 text-gray-700">
      💬 {{ example.meaning }}
    </p>

    <!-- Grammar -->
    <p class="mt-3 text-sm text-blue-400 bg-blue-50 px-2 py-1 rounded-md inline-block">
      📚 {{ example.grammar }}
    </p>

    <!-- Footer -->
    <div class="flex items-center justify-between mt-4">

      <!-- Level -->
      <span class="px-3 py-1 bg-pink-100 text-pink-500 rounded-full text-xs font-medium">
        {{ example.level }}
      </span>

      <!-- Delete -->
      <button
        class="text-gray-400 hover:text-red-400 transition text-sm"
        @click.stop="remove"
      >
        🗑️ Xóa
      </button>

    </div>

  </div>
</template>

<script setup>
import api from "../services/api";

const props = defineProps(["example"]);
const emit = defineEmits(["deleted", "updated"]);

const remove = async () => {
  await api.deleteExample(props.example.id);
  emit("deleted");
};

const toggleSelect = async () => {
  props.example.isSelect = !props.example.isSelect;

  try {
    await api.toggleSelect(props.example.id);
  } catch (e) {
    props.example.isSelect = !props.example.isSelect;
    console.error(e);
  }
};
</script>
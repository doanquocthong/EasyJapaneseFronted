<template>
  <div class="min-h-screen bg-pink-50 p-6">

    <!-- TITLE -->
    <h1 class="text-3xl font-bold text-pink-500 mb-4">
      🌸 Bé Nhi hoa anh đào
    </h1>

    <!-- 🔍 SEARCH -->
    <div class="mb-4">
      <input
        v-model="keyword"
        @input="handleSearch"
        type="text"
        placeholder="🔍 Tìm ví dụ... (Japanese, Romaji, Meaning...)"
        class="w-full p-3 rounded-xl border border-pink-200 focus:outline-none focus:ring-2 focus:ring-pink-300"
      />
    </div>

    <!-- FORM -->
    <ExampleForm @added="loadData" />

    <!-- LIST -->
    <div class="mt-6 grid gap-4">
      <ExampleCard
        v-for="e in examples"
        :key="e.id"
        :example="e"
        @deleted="loadData"
      />
    </div>

    <!-- 🔝 BACK TO TOP -->
    <button
      v-show="showButton"
      @click="scrollToTop"
      class="fixed bottom-6 right-6 bg-pink-400 hover:bg-pink-500 text-white px-4 py-2 rounded-full shadow-lg transition flex items-center gap-2"
    >
      🌸 Lên đầu
    </button>

  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import api from "../services/api";
import ExampleCard from "../components/ExampleCard.vue";
import ExampleForm from "../components/ExampleForm.vue";

const examples = ref([]);
const keyword = ref("");
const showButton = ref(false);

let timeout = null;

// ✅ load data
const loadData = async () => {
  const res = await api.getExamples();
  examples.value = res.data;
};

// 🔍 search + debounce
const handleSearch = () => {
  clearTimeout(timeout);

  timeout = setTimeout(async () => {
    if (!keyword.value.trim()) {
      return loadData();
    }

    try {
      const res = await api.search(keyword.value);
      examples.value = res.data;
    } catch (e) {
      console.error(e);
    }
  }, 300);
};

// 👀 theo dõi scroll
const handleScroll = () => {
  showButton.value = window.scrollY > 200;
};

// 🔝 scroll lên đầu
const scrollToTop = () => {
  window.scrollTo({
    top: 0,
    behavior: "smooth"
  });
};

onMounted(() => {
  loadData();
  window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});
</script>
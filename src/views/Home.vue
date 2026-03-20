<template>
  <div class="min-h-screen bg-pink-50 p-6">

    <h1 class="text-3xl font-bold text-pink-500 mb-4">
      🌸 Bé Nhi hoa anh đào
    </h1>

    <ExampleForm @added="loadData" />

    <div class="mt-6 grid gap-4">
      <ExampleCard
        v-for="e in examples"
        :key="e.id"
        :example="e"
        @deleted="loadData"
      />
    </div>

  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import api from "../services/api";
import ExampleCard from "../components/ExampleCard.vue";
import ExampleForm from "../components/ExampleForm.vue";

const examples = ref([]);

const loadData = async () => {
  const res = await api.getExamples();
  examples.value = res.data;
};

onMounted(loadData);
</script>
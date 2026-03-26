<template>
  <div class="perspective">

    <div
      class="card"
      :class="{ 
        flipped: isFlipped,
        selected: example.isSelect
      }"
      @click="toggleFlip"
    >

      <!-- FRONT -->
      <div class="card-face card-front">

        <!-- ⭐ Star -->
        <button
          type="button"
          class="star"
          @click.stop="toggleSelect"
        >
          {{ example.isSelect ? '⭐' : '☆' }}
        </button>

        <div class="content">
          <h3 class="text-lg font-bold text-pink-400">
            🍡 {{ example.situation }}
          </h3>

          <p class="mt-4 text-lg text-gray-700">
            💬 {{ example.meaning }}
          </p>

          <p class="text-xs text-gray-400 mt-2">
            (Click để lật thẻ)
          </p>
        </div>

        <div class="footer">
          <span class="px-3 py-1 bg-pink-100 text-pink-500 rounded-full text-xs">
            {{ example.level }}
          </span>
        </div>
      </div>

      <!-- BACK -->
      <div class="card-face card-back">

        <!-- ⭐ Star -->
        <button
          type="button"
          class="star"
          @click.stop="toggleSelect"
        >
          {{ example.isSelect ? '⭐' : '☆' }}
        </button>

        <!-- 👀 Badge -->
        <div class="seen">
          👀 Đã xem
        </div>

        <div class="content">
          <h3 class="text-lg font-bold text-pink-400">
            🍡 {{ example.situation }}
          </h3>

          <p class="mt-3 text-lg text-gray-800">
            🇯🇵 {{ example.japanese }}
          </p>

          <p class="text-gray-500 italic">
            📝 {{ example.romaji }}
          </p>

          <p class="mt-2 text-gray-700">
            💬 {{ example.meaning }}
          </p>

          <p class="mt-3 text-sm text-blue-400 bg-blue-50 px-2 py-1 rounded-md inline-block">
            📚 {{ example.grammar }}
          </p>
        </div>

        <div class="footer flex justify-between">
          <span class="px-3 py-1 bg-pink-100 text-pink-500 rounded-full text-xs">
            {{ example.level }}
          </span>

          <button
            type="button"
            class="text-red-400 text-sm"
            @click.stop="remove"
          >
            🗑️ Xóa
          </button>
        </div>
      </div>

    </div>

  </div>
</template>

<script setup>
import { ref } from "vue";
import api from "../services/api";

const props = defineProps(["example"]);
const emit = defineEmits(["deleted"]);

const isFlipped = ref(false);

const toggleFlip = () => {
  isFlipped.value = !isFlipped.value;
};

const toggleSelect = async () => {
  console.log("CLICK STAR"); // debug

  props.example.isSelect = !props.example.isSelect;

  try {
    await api.toggleSelect(props.example.id);
    console.log("API OK");
  } catch (e) {
    console.error("API FAIL", e);
    props.example.isSelect = !props.example.isSelect;
  }
};

const remove = async () => {
  await api.deleteExample(props.example.id);
  emit("deleted");
};
</script>

<style scoped>
/* ===== CONTAINER ===== */
.perspective {
  perspective: 1000px;
  width: 100%;
}

/* ===== CARD ===== */
.card {
  position: relative;
  display: grid;
  width: 100%;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  transform-style: preserve-3d;
  cursor: pointer;
}

.card.flipped {
  transform: rotateY(180deg);
  z-index: 10;
}

/* ===== FACE ===== */
.card-face {
  grid-area: 1 / 1;
  width: 100%;
  pointer-events: none; /* 👈 FIX QUAN TRỌNG */

  backface-visibility: hidden;

  display: flex;
  flex-direction: column;
  min-height: 200px;

  border-radius: 16px;
  padding: 20px;
  border: 1px solid #e5e7eb;
  background: white;
  box-sizing: border-box;

  position: relative;
}

/* 👉 Chỉ cho mặt đang thấy click được */
.card:not(.flipped) .card-front {
  pointer-events: auto;
}

.card.flipped .card-back {
  pointer-events: auto;
}

/* FRONT */
.card-front {
  transform: rotateY(0deg);
}

/* BACK */
.card-back {
  transform: rotateY(180deg);
  background: linear-gradient(135deg, #fef9c3, #fff);
  border-color: #facc15;
}

/* ⭐ Star */
.star {
  position: absolute;
  top: 12px;
  right: 12px;
  font-size: 20px;
  cursor: pointer;
  z-index: 5;
  transition: transform 0.2s;
}

.star:hover {
  transform: scale(1.2);
}

/* 👀 Seen */
.seen {
  position: absolute;
  bottom: 12px;
  right: 12px;
  font-size: 12px;
  color: #22c55e;
}

/* Selected */
.card.selected .card-face {
  border-color: #a855f7;
  border-width: 2px;
}

.card.selected {
  box-shadow: 0 8px 20px rgba(168, 85, 247, 0.35);
}

/* Layout */
.content {
  flex: 1;
  padding-top: 30px;
}

.footer {
  margin-top: 12px;
  margin-bottom: 12px;
}
</style>
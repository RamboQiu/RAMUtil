<template>
  <text class="message">222, let's use Vue.js to build your Weex app.</text>
</template>

<script>
const modal = weex.requireModule("modal");
modal.toast({
  message: "I am a toast3.",
  duration: 3,
});

const ramstatistics = weex.requireModule("RAMStatistics");
ramstatistics.recordEvent("test");
</script>
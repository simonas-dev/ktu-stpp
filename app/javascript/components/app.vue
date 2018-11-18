<template>
    <p id='wtf'>{{ message }}</p>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Welcome to the 💩show!"
      }
    }
  }
</script>

<style scoped>
  #wtf {
    font-size: 9em;
    text-align: center;
  }
</style>
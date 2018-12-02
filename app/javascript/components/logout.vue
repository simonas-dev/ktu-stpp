<template>
  <h1> 🙋‍♀️ Logging out...</h1>
</template>

<script>
  export default {
    data: function () {
      return {
        model: null,
        apiError: null, 
      }
    },
    created() {
      console.log("User Logout")
      setTimeout(() => {
        this.$setUser(null)
        this.$router.push('/login')
      }, 1000)
    }
  }
</script>
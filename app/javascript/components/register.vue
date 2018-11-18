<template>
  <div>
    <h4>Register</h4>
    <form>
      <label for="email" >E-Mail Address</label>
      <div>
        <input id="email" type="email" v-model="email" required>
      </div>

      <label for="password">Password</label>
      <div>
        <input id="password" type="password" v-model="password" required>
      </div>

      <div>
        <button type="submit" @click="handleSubmit">
          Register
        </button>
      </div>
    </form>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        email : "",
        password : ""
      }
    },
    methods : {
      handleSubmit(e) {
        e.preventDefault()
        if (this.password.length > 0) {
          this.$http.post("http://localhost:3000/api/v1/register", {
              email: this.email,
              password: this.password,
              password_confirmation: this.password,
          })
          .then(response => {
            console.log(response)
            localStorage.setItem('token', JSON.stringify(response.data))
            this.$router.push('/')
          })
          .catch(error => {
            console.error(error);
          });
        } else {
          this.password = ""
          return alert("Password cannot be empty!")
        }
      }
    }
  }
</script>
<template>
  <div>
    <div v-if="error != null" class="alert alert-danger" role="alert">
      {{ error }}
    </div>
    <b-input-group class="mb-3" prepend="Email Address">
      <b-form-input id="email" type="email" v-model="email" required></b-form-input>
    </b-input-group>
    <b-input-group class="mb-3" prepend="Password">
      <b-form-input id="password" type="password" v-model="password" required></b-form-input>
    </b-input-group>
    <b-button variant="outline-primary" @click="handleSubmit">LOG IN</b-button>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        email : "",
        password : "",
        error: null
      }
    },
    methods : {
      handleSubmit(e){
        error = null
        e.preventDefault()
        this.$http.post('http://localhost:3000/oauth/token', {
          grant_type: "password",
          email: this.email,
          password: this.password
        })
        .then(response => {
          console.log(response)
          localStorage.setItem('token', JSON.stringify(response.data))
        })
        .catch(errorLog => {
          const errorText = `${errorLog.response.status} ${errorLog.response.statusText}`
          console.error(errorText)
          this.error = errorText
        });
      }
    }
  }
</script>
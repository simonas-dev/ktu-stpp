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
    <b-input-group>
      <b-form-checkbox class="mb-3" id="checkbox1"
                       v-model="isSoulSold"
                       value="accepted"
                       unchecked-value="not_accepted">
        I accept the terms and conditions of selling my soul to the devil.
      </b-form-checkbox>
    </b-input-group>
    <b-button variant="outline-primary" @click="handleSubmit">REGISTER</b-button>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        email : "",
        password : "",
        error: null,
        isSoulSold: false,
      }
    },
    methods : {
      handleSubmit(e) {
        this.error = null
        if (!this.isSoulSold) {
          this.error = "Please agree with our terms, conditions and soul selling stuff!"
          return
        }
        if (this.password.length < 6) {
          this.password = ""
          this.error = "Password cannot be shorter than 6 characters!";  
          return
        }
        e.preventDefault()
        this.$http.post("http://localhost:3000/api/v1/register", {
            email: this.email,
            password: this.password,
            password_confirmation: this.password,
        })
        .then(response => {
          console.log(response)
          this.$setUser(response.data)
          this.$router.push('/')
        })
        .catch(errorLog => {
          const errorText = `${errorLog.response.data}`
          console.error(JSON.stringify(errorLog))
          this.error = errorText
        });
      }
    }
  }
</script>
<template>
  <div>
    <div v-if="apiError != null" class="alert alert-danger" role="alert">
      {{ apiError }}
    </div>
    <b-form @submit="saveBook" v-if="model != null">
      <h4 class="mb-3">Book</h4>
      <b-input-group class="mb-3" prepend="Name">
        <b-form-input id="email" v-model="model.name"></b-form-input>
      </b-input-group>
      
      <b-input-group class="mb-3" prepend="Summary">
        <b-form-input id="password" v-model="model.summmary" ></b-form-input>
      </b-input-group>

      <b-input-group class="mb-3" prepend="Page Count">
        <b-form-input id="password" v-model="model.page_count" ></b-form-input>
      </b-input-group>

      <b-button type="submit" variant="outline-primary">SAVE</b-button>
    </b-form>
  </div>
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
        this.$http.get(`http://localhost:3000/api/v1/book/${this.$route.params.id}`, {})
        .then(response => {
          console.log(response)
          this.model = response.data
        })
        .catch(error => {
          console.error(error)
          this.apiError = error
        })
    },
    methods: {
      saveBook: function() {
        console.log(this.model)
        
        this.$http.put(`http://localhost:3000/api/v1/book/${this.model.id}`, {
          body: this.model
        })
        .then(response => {
          console.log(response)
        })
        .catch(error => {
          console.error(error)
          this.apiError = error.response.statusText
        })
      },
    }
  }
</script>

<style scoped>

</style>

<template>
  <div>
    <b-form>
      <h2 class="mb-3">Book</h2>
      <b-input-group class="mb-3" prepend="Name">
        <b-form-input v-model="model.name"></b-form-input>
      </b-input-group>
      
      <b-input-group class="mb-3" prepend="Summary">
        <b-form-textarea v-model="model.summmary"
                     placeholder="Enter something"
                     :rows="2">
      </b-form-textarea>
      </b-input-group>

      <b-input-group class="mb-3" prepend="Page Count">
        <b-form-input v-model="model.page_count" ></b-form-input>
      </b-input-group>
      <b-col class="mb-3">
        <h5 class="mb-1">Authors</h5>
        <div class="mb-3">
          <b-button type="submit" @click="addAuthor" variant="outline-success">NEW AUTHOR</b-button>
        </div>
        <div v-for="author in model.authors">
          <b-form-input class="mb-1" id="password" v-model="author.first_name"></b-form-input>
          <b-form-input class="mb-1" id="password" v-model="author.last_name"></b-form-input>
          <b-form-input class="mb-1" id="password" v-model="author.group"></b-form-input>
          <b-button class="mb-3" variant="outline-danger" @click="deleteAuthor(author)">DELETE</b-button>
        </div>
      </b-col>

      <div v-if="apiError != null" class="alert alert-danger" role="alert">
        {{ apiError }}
      </div>
      <div v-if="apiResponse != null" class="alert alert-success" role="alert">
        {{ apiResponse }}
      </div>
      <div v-if="!isCreate" class="mb-3">
        <b-button type="submit" @click="saveBook" variant="outline-primary">UPDATE</b-button>
      </div>
      <div v-if="isCreate" class="mb-3">
        <b-button type="submit" @click="createBook" variant="outline-primary">CREATE</b-button>
      </div>
    </b-form>
  </div>
</template>

<script>

  export default {
    data: function () {
      var model = {
        id: null,
        name: "",
        summmary: "",
        page_count: "",
        authors: [],
      }
      if (this.$route.params.id != "new") {
        model.id = this.$route.params.id
      }
      console.log(model)
      return {
        model: model,
        apiError: null,
        apiResponse: null,
        isCreate: model.id == null,
      }
    },
    created() {
      if (!this.isCreate) {
        this.$http.get(`http://localhost:3000/api/v1/book/${this.model.id}`, {})
        .then(response => {
          console.log(response)
          this.model = response.data
        })
        .catch(error => {
          console.error(error)
          this.apiError = error
        })
      }
    },
    methods: {
      addAuthor: function() {
        console.log('addAuthor')
        // this.model.authors.add(0, {})
        this.model.authors.splice(0,0,{})
      },
      deleteAuthor: function(author) {
        var index = this.model.authors.indexOf(author)
        if (index != -1) {
          this.model.authors.splice(index, 1);
        }
      },
      createBook: function() {
        var request = this.$http.post(`http://localhost:3000/api/v1/book`, this.model)
        request
        .then(response => {          
          console.log(response)
          this.model = response.data
          this.apiResponse = "☁️ Created!"
          this.isCreate = false
          console.log(`replace/admin/book/${this.model.id}`)
          setTimeout(() => {
            this.$router.replace(`/admin/book/${this.model.id}`)
            this.apiResponse = null
          }, 1000)
        })
        .catch(error => {
          console.error(error)
          this.apiError = error.response.statusText
        })
      },
      saveBook: function() {
        this.$http.put(`http://localhost:3000/api/v1/book/${this.model.id}`, this.model)
        .then(response => {          
          console.log(response)
          this.isUpdate = false
          this.model = response.data
          this.apiResponse = "☁️ Saved!"
          setTimeout(() => {
            this.apiResponse = null
          }, 1000)
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

<template>
  <div>
    <div class="book-list-container" id="v-for-object" >
      <div class="card book-item mb-3" v-for="value in bookList">
        <div class="card-body">
          <h4 class="card-title text-dark">
            {{ value.name }}
          </h4>
          <div class="card-subtitle mb-2 text-muted">
            <div v-for="author in value.authors">
              <a class="badge badge-pill badge-light" >
                {{ author.first_name }} {{ author.last_name }}
              </a>
            </div>
          </div>
          <p class="card-text text-secondary">
            {{ value.summmary }}
          </p>
          <p class="card-text">
            <small class="text-muted">
              Updated {{ value.timeAgo }}
            </small>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import TimeAgo from 'javascript-time-ago'
  import en from 'javascript-time-ago/locale/en'
  TimeAgo.addLocale(en)

  export default {
    data: function () {
      return {
        bookList: []
      }
    },
    created() {
      this.$http.get("http://localhost:3000/api/v1/book", {})
      .then(response => {
        response.data.forEach(function(item) {
          var dateText = item.updated_at
          var date = new Date(dateText)
          var text = new TimeAgo("en").format(date)
          item.timeAgo = text 
        })
        this.bookList = response.data;
      })
      .catch(error => {
        console.error(error);
      })
    },
  }
</script>

<style scoped>
  div {
    margin-bottom: 2em;
  }
  body {
    background: #000;
  }
</style>

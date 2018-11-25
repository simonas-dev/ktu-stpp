<template>
    <div>
      <b-table :items="bookList" :fields="fields">
        <template slot="authors" slot-scope="data">
          <div v-for="author in data.item.authors">
            <a href="#" class="badge badge-pill badge-dark" >
              {{ author.first_name }} {{ author.last_name }}
            </a>
          </div>
        </template>
        <template slot="edit" slot-scope="data">
          <b-button variant="warning" @click="showEditBookModal(data.item)">EDIT</b-button>
        </template>
        <template slot="delete" slot-scope="data">
          <b-button variant="danger" @click="deleteBook(data.item)">DELETE</b-button>
        </template>
      </b-table>
  </div>
</template>

<script>
  import TimeAgo from 'javascript-time-ago'
  import en from 'javascript-time-ago/locale/en'
  TimeAgo.addLocale(en)

  export default {
    data: function () {
      return {
        editBook: null,
        bookList: [],
        fields: [
          {
            key: 'name',
            sortable: true
          },
          {
            key: 'summmary',
            sortable: false
          },
          {
            key: 'page_count',
            sortable: true
          },
          {
            key: 'created_at',
            sortable: true,
          },
          {
            key: 'updated_at',
            sortable: true,
          },
          {
            key: 'authors',
            sortable: false,
          },
          {
            key: 'edit',
            sortable: false,
          },
          {
            key: 'delete',
            sortable: false,
          }
        ],
      }
    },
    created() {
      this.$http.get("http://localhost:3000/api/v1/book", {})
      .then(response => {
        console.log(response)
        response.data.forEach(function(item) {
          var dateText = item.updated_at
          console.log(dateText)
          var date = new Date(dateText)
          console.log(date)
          var text = new TimeAgo("en").format(date)
          console.log(text)
          item.timeAgo = text 
        })
        this.bookList = response.data;
        console.log(this.bookList)
      })
      .catch(error => {
        console.error(error);
      })
    },
    methods: {
      showEditBookModal: function(book) {
        console.log(book)
        this.$router.push(`/admin/book/${book.id}`)
      },
      deleteBook: function(book) {
        var index = this.bookList.indexOf(book);
        if (index > -1) {
          this.bookList.splice(index, 1);
        }
      },
    },
  }
</script>

<style scoped>
</style>

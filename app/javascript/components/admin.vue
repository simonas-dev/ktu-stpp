<template>
    <div>
      <div v-if="error != null" class="alert alert-danger" role="alert">
        {{ error }}
      </div>
      <div class="mb-3">
        <b-button type="submit" @click="newBook" variant="outline-success">NEW BOOK</b-button>
      </div>
      <b-table hover :items="bookList" :fields="fields" @row-clicked="showEditBookModal">
        
        <template slot="created_at" slot-scope="data">
          {{ data.item.created_ago }}
        </template>
        <template slot="updated_at" slot-scope="data">
          {{ data.item.updated_ago }}
        </template>
        <template slot="actions" slot-scope="data">
          <b-container fluid>
          <b-row align-v="center">
            <b-button v-if="!data.item.is_deleted"
                    align-v="center"
                    variant="outline-danger"
                    @click="deleteBook(data.item)">
                    DELETE
            </b-button>

            <h2 v-if="data.item.is_deleted"
                align-v="center">
              💣
            </h2>
          </b-row>
        </b-container>
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
        error: null,
        editBook: null,
        bookList: [],
        fields: [
          {
            key: 'name',
            sortable: true
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
            key: 'actions',
            sortable: false,
          }
        ],
      }
    },
    created() {
      this.$http.get("http://localhost:3000/api/v1/book", {})
      .then(response => {
        response.data.forEach(function(item) {
          item.updated_ago = new TimeAgo("en").format(
            new Date(item.updated_at) 
          )
          item.created_ago = new TimeAgo("en").format(
            new Date(item.created_at) 
          ) 
        })
        this.bookList = response.data
      })
      .catch(error => {
        console.error(error);
      })
    },
    methods: {
      showEditBookModal: function(item) {
        this.$router.push(`/admin/book/${item.id}`)
      },
      deleteBook: function(book) {
        this.$http.delete(`http://localhost:3000//api/v1/book/${book.id}`, {})
        .then(response => {
          var index = this.bookList.indexOf(book);
          book.is_deleted = true
          copyBookList = this.bookList
          copyBookList[index] = book
          this.bookList = copyBookList
        })
        .catch(error => {
          this.error = error
        })
      },
      newBook: function() {
        this.$router.push(`/admin/book/new`)
      },
    },
  }
</script>

<style scoped>
</style>

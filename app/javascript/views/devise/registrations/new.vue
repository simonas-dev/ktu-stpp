<script>
  // .vue files typically have 3 section
  // 1.template - markup, 2.script - js, 3.style - css
  // we are importing the csrf component it has two hidden input fields
  // for csrf token and utf encoding
  // creating a component helps us reuse it in multiple forms
  import CSRF from 'components/shared/csrf.vue';
  export default {
    // register component to be usable in views
    components: {
      csrf: CSRF
    },
    // props are all the properties that will be passed to this component
    // we will see how easy it is for us to pass the devise error message to vue
    // without having to reinvent everything and falling back to ajax calls
    props: {
      errors: Array
    },
    // data are the actual state which are changed in real time
    // we don't use them much, this is how it can be done
    data: function() {
      return ({
        user: {
          name: '',
          email: '',
          password: ''
        },
        // these are the validation rules that I'll pass to my component
        // if you have used react, validation is very easy in vue
        rules: {
          email: [
            {type: 'email', trigger: 'blur,change'}
          ]
        }
      });
    }
  }
</script>

<template>
  <!-- this div is the top level container where -->
  <div class="">
    <!-- as we talked above these are the errors passed to us from the .erb files  -->
    <!-- here we iterate through all the errors and create an alert for them -->
    <el-alert v-for="error in errors"
      type="error"
      :title="error"
      :closable="false"
    >
  </el-alert>
  <el-container class="bg-light" style="height: 100vh;">
    <el-main>
      <el-row type="flex" justify="center">
        <el-col :xs="24" :sm="12">
          <el-card class="box-card" style="width: 100%">
            <div slot="header" class="clearfix">
              <h3>Signup</h3>
            </div>
            <!-- form for the sign up -->
            <!-- we pass in what object should be used to store the data, i.e user -->
            <!-- we pass it the rule for validation -->
            <!-- we say the method is post -->
            <!-- we also tell it the endpoint for post call-->
            <el-form :model="user" :rules="rules" label-position="top" method="post" action="/users">
              <!-- just adding one line will add all the common csrf fields -->
              <!-- as you can see, all my logic are resued -->
              <csrf></csrf>

              <!-- this is where the actual form begins -->
              <!-- i'm telling it should have the label 'Name' -->
              <!-- it should use property 'name' for validation -->
              <!-- and the field is required -->
              <el-form-item label="Name" prop="name" required>
                <!-- i give the input field a name, as required for a form -->
                <!-- the format is important, as controller accept data insider users hash -->
                <!-- we talked about the state in above section -->
                <!-- i use v-model to bind the input to the state -->
                <!-- so that any changes in the input will change the varible user.name -->
                <el-input name="user[name]" v-model="user.name" >
                </el-input>
              </el-form-item>


              <!-- all fields are very similar to the first one -->
              <el-form-item label="Email" prop="email" required>
                <el-input name="user[email]" v-model="user.email" type="email">
                </el-input>
              </el-form-item>

              <el-form-item label="Password" prop="password" required>
                <el-input v-model="user.password" name="user[password]" type="password" autocomplete="off">
                </el-input>
              </el-form-item>

              <el-form-item>
                <el-button native-type="submit" type="primary" class="m-t-10">
                  Create
                </el-button>
              </el-form-item>
            </el-form>

            <a href="/users/sign_in">
              <el-button type="text" style="margin-left: 10px">
                Sign In
              </el-button>
            </a>

          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</div>
</template>

<style scoped>
  /*some style which will only be applied to content in this component*/
  .box-card {
    margin-top: 30px;
  }
</style>
/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import Vue from 'vue/dist/vue.esm'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'
import Axios from 'axios'

import App from 'app.vue'
import Login from 'components/login'
import Logout from 'components/logout'
import Register from 'components/register'
import BookList from 'components/book_list'
import BookEdit from 'components/book_edit'
import Admin from 'components/admin'

Vue.use(BootstrapVue);
Vue.use(VueRouter);

Vue.prototype.$http = Axios;

function setAuthHeaders(userModel) {
  var userObj = JSON.parse(userModel)
  console.log(typeof userObj)
  console.log(userObj)
  if (userObj != null) {
    var tokenHeader = `Bearer ${userObj.access_token}`
    Axios.defaults.headers.common['Authorization'] = tokenHeader  
  } else {
    Axios.defaults.headers.common['Authorization'] = null 
  }
}

Vue.prototype.$user = localStorage.getItem('token')

Vue.prototype.$setUser = function(userModel) {
  var userModelString = JSON.stringify(userModel)
  if (userModel == null) {
    userModelString = null
  }
  
  console.log("Logged In")
  console.log(userModelString)
  localStorage.setItem('token', userModelString)
  setAuthHeaders(userModelString)

  Vue.prototype.$user = userModelString
}

setAuthHeaders(Vue.prototype.$user)

const routes = [
  { path: '/', redirect: '/home' },
  { 
    path: '/logout',
    name: 'logout',
    component: Logout,
    meta: {
      requiresAuth: false
    }
  },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: { 
      requiresAuth: false
    }
  },
  {
    path: '/register',
    name: 'register',
    component: Register,
    meta: { 
      requiresAuth: false
    }
  },
  {
    path: '/home',
    name: 'book list',
    component: BookList,
    meta: { 
      requiresAuth: false
    }
  },
  {
    path: '/admin',
    name: 'admin dashboard',
    component: Admin,
    meta: { 
      requiresAuth: true
    }
  },
  {
    path: '/admin/book/:id',
    name: 'edit boook',
    component: BookEdit,
    meta: { 
      requiresAuth: true
    }
  },
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = new VueRouter({
  routes // short for `routes: routes`
})

router.beforeEach((to, from, next) => {
  var isLoggedIn = localStorage.getItem('token') != null
  var requiresAuth = to.matched.some(record => record.meta.requiresAuth)
  if (requiresAuth && !isLoggedIn) {
    next({
      path: '/login',
      params: { nextUrl: to.fullPath }
    })
  } else {
    next(next)
  }
})

Vue.config.productionTip = false

// Now the app has started!
document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  // 4. Create and mount the root instance.
  // Make sure to inject the router with the router option to make the
  // whole app router-aware.
  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount('#app')
})

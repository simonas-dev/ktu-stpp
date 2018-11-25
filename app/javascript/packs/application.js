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

import Login from 'components/login'
import Register from 'components/register'
import BookList from 'components/book_list'
import BookEdit from 'components/book_edit'
import Admin from 'components/admin'

Vue.use(BootstrapVue);
Vue.use(VueRouter);

var tokenObj = JSON.parse(localStorage.getItem('token'))
var tokenHeader = `Bearer ${tokenObj.access_token}`
Axios.defaults.headers.common['Authorization'] = tokenHeader

Vue.prototype.$http = Axios;

const routes = [
  { path: '/', redirect: '/home' },
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

// Now the app has started!
document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  // 4. Create and mount the root instance.
  // Make sure to inject the router with the router option to make the
  // whole app router-aware.
  const app = new Vue({
    router
  }).$mount('#app')
})

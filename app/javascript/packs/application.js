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

Vue.use(BootstrapVue);
Vue.use(VueRouter);
Vue.prototype.$http = Axios;

const routes = [
  { path: '/', redirect: '/home' },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: { 
      guest: true
    }
  },
  {
    path: '/register',
    name: 'register',
    component: Register,
    meta: { 
      guest: true
    }
  },
  {
    path: '/home',
    name: 'book list',
    component: BookList,
    meta: { 
      guest: true
    }
  },
  // {
  //   path: '/admin',
  //   name: 'admin',
  //   component: Admin,
  //   meta: { 
  //     requiresAuth: true,
  //   }
  // },
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = new VueRouter({
  routes // short for `routes: routes`
})

// router.beforeEach((to, from, next) => {
//   if (to.matched.some(record => record.meta.requiresAuth)) {
//     if (localStorage.getItem('jwt') == null) {
//       next({
//         path: '/login',
//         params: { nextUrl: to.fullPath }
//       })
//     }
//   } else if(to.matched.some(record => record.meta.guest)) {
      
//   }
// })

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

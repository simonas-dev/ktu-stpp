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

Vue.use(BootstrapVue);
Vue.use(VueRouter);

// 1. Define route components.
// These can be imported from other files
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

// 2. Define some routes
// Each route should map to a component. The "component" can
// either be an actual component constructor created via
// `Vue.extend()`, or just a component options object.
// We'll talk about nested routes later.
const routes = [
  {
    path: '/',
    name: 'HelloWorld',
    component: HelloWorld
  },
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
      path: '/admin',
      name: 'admin',
      component: Admin,
      meta: { 
          requiresAuth: true,
      }
  },
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = new VueRouter({
  base: "/foo",
  routes // short for `routes: routes`
})

router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
      if (localStorage.getItem('jwt') == null) {
          next({
              path: '/login',
              params: { nextUrl: to.fullPath }
          })
      } else {
          let user = JSON.parse(localStorage.getItem('user'))
          if(to.matched.some(record => record.meta.is_admin)) {
              if(user.is_admin == 1){
                  next()
              } else{
                  next({ name: 'userboard'})
              }
          }else {
              next()
          }
      }
  } else if(to.matched.some(record => record.meta.guest)) {
      if(localStorage.getItem('jwt') == null){
          next()
      }
      else{
          next({ name: 'userboard'})
      }
  }else {
      next() 
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


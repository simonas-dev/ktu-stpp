<template>
  <b-container>
    <div class="header">
      <h1 class="header-title">📚.app</h1>
      <p>
      <!-- use router-link component for navigation. -->
      <!-- specify the link by passing the `to` prop. -->
      <!-- `<router-link>` will be rendered as an `<a>` tag by default -->
      <b-nav pills>
        <b-nav-item to="/home">Home</b-nav-item>
        <b-nav-item v-if="this.$user == null" to="/login">Log In</b-nav-item>
        <b-nav-item v-if="this.$user == null" to="/register">Register</b-nav-item>
        <b-nav-item v-if="this.$user != null" to="/admin">Admin</b-nav-item>
        <b-nav-item v-if="this.$user != null" to="/logout">Log Out</b-nav-item>
      </b-nav>
    </p>
    </div>

    <router-view class="content"></router-view>
    
    <div class="footer card text-secondary">
      <div class="card-body">
        <p class="lead">© 2018 Simonas Sankauskas, Inc.</p>
        <p>KTU "Saityno taikomųjų programų projektavimas" project.</p>
        <a class="btn card-link btn-outline-primary" href="https://github.com/simonassank/ktu-stpp" target="_self">Source Code</a>
      </div>
    </div>

  </b-container>
</template>
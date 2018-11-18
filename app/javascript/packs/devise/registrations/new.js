import Vue from 'vue/dist/vue.esm';

// This the .vue file that we will create next
import DeviseRegistrationsNewView from 'views/devise/registrations/new.vue';

// creating a new vue instance
const integrationIndex = new Vue({
    // I am telling vue to look for the below id and
    // mount my view into that id
    // it is super important, make sure you spell it right at all places
    el: '#devise-registrations-new-view',
    // this is simple vue component registration
    // if you want to use a component in the view you'll have to register it
    components: {
        'devise-registrations-new-view': DeviseRegistrationsNewView
    }
});
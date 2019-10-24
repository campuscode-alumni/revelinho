import Vue from 'vue/dist/vue.esm'
import CandidateCard from '../components/CandidateCard.vue'
import { CandidateClient } from './candidates/candidates_client'

document.addEventListener('DOMContentLoaded', () => {
  const client = new CandidateClient();

  const candidate = new Vue({
    el: '#candidate',
    data: {
      candidates: []
    },
    components: {
      CandidateCard
    },
    created: function() {
      let that = this;

      client.search(function(candidates) {
        console.log(candidates);
        that.candidates = candidates
      });
    }
  })
})

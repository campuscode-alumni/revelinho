import Vue from 'vue/dist/vue.esm'
import { CandidatesClient } from './candidates/candidates_client'
import CandidateCard from '../components/CandidateCard.vue'
import CandidateList from '../components/CandidateList.vue'

document.addEventListener('DOMContentLoaded', () => {
  const candidates_client  = new CandidatesClient()

  const candidate = new Vue({
    el: '#candidate',
    components: {
      CandidateCard,
      CandidateList
    },
    data: {
      candidates: [],
      showCard: false
    },
    methods: {
      toggleCard: function(boolean) {
        this.showCard = boolean;
      }
    },
    created: function() {
      let that = this;

      candidates_client.search(function(c) {
        that.candidates = c;
      });
    }
  })
})

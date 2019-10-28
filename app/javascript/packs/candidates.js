import Vue from 'vue/dist/vue.esm'
import { CandidatesClient } from './candidates/candidates_client'

document.addEventListener('DOMContentLoaded', () => {
  const candidates_client  = new CandidatesClient()

  const candidate = new Vue({
    el: '#candidate',
    data: {
      candidates: []
    },
    created: function() {
      let that = this;

      candidates_client.search(function(c) {
        that.candidates = c;
      });
    }
  })
})

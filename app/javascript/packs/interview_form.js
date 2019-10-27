import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'

Vue.use(Antd);

import InterviewForm from '../components/InterviewForm.vue'
import { InterviewClient } from './interviews/interviews_client'

document.addEventListener('DOMContentLoaded', () => {
  const client = new InterviewClient()

  const interview = new Vue({
    el: '#interview-form',
    data: {
      interview: {
        date: '',
        time_from: '',
        time_to: '',
        address: '',
        selection_process_id: null
      }
    },
    components: {
      InterviewForm
    },
    methods: {
      create: () => {
        // let that = this
        console.log(interview)
        // client.search(function(interviews) {
        //   console.log(interviews);
        //   that.interviews = interviews
        // })
      }
    }
  })
})
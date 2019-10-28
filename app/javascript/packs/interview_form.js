import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'

Vue.use(Antd);

import InterviewForm from '../components/InterviewForm.vue'

document.addEventListener('DOMContentLoaded', () => {

  new Vue({
    el: 'interview-form',
    components: {
      InterviewForm
    }
  })
})
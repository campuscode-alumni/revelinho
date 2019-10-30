import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'

Vue.use(Antd);

import InterviewForm from '../components/interviews/InterviewForm.vue'
import InterviewCalendar from '../components/interviews/InterviewCalendar.vue'

document.addEventListener('DOMContentLoaded', () => {

  const interview = new Vue({
    el: '#interviews',
    components: {
      InterviewCalendar,
      InterviewForm
    }
  })
})
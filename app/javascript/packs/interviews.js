import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(Antd);
Vue.use(TurbolinksAdapter)

import InterviewForm from '../components/interviews/InterviewForm.vue'
import InterviewCalendar from '../components/interviews/InterviewCalendar.vue'

document.addEventListener('turbolinks:load', () => {

  const interview = new Vue({
    el: '#interviews',
    components: {
      InterviewCalendar,
      InterviewForm
    }
  })
})

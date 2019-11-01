import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(Antd);
Vue.use(TurbolinksAdapter)

import InterviewForm from '../components/interviews/InterviewForm.vue'
import InterviewsCalendar from '../components/interviews/InterviewsCalendar.vue'
import InterviewsSidebar from '../components/interviews/InterviewsSidebar.vue'

document.addEventListener('turbolinks:load', () => {

  const interview = new Vue({
    el: '#interviews',
    components: {
      InterviewsCalendar,
      InterviewsSidebar,
      InterviewForm
    }
  })
})

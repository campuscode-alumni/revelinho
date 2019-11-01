import Vue from 'vue/dist/vue.esm'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'
import TurbolinksAdapter from 'vue-turbolinks'

import InterviewForm from '../components/interviews/InterviewForm.vue'
import InterviewsCalendar from '../components/interviews/InterviewsCalendar.vue'
import InterviewsSidebar from '../components/interviews/InterviewsSidebar.vue'

import { InterviewClient } from './interviews/interviews_client'

Vue.use(Antd)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const authToken = $('meta[name=csrf-token]').attr('content')
  const client = new InterviewClient()

  const interview = new Vue({
    el: '#interviews',
    data: () => ({
      formLoading: false,
      formVisible: false,
      interviews: [{
        id: 1,
        date: '12/11/2019',
        time_from: '15:00',
        time_to: '16:00',
        position: {
          title: 'Dev VueJS melhor carreira!'
        },
        candidate: {
          name: 'Patrícia'
        }
      }, {
        id: 2,
        date: '13/11/2019',
        time_from: '17:00',
        time_to: '18:00',
        position: {
          title: 'Dev VueJS melhor carreira!'
        },
        candidate: {
          name: 'Gustavo'
        }
      }, {
        id: 2,
        date: '13/11/2019',
        time_from: '15:00',
        time_to: '15:30',
        position: {
          title: 'Dev VueJS melhor carreira!'
        },
        candidate: {
          name: 'Kelvin'
        }
      }]
    }),
    components: {
      InterviewsCalendar,
      InterviewsSidebar,
      InterviewForm
    },
    methods: {
      create: function({interview, url}) {
        this.formLoading = true
        client.create({
          ...interview
        }, {
          url,
          token: authToken
        }, this.handleCreated)
      },
      handleCreated(res, error) {
        this.formLoading = false
        if (error) {
          this.notifyUserError()
        } else {
          this.formVisible = false
          this.notifyUserSuccess()
          this.interviews.push(res)
          console.log(this.interviews)
        }
      },
      notifyUserSuccess() {
        this.$notification['success']({
          message: 'Sucesso',
          description: 'Entrevista salva',
        })
      },
      notifyUserError() {
        this.$notification['error']({
          message: 'Erro',
          description: 'Erro ao salvar entrevista'
        })
      },
      formShow() {
        this.formVisible = true;
      },
      formClose() {
        this.formVisible = false;
      }
    }
  })
})

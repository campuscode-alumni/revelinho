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
      loading: false,
      interviews: [],
      formLoading: false,
      formVisible: false,
      formInterview: {}
    }),
    components: {
      InterviewsCalendar,
      InterviewsSidebar,
      InterviewForm
    },
    methods: {
      load(url) {
        this.loading = true
        client.search({
          url,
          token: authToken
        }, this.handleLoaded)
      },
      create({interview, url}) {
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
          this.notifyUserError('Erro ao salvar entrevista')
        } else {
          this.formVisible = false
          this.notifyUserSuccess()
          this.interviews.push(res)
        }
      },
      handleLoaded(res, error) {
        this.loading = false
        if (error) {
          this.notifyUserError('Houve algum erro ao carregar suas entrevistas :(')
        } else {
          this.interviews = res
        }
      },
      notifyUserSuccess() {
        this.$notification['success']({
          message: 'Sucesso',
          description: 'Entrevista salva',
        })
      },
      notifyUserError(message) {
        this.$notification['error']({
          message: 'Erro',
          description: message
        })
      },
      formShow() {
        this.formInterview = null
        this.formVisible = true
      },
      formClose() {
        this.formVisible = false
      },
      formEdit(id) {
        this.formInterview = this.interviews.find(interview => interview.id === id)
        this.formVisible = true
      }
    }
  })
})

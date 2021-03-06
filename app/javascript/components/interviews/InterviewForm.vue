<template>
  <div id="interviews-form">
    <a-button id="interview-modal-button" type="primary" @click="showModal" shape="circle" icon="plus" :style="showModalButtonStyle"></a-button>
    <a-modal
      :title="title"
      :visible="visible"
      @ok="handleSubmit"
      :confirmLoading="loading"
      @cancel="handleCancel"
    >
      <a-form :form="form">
        <a-form-item label="Data" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-date-picker id="date-field" @change="onChangeDate" :format="dateFormat" :value="date" :allow-clear="false"/>
        </a-form-item>

        <a-form-item label="Horário" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-form-item :style="{ display: 'inline-block', marginRight: '2em' }">
            <a-time-picker id="time-from-field" @change="onChangeTimeFrom" :minuteStep="5" :format="timeFormat" :value="timeFrom"></a-time-picker>
          </a-form-item>

          <a-form-item :style="{ display: 'inline-block' }">
            <a-time-picker id="time-to-field" @change="onChangeTimeTo" :minuteStep="5" :format="timeFormat" :value="timeTo"></a-time-picker>
          </a-form-item>
        </a-form-item>

        <a-form-item label="Endereço" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-input
            id="address-field"
            v-model="interview.address"
          />
        </a-form-item>

        <a-form-item label="Tipo de entrevista" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-radio-group v-model="interview.format" >
            <a-radio-button
              v-for="format in formats"
              :key="format.value"
              :value="format.value"
              :id="format.value"
            >
              {{ format.name }}
            </a-radio-button>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
  import moment from 'moment'
  import 'moment/locale/pt-br'
  moment.locale('pt-br')

  export default {
    data() {
      return {
        initialInterview: {
          date: moment().format('YYYY-MM-DD'),
          time_from: moment().format('HH:mm'),
          time_to: moment().format('HH:mm'),
          address: '',
          format: '',
        },
        interview: {},
        dateFormat: 'DD/MM/YYYY',
        timeFormat: 'HH:mm',
        form: this.$form.createForm(this, { name: 'new-interview' }),
        controlStyle: {
          label: { span: 7 },
          wrapper: { span: 17, marginBottom: 0 },
          item: { marginBottom: '8px' }
        },
        showModalButtonStyle: {
          position: 'absolute',
          right: '2em',
          bottom: '14em'
        },
        errorMessage: 'Erro ao salvar entrevista',
        successMessage: 'Entrevista salva com sucesso'
      }
    },
    props: {
      setInterview: null,
      formats_json: '',
      createUrl: '',
      loading: false,
      visible: false
    },
    computed: {
      title() {
        return this.setInterview ? 'Reagendar Entrevista' : 'Agendar Entrevista'
      },
      formats() {
        return JSON.parse(this.formats_json || {}).formats
      },
      date() {
        return moment(this.interview.date, 'YYYY-MM-DD')
      },
      timeFrom() {
        return moment(this.interview.time_from, 'HH:mm')
      },
      timeTo() {
        return moment(this.interview.time_to, 'HH:mm')
      }
    },
    methods: {
      showModal() {
        this.$emit('show')
      },
      onChangeDate(date, dateString) {
        this.interview.date = date.format('YYYY-MM-DD')
      },
      onChangeTimeFrom(time, timeString) {
        this.interview.time_from = timeString
      },
      onChangeTimeTo(time, timeString) {
        this.interview.time_to = timeString
      },
      handleCancel() {
        this.$emit('close')
      },
      handleSubmit() {
        const method = this.setInterview ? 'update' : 'create'
        this.$emit(method, {
          interview: this.interview,
          url: this.createUrl
        })
      }
    },
    watch: {
      visible(visible) {
        if (visible) {
          if (this.setInterview) {
            this.interview = {...this.setInterview}
          } else {
            this.interview = {...this.initialInterview}
          }
        }
      }
    }
  }
</script>

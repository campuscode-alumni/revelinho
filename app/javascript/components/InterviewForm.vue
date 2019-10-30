<template>
  <div id="app">
    <a-button id="interview-modal-button" type="primary" @click="showModal" shape="circle" icon="plus" :style="showModalButtonStyle"></a-button>

    <a-modal
      title="Agendar Entrevista"
      :visible="visible"
      @ok="handleSubmit"
      :confirmLoading="loading"
      @cancel="handleCancel"
    >
      <a-form :form="form">
        <a-form-item label="Data" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-date-picker id="date-field" @change="onChangeDate" :format="dateFormat"/>
        </a-form-item>

        <a-form-item label="Horário" :label-col="controlStyle.label" :wrapper-col="controlStyle.wrapper" :style="controlStyle.item">
          <a-form-item :style="{ display: 'inline-block', marginRight: '2em' }">
            <a-time-picker id="time-from-field" @change="onChangeTimeFrom" :minuteStep="5" :format="timeFormat"></a-time-picker>
          </a-form-item>

          <a-form-item :style="{ display: 'inline-block' }">
            <a-time-picker id="time-to-field" @change="onChangeTimeTo" :minuteStep="5" :format="timeFormat"></a-time-picker>
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
  import { InterviewClient } from '../packs/interviews/interviews_client'

  const client = new InterviewClient()
  const authToken = $('meta[name=csrf-token]').attr('content')

  export default {
    data() {
      return {
        initialInterview: {
          date: '',
          time_from: '',
          time_to: '',
          address: '',
          format: '',
        },
        interview: {},
        dateFormat: 'DD/MM/YYYY',
        timeFormat: 'HH:mm',
        form: this.$form.createForm(this, { name: 'new-interview' }),
        visible: false,
        loading: false,
        controlStyle: {
          label: { span: 7 },
          wrapper: { span: 17, marginBottom: 0 },
          item: { marginBottom: '8px' }
        },
        showModalButtonStyle: {
          position: 'absolute',
          right: '2em',
          bottom: '2em'
        },
        errorMessage: 'Erro ao salvar entrevista',
        successMessage: 'Entrevista salva com sucesso'
      };
    },
    props: {
      formats_json: '',
      create_url: ''
    },
    computed: {
      formats: function() {
        return JSON.parse(this.formats_json || {}).formats
      }
    },
    methods: {
      showModal() {
        this.visible = true;
      },
      onChangeDate(date, dateString) {
        this.interview.date = dateString
      },
      onChangeTimeFrom(time, timeString) {
        this.interview.time_from = timeString
      },
      onChangeTimeTo(time, timeString) {
        this.interview.time_to = timeString
      },
      handleCancel() {
        this.visible = false
      },
      handleSubmit(e) {
        this.loading = true
        client.create({
          ...this.interview
        }, {
          url: this.create_url,
          token: authToken
        }, this.submitCallback)
      },
      submitCallback(res, error) {
        this.loading = false;
        if (error) {
          this.notifyUserError()
        } else {
          this.visible = false;
          this.notifyUserSuccess()
        }
      },
      notifyUserSuccess() {
        this.$notification['success']({
          message: 'Sucesso',
          description: 'Entrevista salva',
        });
      },
      notifyUserError() {
        this.$notification['error']({
          message: 'Erro',
          description: 'Erro ao salvar entrevista'
        })
      }
    }
  }
</script>

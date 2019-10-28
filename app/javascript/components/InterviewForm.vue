<template>
  <div id="app">
    <a-button type="primary" @click="showModal" shape="circle" icon="plus"></a-button>

    <a-modal
      title="Agendar Entrevista"
      :visible="visible"
      @ok="handleOk"
      :confirmLoading="confirmLoading"
      @cancel="handleCancel"
    >
      <a-form :form="form" @submit="handleSubmit">
        <a-form-item label="Data" :label-col="{ span: 5 }" :wrapper-col="{ span: 3 }">
          <a-date-picker @change="onChangeDate" :format="dateFormat"/>
        </a-form-item>
        <a-form-item label="Horário" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }">
          <a-time-picker @change="onChangeTimeFrom" :minuteStep="5" :format="timeFormat"></a-time-picker>
          <a-time-picker @change="onChangeTimeTo" :minuteStep="5" :format="timeFormat"></a-time-picker>
        </a-form-item>
        <a-form-item label="Endereço" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }">
          <a-input
            v-model="address"
          />
        </a-form-item>
        <a-form-item label="Tipo de entrevista" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }">
          <a-radio-group v-model="format">
            <a-radio-button
              v-for="format in formats"
              :key="format.value"
              :value="format.value"
            >
              {{ format.name }}
            </a-radio-button>
          </a-radio-group>
        </a-form-item>
        <a-form-item :wrapper-col="{ span: 12, offset: 5 }">
          <a-button type="primary" html-type="submit">
            Submit
          </a-button>
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
        date: '',
        time_from: '',
        time_to: '',
        address: '',
        format: '',
        dateFormat: 'DD/MM/YYYY',
        timeFormat: 'HH:mm',
        form: this.$form.createForm(this, { name: 'new-interview' }),
        ModalText: 'Content of the modal',
        visible: false,
        confirmLoading: false
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
      handleOk(e) {
        this.ModalText = 'The modal will be closed after two seconds';
        this.confirmLoading = true;
        setTimeout(() => {
          this.visible = false;
          this.confirmLoading = false;
        }, 2000);
      },
      handleCancel(e) {
        console.log('Clicked cancel button');
        this.visible = false;
      },
      onChangeDate(date, dateString) {
        this.date = dateString
      },
      onChangeTimeFrom(time, timeString) {
        this.time_from = timeString
      },
      onChangeTimeTo(time, timeString) {
        this.time_to = timeString
      },
      handleSubmit(e) {
        e.preventDefault()
        client.create({
          date: this.date,
          time_from: this.time_from,
          time_to: this.time_to,
          address: this.address,
          format: this.format
        }, {
          url: this.create_url,
          token: authToken
        }, (res, error) => {
          this.notifyUser(error ? 'error' : 'success')
        })
      },
      notifyUser(type) {
        this.$notification[type]({
          message: 'Sucesso',
          description:
            'Entrevista salva',
        });
      }
    }
  }
</script>
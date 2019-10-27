<template>
  <div id="app">
    <a-form :form="form" @submit="handleSubmit">
      <a-form-item label="Endereço" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }">
        <a-input
          v-decorator="['address', { rules: [{ required: true, message: 'Endereço é obrigatório' }] }]"
        />
      </a-form-item>
      <a-form-item label="Tipo de entrevista" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }">
        <a-select
          v-decorator="[
            'format',
            { rules: [{ required: true, message: 'Tipo de entrevista é obrigatório' }] },
          ]"
          placeholder="Selecione uma opção"
          @change="handleFormatChange"
        >
          <!-- <%= Interview.formats.map { |k, v| [ I18n.t(:"format.#{k}"), k] }.each do |text, value| %>
            <a-select-option :value="value">
              {{ text }}
            </a-select-option>
          <% end %> -->
        </a-select>
      </a-form-item>
      <a-form-item :wrapper-col="{ span: 12, offset: 5 }">
        <a-button type="primary" html-type="submit">
          Submit
        </a-button>
      </a-form-item>
    </a-form>
  </div>
</template>

<script>
  export default {
    prop: ['interview']
  }
</script>
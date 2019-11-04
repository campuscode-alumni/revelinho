<template>
  <div id="interviews-calendar">
    <a-calendar @select="onSelect">
      <ul class="events" slot="dateCellRender" slot-scope="value">
        <div v-for="item in getDayData(value)" :key="item.id" @click.stop="() => handleClickEvent(item)">
          <a-badge :status="item.type" :text="item.content"/>
        </div>
      </ul>
    </a-calendar>
  </div>
</template>

<script>
  import moment from 'moment'
  import 'moment/locale/pt-br'
  moment.locale('pt-br')

  export default {
    props: ['interviews', 'searchUrl'],
    mounted() {
      this.$emit('load', this.searchUrl)
    },
    methods: {
      getDayData(calendarDate) {
        return this.interviews.filter(interview => moment(interview.date, 'YYYY-MM-DD').isSame(calendarDate, 'day'))
                              .map(interview => ({
                                id: interview.id,
                                type: 'success',
                                content: `${interview.time_from} às ${interview.time_to}`
                              }))
                              .sort(a => a.time_from).reverse() || []
      },
      onSelect(value) {
        this.$emit('clickDate', value)
      },
      handleClickEvent(item) {
        this.$emit('click-event', item.id)
      }
    }
  }
</script>

<style scoped>
  .events {
    padding-left: 1em;
  }
</style>
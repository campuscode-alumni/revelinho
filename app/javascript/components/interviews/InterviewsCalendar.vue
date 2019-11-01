<template>
  <div id="interviews-calendar">
    <a-calendar @select="onSelect">
      <ul class="events" slot="dateCellRender" slot-scope="value">
        <li v-for="item in getDayData(value)" :key="item.content" @click.stop="() => handleClickEvent(item)">
          <a-badge :status="item.type" :text="item.content" />
        </li>
      </ul>
      <template slot="monthCellRender" slot-scope="value">
        <div v-if="getMonthData(value)" class="notes-month">
          <section>{{getMonthData(value)}}</section>
          <span>Backlog number</span>
        </div>
      </template>
    </a-calendar>
  </div>
</template>

<script>
  export default {
    props: ['interviews'],
    methods: {
      getDayData(value) {
        const interviewDate = value.format('DD/MM/YYYY')
        const listData = this.interviews.filter(interview => interview.date === interviewDate)
                                        .map(interview => ({
                                          type: 'success',
                                          content: interview.candidate.name + ' / ' + interview.position.title
                                        }))
        return listData || []
      },
      getMonthData(value) {
        if (value.month() === 8) {
          return 1394
        }
      },
      onSelect(value) {
        console.log(value)
      },
      handleClickEvent(item) {
        console.log(item.content)
      }
    }
  }
</script>
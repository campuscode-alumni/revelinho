<template>
  <div id="app">
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
    data: () => ({
      interviews: []
    }),
    methods: {
      getDayData(value) {
        let listData
        switch (value.date()) {
          case 8:
            listData = [
              { type: 'warning', content: 'This is warning event.' },
              { type: 'success', content: 'This is usual event.' },
            ]
            break
          case 10:
            listData = [
              { type: 'warning', content: 'This is warning event.' },
              { type: 'success', content: 'This is usual event.' },
              { type: 'error', content: 'This is error event.' },
            ]
            break
          case 15:
            listData = [
              { type: 'warning', content: 'This is warning event' },
              { type: 'success', content: 'This is very long usual event。。....' },
              { type: 'error', content: 'This is error event 1.' },
              { type: 'error', content: 'This is error event 2.' },
              { type: 'error', content: 'This is error event 3.' },
              { type: 'error', content: 'This is error event 4.' },
            ]
            break
          default:
        }
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
<template>
  <a-layout-sider
    breakpoint="lg"
    collapsedWidth="0"
    id="interviews-sidebar"
    class="p-3"
  >
    <div class="title text-white">
      <p class="title-helper">Agendando com</p>
      <p class="title-name lead">{{ candidate.name }}</p>
    </div>
    <div class="title text-white">
      <p class="title-helper">Para</p>
      <p class="title-name lead">{{ position.title }}</p>
    </div>
    <a-divider class="divider"></a-divider>
    <a-menu theme="dark" mode="inline" @click="selectMenu">
      <a-menu-item key="1">
        <a-icon type="user" />
        <span class="nav-text">Ver candidato</span>
      </a-menu-item>
    </a-menu>
  </a-layout-sider>
</template>

<script>
  export default {
    props: {
      candidateJson: {},
      positionJson: {},
      candidateUrl: ''
    },
    computed: {
      candidate() {
        return JSON.parse(this.candidateJson || {})
      },
      position() {
        return JSON.parse(this.positionJson || {})
      }
    },
    methods: {
      selectMenu({key}) {
        if (key === '1') {
          window.location.href = this.candidateUrl
        }
      }
    }
  }
</script>

<style scoped>
  .title-helper {
    margin-bottom: 0;
  }

  .title-name {
    word-wrap: break-word;
  }

  .divider {
    margin: 0;
    background-color: #7c7c7c;
  }
</style>
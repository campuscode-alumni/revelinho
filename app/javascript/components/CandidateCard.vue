<template>
  <div class="col-md-4">
    <div class="candidate card my-3 rounded-lg" :id="'candidate-' + candidate.id">
      <div class="row no-gutters">
        <div class="image-container col-sm-4 col-md-4 col-lg-3 col-xl-2 rounded-left py-3">
          <img src="https://github.com/identicons/jasonlong.png" class="image
          card-img" :alt=candidate.name>
        </div>
        <div class="details-container">
          <div class="card-body">
            <div class="row">
              <div class="col">
                <h3 class="card-title">
                  <a :href="'/candidates/' + candidate.id" class="text-reset">
                    {{candidate.name}}
                  </a>
                </h3>
              </div>
              <div class="spacer"></div>
              <div class="col text-right">
                <p>
                {{ candidate.awaiting_invites_badge }}
                {{ location }}
                </p>
              </div>
            </div>
            <p class="card-text">
            <small class="text-muted">{{ candidate.email }}</small>
            </p>
            <p>{{ candidate.occupation }}</p>
            <p>{{ candidate.educational_level }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['candidate'],
  computed: {
    location: function(){
      return this.candidate.city + ', ' + this.candidate.state
    }
  }
}
</script>

<style scoped>
</style>

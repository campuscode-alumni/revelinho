
require("bootstrap/dist/js/bootstrap")
require("bootstrap-datepicker/dist/js/bootstrap-datepicker")
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("turbolinks").start()

$(document).ready(() => {
  $('.datepicker').datepicker()
})

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap'
import '../stylesheets/application'

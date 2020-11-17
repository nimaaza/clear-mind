// import stimulus-flatpickr wrapper controller to extend it
import Flatpickr from 'stimulus-flatpickr'

// import a theme (could be in your main CSS entry too...)
import 'flatpickr/dist/themes/light.css'

// create a new Stimulus controller by extending stimulus-flatpickr wrapper controller
export default class extends Flatpickr {
  initialize() {
    this.config = {
      inline: true
    }

    console.log(this)
    console.log(this["daysTarget"]);
  }

  change(date) {
    console.log(date[0])
  }
}

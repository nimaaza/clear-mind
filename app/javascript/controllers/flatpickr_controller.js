// import stimulus-flatpickr wrapper controller to extend it
import Flatpickr from 'stimulus-flatpickr'

// import a theme (could be in your main CSS entry too...)
import 'flatpickr/dist/themes/light.css'

const getAppointmentsJSON = () => {
  return JSON.parse(document.getElementById('input-white-list-json').value);
}

const addCheckBoxesToForm = (appointments, date) => {
  const radiosDiv = document.querySelector('#new_appointment div'); //getElementById('new_appointment');
  radiosDiv.innerHTML = '';

  appointments.forEach((appointment) => {
    const slot = `${appointment}:00 to ${appointment + 1}:00`;
    const idForRadio = appointment;
    const label = `<label for="${idForRadio}">${slot}</label><br>`;
    const radio = `<input type="radio" id="${idForRadio}" \
                    class="radio-new-appointment-form" \
                    name="slot" value="${date} ${appointment}">`;

    radiosDiv.insertAdjacentHTML('beforeend', radio);
    radiosDiv.insertAdjacentHTML('beforeend', label);
  });

  const submit = '<input id="submit-new-appointments-form" \
                    type="submit" value="Book" disabled>';
  radiosDiv.insertAdjacentHTML('beforeend', submit);

  const submitButton = document.getElementById('submit-new-appointments-form');
  const radios = document.querySelectorAll('.radio-new-appointment-form');
  radios.forEach((radio) => {
    radio.addEventListener('change', () => submitButton.disabled = false);
  })
}

// create a new Stimulus controller by extending stimulus-flatpickr wrapper controller
export default class extends Flatpickr {
  initialize() {
    this.config = {
      inline: true
    }
  }

  change(date) {
    date = date[0];
    const key = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    const freeAppointmentsJSON = getAppointmentsJSON();
    let appointments = freeAppointmentsJSON[key];

    if (!appointments) appointments = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

    if (appointments.length > 0) {
      addCheckBoxesToForm(appointments, key);

      $('#selectTimeSlotCenteredModal').modal({
        show: true
      })
    }
  }
}

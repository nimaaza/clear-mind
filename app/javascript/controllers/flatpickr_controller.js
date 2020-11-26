// import stimulus-flatpickr wrapper controller to extend it
import Flatpickr from 'stimulus-flatpickr'

// import a theme (could be in your main CSS entry too...)
import 'flatpickr/dist/themes/dark.css'

const getAppointmentsJSON = () => {
  return JSON.parse(document.getElementById('input-white-list-json').value);
}

const addCheckBoxesToForm = (appointments, date) => {
  const radiosDiv = document.querySelector('#new_appointment div');
  radiosDiv.innerHTML = '';


  appointments.forEach((appointment) => {
    const slot = `${appointment}:00 - ${appointment + 1}:00`;

    const idForRadio = appointment;
    // const label = `<label for="${idForRadio}">${slot}</label><br>`;
    const radio = ` <div class='d-flex align-items-center flex-column text-blueish'>
                    <input type="radio" id="${idForRadio}" \
                    class="radio-new-appointment-form" \
                    name="slot" value="${date} ${appointment}" \
                    style="margin-right: 4px;"><label for="${idForRadio}">${slot}</label></div>`;

    radiosDiv.insertAdjacentHTML('beforeend', radio);
    // radiosDiv.insertAdjacentHTML('beforeend', label);
  });

  const submit = '<input class="btn btn-action mt-5" id="submit-new-appointments-form" \
                    type="submit" value="Book" disabled>';
  radiosDiv.insertAdjacentHTML('beforeend', submit);

  const newAppointmentForm = document.getElementById('new_appointment');
  const submitButton = document.getElementById('submit-new-appointments-form');
  const radios = document.querySelectorAll('.radio-new-appointment-form');

  radios.forEach((radio) => {
    radio.addEventListener('change', () => submitButton.disabled = false);
  })

  newAppointmentForm.addEventListener('submit', (event) => {
    $('#selectTimeSlotCenteredModal').modal('hide');
  });
}

// create a new Stimulus controller by extending stimulus-flatpickr wrapper controller
export default class extends Flatpickr {
  initialize() {
    this.config = {
      inline: true
    }
  }

  change(date) {
    const dateAsKey = date[0].toLocaleDateString('en-GB');
    const freeAppointmentsJSON = getAppointmentsJSON();
    let appointments = freeAppointmentsJSON[dateAsKey];

    if (!appointments) appointments = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

    if (appointments.length > 0) {
      addCheckBoxesToForm(appointments, dateAsKey);

      $('#selectTimeSlotCenteredModal').modal('show');
    }
  }

  dayCreate(dObj, dStr, fp, dayElem) {
    const now = new Date();
    const today = now.getDate();
    const thisMonth = now.getMonth();

    const currentCalendarDate = dayElem.dateObj;
    const calendarDay = currentCalendarDate.getDate();
    const calendarMonth = currentCalendarDate.getMonth();

    if (calendarMonth != thisMonth || calendarDay < today) return;

    const dateAsKey = dayElem.dateObj.toLocaleDateString('en-GB');
    const freeAppointmentsJSON = getAppointmentsJSON();
    const appointmentsOfDay = freeAppointmentsJSON[dateAsKey];

    let color;

    if (!appointmentsOfDay || appointmentsOfDay.length >= 9) color = '#17a2b8';
    else if (appointmentsOfDay && appointmentsOfDay.length > 3) color = '#fd7e14';
    else color = '#dc3545';

    dayElem.style.backgroundColor = color;
    dayElem.style.color = 'white';
  }
}

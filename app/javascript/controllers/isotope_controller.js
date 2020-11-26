const specializations = ['ADHD', 'Addiction', 'Anxiety', 'Bipolar',
                         'Borderline', 'Depression', 'Family', 'Grief',
                         'Relationship', 'Self-esteem', 'Sex-therapy',
                         'Stress', 'Trauma', 'PTSD'];


const initIsotope = () => {
  const elem = document.querySelector('.isotope-grid');
  const iso = new Isotope(elem, {
    itemSelector: '.isotope-grid-item',
    layoutMode: 'vertical'
  });

  const divSpecializations = document.querySelector('#div-specializations');

  specializations.forEach((specialization) => {
    const button = `<button type="button" class="isotope-filter-buttons btn btn-secondary">${specialization}</button>`;
    divSpecializations.insertAdjacentHTML('beforeend', button);
  });

  const buttons = document.querySelectorAll('.isotope-filter-buttons');

  buttons.forEach((button) => {
    button.addEventListener('click', (event) => {
      iso.arrange({
        filter: function( itemElem ) {
          return itemElem.classList.contains(button.textContent);
        }
      });
    });
  });
};

export { initIsotope };

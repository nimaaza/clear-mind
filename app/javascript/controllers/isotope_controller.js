const specializations = ['ADHD', 'Addiction', 'Anxiety', 'Bipolar',
                         'Borderline', 'Depression', 'Family', 'Grief',
                         'Relationship', 'Self-esteem', 'Sex-therapy',
                         'Stress', 'Trauma', 'PTSD'];


const initIsotope = () => {
  const elem = document.querySelector('.isotope-grid');
  const iso = new Isotope(elem, {
    itemSelector: 'isotope-grid-item',
    layoutMode: 'vertical'
  });

  const divSpecializations = document.querySelector('#div-specializations');

  specializations.forEach((specialization) => {
    const button = `<button>${specialization}</button>`;

    button.addEventListener('click', (event) => {

    });

    divSpecializations.insertAdjacentHTML('beforeend', button);
  });
};

export { initIsotope };

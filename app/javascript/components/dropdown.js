const dropdown = () => {
  const dropdownToggle = document.getElementById('dropdown-toggle');
  dropdownToggle.addEventListener('click', () => {
    let dropdownItems = document.querySelectorAll('.dropdown__item');
    dropdownItems.forEach((item, index) => {
      item.style.transitionDelay = (index * 50) + 'ms';
      item.classList.toggle('dropdown__item--show');
      item.classList.toggle('dropdown__item--hide');
    })
  });
};

export { dropdown };

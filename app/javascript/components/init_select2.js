import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    width: '300px',
    dropdownCssClass: 'test'
  });
};

export { initSelect2 };

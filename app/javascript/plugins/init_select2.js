import $ from 'jquery';
import 'select2';

document.addEventListener("DOMContentLoaded", () => {
  $('.select2').select2({
    placeholder: "Filter by sports",
    allowClear: true,
    tags: true
  });
})


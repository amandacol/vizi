import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';
document.addEventListener("DOMContentLoaded", () => {
  $('.select2').select2({
    tags: true
  });
  $('#user_sport_ids').select2({
    maximumSelectionLength: 5
  });
})


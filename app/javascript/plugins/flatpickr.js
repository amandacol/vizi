import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"
import { totalPrice } from '../packs/total_price';

document.addEventListener("DOMContentLoaded", ()=>{
  flatpickr(".datepicker", {
    altInput: true
  });

  const dates = document.querySelectorAll(".dates")
  const disableDates = []
  dates.forEach((date) => {
    disableDates.push({
      from: date.dataset.datefrom,
      to: date.dataset.dateto
    })
  })

  flatpickr("#range_start", {
    altInput: true,
    plugins: [new rangePlugin({ input: "#range_end"})],
    onClose: totalPrice,
    dateFormat: "m-d-Y",
    minDate: new Date(),
    disable: disableDates
  });
})



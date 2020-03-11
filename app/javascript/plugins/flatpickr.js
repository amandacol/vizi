import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"
import { totalPrice } from '../packs/total_price';


flatpickr(".datepicker", {
  altInput: true
})

flatpickr("#range_start", {
  altInput: true,
  plugins: [new rangePlugin({ input: "#range_end"})],
  onClose: totalPrice
})

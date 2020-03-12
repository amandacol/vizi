import "bootstrap";
import { initAutocomplete } from '../plugins/init_autocomplete';
initAutocomplete();

import { initAutocompleteFind } from '../plugins/init_autocomplete';
initAutocompleteFind();

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
initMapbox();

import { fields } from './form_fields'
fields();

import 'plugins/init_select2'

import "../plugins/flatpickr"



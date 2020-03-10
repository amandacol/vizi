import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById("user_address");
  if (addressInput) {
    places({ container: addressInput });
  }
};

const initAutocompleteFind = () => {
  const addressInput = document.getElementById("location");
  if (addressInput) {
    places({ container: addressInput });
  }
};


export { initAutocomplete };
export { initAutocompleteFind };

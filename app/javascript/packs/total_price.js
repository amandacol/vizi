const totalPrice = () => {
  if (range_start.value != "") {
    const duration = ( new Date(range_start.value.split(' ')[2]) - new Date(range_start.value.split(' ')[0]) ) / 1000 / 60 / 60 / 24;

    const price = Number.parseFloat(document.getElementById('rent_price').innerText);

    const total_price = duration * price;

    if (total_price != NaN) {
      const total = document.getElementById('total');
      total.innerText = `Total: R$${total_price}`;
    }

    const button = document.getElementById( "btn-add-rent");
    button.disabled = false;
    button.classList.remove("disabled");
  }

};

export { totalPrice };




const fields = () => {
  const rental = document.getElementById('conditional_rental');
  const check_rental = document.getElementById('item_transaction_type_rental');
  const check_sale = document.getElementById('item_transaction_type_sale');
  if (check_rental) {
    check_rental.addEventListener('click', (event) => {
      rental.style.display = 'block';
    });
    check_sale.addEventListener('click', (event) => {
      rental.style.display = 'none';
    });
  }
};


export { fields };

const price = () => {
  const priceInput = document.getElementById('item-price');
  const taxPriceDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  if (!priceInput) return;

  const calculatePrice = () => {
    const price = priceInput.value;

    if (price >= 300 && price <= 9999999) {
      const tax = Math.floor(price * 0.1);
      const profit = Math.floor(price - tax);

      taxPriceDom.textContent = tax;
      profitDom.textContent = profit;
    } else {
      taxPriceDom.textContent = '';
      profitDom.textContent = '';
    }
  };

  priceInput.addEventListener('input', calculatePrice);
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
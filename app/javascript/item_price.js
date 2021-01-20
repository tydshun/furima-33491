window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const tax = 0.1
    addTaxDom.innerHTML = Math.floor(inputValue * tax);
    const profitValue = document.getElementById("profit");
    profitValue.innerHTML = inputValue - Math.floor(inputValue * tax);
  })
});
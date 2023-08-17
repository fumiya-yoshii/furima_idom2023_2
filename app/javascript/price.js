window.addEventListener('turbo: load', price_calculation() );
// 価格計算を行う関数
function price_calculation() {
 // 'input' イベントが発生したときの処理を定義
  document.addEventListener('input', function() {
    // 'item-price' フィールドから価格を取得
    const price = document.getElementById('item-price').value;
    const tax_price = Math.floor(price*0.1)
    document.getElementById('add-tax-price').innerHTML = tax_price;
    document.getElementById('profit').innerHTML = price-tax_price;
  });
};
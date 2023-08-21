const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)// PAY.JPテスト公開鍵
  // elementsインスタンスを作成
  const elements = payjp.elements();
  // elementsインスタンスのメソッドです。このメソッドを使用することで、入力フォームを作成できます。
  const numberElement = elements.create('cardNumber');//カード番号入力欄

  const expiryElement = elements.create('cardExpiry');//有効期限入力欄

  const cvcElement = elements.create('cardCvc');//CVC入力欄

//引数で要素のid属性を指定し、指定した要素とelementインスタンスが情報を持つフォームとを置き換えるメソッドです。
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    //createTokenメソッドの第一引数には、カード番号入力フォームとなっているelementインスタンスであるnumberElementが入ります。then以降に、レスポンスを受け取ったあとの処理を記述します。変数responseには、PAY.JP側からのレスポンスとステータスコードが含まれています。
    //response.idとすることでトークンの値を取得することができます。
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token', type="hidden" >`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
    });
  e.preventDefault();
  });
};


window.addEventListener("turbo:load", pay);
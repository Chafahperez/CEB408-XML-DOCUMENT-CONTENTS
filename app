<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>STORE·app — functional e‑commerce demo</title>
  <!-- completely self-contained, full cart logic, persistent localStorage, live inventory, remove/add/sum -->
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
    }

    body {
      background: #e8f0fe;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    /* main app card */
    .app-card {
      max-width: 1350px;
      width: 100%;
      background: #ffffff;
      border-radius: 48px 48px 32px 32px;
      box-shadow: 0 30px 70px -30px #11223380, 0 10px 25px -10px #00000020;
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    /* header */
    .app-header {
      background: #0a1929;
      padding: 1.2rem 2.2rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      color: white;
    }
    .logo-area {
      display: flex;
      align-items: center;
      gap: 16px;
    }
    .logo-area h1 {
      font-weight: 500;
      font-size: 2rem;
      letter-spacing: -0.5px;
    }
    .badge {
      background: #253c5c;
      padding: 5px 16px;
      border-radius: 60px;
      font-size: 0.9rem;
      font-weight: 400;
    }
    .cart-summary-btn {
      background: #1f334d;
      border: 1px solid #4d6b94;
      color: white;
      border-radius: 100px;
      padding: 12px 30px 12px 24px;
      display: flex;
      align-items: center;
      gap: 14px;
      font-size: 1.2rem;
      font-weight: 500;
      cursor: pointer;
      transition: 0.2s;
      box-shadow: 0 8px 16px -10px #00000050;
    }
    .cart-summary-btn:hover {
      background: #25466b;
      border-color: #7b9fd3;
    }
    #cartCountHeader {
      background: #d9824a;
      padding: 5px 16px;
      border-radius: 60px;
      margin-left: 10px;
    }

    /* main dual-panel layout */
    .app-layout {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      background: #f3f8ff;
    }

    /* product shelf */
    .product-shelf {
      flex: 2.2;
      min-width: 340px;
      padding: 2rem 2rem;
    }
    .shelf-header {
      display: flex;
      justify-content: space-between;
      align-items: baseline;
      margin-bottom: 1.8rem;
    }
    .shelf-header h2 {
      font-size: 2rem;
      font-weight: 450;
      color: #102434;
    }
    .shelf-header span {
      background: #dce9ff;
      padding: 6px 18px;
      border-radius: 60px;
      font-size: 0.95rem;
    }
    .grid-items {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 28px;
    }

    /* product card */
    .product-card {
      background: #ffffffdd;
      backdrop-filter: blur(4px);
      border-radius: 32px;
      padding: 28px 16px 22px;
      border: 1px solid #d2e0ff;
      box-shadow: 0 10px 18px -12px #1d354b33;
      transition: 0.2s;
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
    }
    .product-card:hover {
      border-color: #5982bb;
      box-shadow: 0 22px 28px -20px #0c203a;
      transform: translateY(-5px);
      background: white;
    }
    .product-emoji {
      background: #eaf1fd;
      width: 120px;
      height: 120px;
      border-radius: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 4rem;
      margin-bottom: 16px;
    }
    .product-name {
      font-size: 1.8rem;
      font-weight: 500;
      color: #0c1d30;
      line-height: 1.2;
    }
    .product-desc {
      color: #3e5772;
      margin: 10px 0 8px;
      font-size: 0.95rem;
    }
    .product-price {
      font-size: 2rem;
      font-weight: 350;
      color: #21506b;
      margin: 14px 0 18px;
    }
    .product-price small {
      font-size: 1rem;
      color: #617e9e;
    }
    .add-btn {
      background: white;
      border: 2px solid #102434;
      color: #102434;
      font-weight: 600;
      font-size: 1.1rem;
      padding: 14px 0;
      width: 100%;
      border-radius: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      cursor: pointer;
      transition: 0.2s;
    }
    .add-btn:hover {
      background: #102434;
      color: white;
    }

    /* cart panel — right side, fully functional */
    .cart-panel {
      flex: 1.2;
      min-width: 310px;
      background: white;
      border-left: 2px solid #bdd2f0;
      padding: 2rem 1.5rem;
      display: flex;
      flex-direction: column;
      box-shadow: -10px 0 26px -18px #0f263c;
    }
    .cart-panel h2 {
      font-size: 2rem;
      font-weight: 400;
      color: #0a1e2f;
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 20px;
    }
    .cart-panel h2 span {
      background: #cedfff;
      padding: 6px 18px;
      border-radius: 40px;
      font-size: 1rem;
    }
    .cart-list {
      list-style: none;
      flex: 1;
      overflow-y: auto;
      max-height: 440px;
      display: flex;
      flex-direction: column;
      gap: 14px;
      margin-bottom: 10px;
      padding-right: 6px;
    }
    .cart-item {
      background: #f6faff;
      border-radius: 30px;
      padding: 15px 18px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border: 1px solid #c9daf5;
    }
    .item-info {
      display: flex;
      flex-direction: column;
    }
    .item-title {
      font-weight: 700;
      font-size: 1.15rem;
      color: #142b41;
    }
    .item-sub {
      font-size: 0.9rem;
      color: #55708f;
      margin-top: 4px;
    }
    .item-actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .item-qty {
      background: #cbdefa;
      padding: 6px 14px;
      border-radius: 40px;
      font-weight: 600;
      color: #1a2e48;
    }
    .remove-one {
      background: #ffdede;
      border: 1px solid #cf9c9c;
      width: 38px;
      height: 38px;
      border-radius: 40px;
      font-size: 1.6rem;
      font-weight: 400;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: 0.15s;
      color: #702d2d;
    }
    .remove-one:hover {
      background: #ecc7c7;
      border-color: #b45f5f;
    }
    .empty-cart-msg {
      text-align: center;
      color: #839bb5;
      font-style: italic;
      padding: 40px 0;
    }
    .cart-footer {
      border-top: 2px dashed #b5cef0;
      padding-top: 22px;
      margin-top: 6px;
    }
    .total-row {
      display: flex;
      justify-content: space-between;
      font-size: 1.9rem;
      font-weight: 350;
      color: #0a2b40;
      margin-bottom: 22px;
    }
    #checkoutBtn {
      background: #102434;
      color: white;
      width: 100%;
      border: none;
      padding: 18px 0;
      font-size: 1.3rem;
      border-radius: 80px;
      font-weight: 550;
      cursor: pointer;
      transition: 0.2s;
      letter-spacing: 0.3px;
    }
    #checkoutBtn:hover {
      background: #1e3f60;
    }
    .app-footer {
      background: #e5f0ff;
      padding: 18px;
      text-align: center;
      color: #233e5c;
      font-size: 0.95rem;
    }

    /* mini responsiveness */
    @media (max-width: 700px) {
      .app-layout {
        flex-direction: column;
      }
      .cart-panel {
        border-left: none;
        border-top: 3px solid #bfd5f5;
      }
    }
  </style>
</head>
<body>
<div class="app-card">
  <!-- header with cart trigger (scroll into view) -->
  <header class="app-header">
    <div class="logo-area">
      <h1>🛸 shelf·io</h1>
      <span class="badge">functional app</span>
    </div>
    <button class="cart-summary-btn" id="focusCartBtn">
      <span>🛒</span> my cart <span id="cartCountHeader">0</span>
    </button>
  </header>

  <!-- main functional area -->
  <div class="app-layout">
    <!-- left: product grid (full inventory) -->
    <section class="product-shelf">
      <div class="shelf-header">
        <h2>essentials</h2>
        <span>⚡ 6 items</span>
      </div>
      <div class="grid-items" id="productGrid"></div>
    </section>

    <!-- right: always visible cart panel (fully interactive) -->
    <aside class="cart-panel" id="cartPanel">
      <h2>🛒 cart <span id="cartItemCountLabel">0</span></h2>
      <ul class="cart-list" id="cartList">
        <li class="empty-cart-msg">your cart is empty — start adding</li>
      </ul>
      <div class="cart-footer">
        <div class="total-row">
          <span>total</span>
          <span id="cartTotalPrice">$0</span>
        </div>
        <button id="checkoutBtn">→ checkout</button>
      </div>
    </aside>
  </div>

  <footer class="app-footer">
    <p>⚡ fully functional e‑commerce app · persistent cart (localStorage) · add / remove / checkout</p>
  </footer>
</div>

<script>
  (function() {
    // ---------- PRODUCT CATALOG ----------
    const PRODUCTS = [
      { id: 'p1', name: 'bridge', description: 'titanium key multitool', price: 24, emoji: '🔧' },
      { id: 'p2', name: 'orbit', description: 'rechargeable carry light', price: 32, emoji: '💡' },
      { id: 'p3', name: 'arc', description: 'waxed canvas pouch', price: 47, emoji: '🧰' },
      { id: 'p4', name: 'strata', description: 'canvas tool roll', price: 58, emoji: '📁' },
      { id: 'p5', name: 'nomad', description: 'hip sack 3L', price: 64, emoji: '🎒' },
      { id: 'p6', name: 'vault', description: 'rfid cardholder', price: 39, emoji: '💳' }
    ];

    // ---------- CART STATE (load from localStorage) ----------
    let cart = [];

    // load cart from localStorage if exists
    const savedCart = localStorage.getItem('functionalCart');
    if (savedCart) {
      try {
        cart = JSON.parse(savedCart);
      } catch (e) { cart = []; }
    } else {
      cart = [];   // start empty
    }

    // ---------- DOM elements ----------
    const productGrid = document.getElementById('productGrid');
    const cartListEl = document.getElementById('cartList');
    const cartTotalSpan = document.getElementById('cartTotalPrice');
    const cartCountHeader = document.getElementById('cartCountHeader');
    const cartItemCountLabel = document.getElementById('cartItemCountLabel');
    const checkoutBtn = document.getElementById('checkoutBtn');
    const focusCartBtn = document.getElementById('focusCartBtn');
    const cartPanel = document.getElementById('cartPanel');

    // ---------- helper: save to localStorage ----------
    function saveCart() {
      localStorage.setItem('functionalCart', JSON.stringify(cart));
    }

    // ---------- update entire UI (cart + counts) ----------
    function refreshCartUI() {
      // total number of items (sum of quantities)
      const totalItems = cart.reduce((acc, i) => acc + i.qty, 0);
      
      // update header + panel count
      cartCountHeader.innerText = totalItems;
      cartItemCountLabel.innerText = totalItems;

      // compute total price
      const totalPrice = cart.reduce((sum, i) => sum + (i.price * i.qty), 0);
      cartTotalSpan.innerText = `$${totalPrice}`;

      // render cart list
      if (cart.length === 0) {
        cartListEl.innerHTML = `<li class="empty-cart-msg">🛒 your cart is empty — add items</li>`;
      } else {
        let htmlStr = '';
        cart.forEach(item => {
          htmlStr += `
            <li class="cart-item" data-id="${item.id}">
              <div class="item-info">
                <span class="item-title">${item.emoji} ${item.name}</span>
                <span class="item-sub">$${item.price} × ${item.qty}</span>
              </div>
              <div class="item-actions">
                <span class="item-qty">${item.qty}</span>
                <button class="remove-one" data-id="${item.id}" title="remove one">−</button>
              </div>
            </li>
          `;
        });
        cartListEl.innerHTML = htmlStr;
      }
      // persist to localStorage after every cart change
      saveCart();
    }

    // ---------- add to cart ----------
    function addToCart(productId, productName, productPrice, productEmoji) {
      const existing = cart.find(i => i.id === productId);
      if (existing) {
        existing.qty += 1;
      } else {
        cart.push({
          id: productId,
          name: productName,
          price: productPrice,
          qty: 1,
          emoji: productEmoji
        });
      }
      refreshCartUI();
    }

    // ---------- remove one instance (decrease quantity / delete if 0) ----------
    function decreaseFromCart(productId) {
      const idx = cart.findIndex(i => i.id === productId);
      if (idx === -1) return;
      if (cart[idx].qty > 1) {
        cart[idx].qty -= 1;
      } else {
        cart.splice(idx, 1);
      }
      refreshCartUI();
    }

    // ---------- render product grid from PRODUCTS ----------
    function renderProductGrid() {
      if (!productGrid) return;
      productGrid.innerHTML = '';
      PRODUCTS.forEach(p => {
        const card = document.createElement('div');
        card.className = 'product-card';
        card.dataset.id = p.id;
        card.innerHTML = `
          <div class="product-emoji">${p.emoji}</div>
          <div class="product-name">${p.name}</div>
          <div class="product-desc">${p.description}</div>
          <div class="product-price"><small>$</small>${p.price}</div>
          <button class="add-btn" data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-emoji="${p.emoji}">
            <span>+</span> add to cart
          </button>
        `;
        productGrid.appendChild(card);
      });
    }

    // ---------- EVENT DELEGATION ----------

    // 1. product grid "add to cart"
    productGrid.addEventListener('click', (ev) => {
      const addBtn = ev.target.closest('.add-btn');
      if (!addBtn) return;
      const id = addBtn.dataset.id;
      const name = addBtn.dataset.name;
      const price = parseInt(addBtn.dataset.price, 10);
      const emoji = addBtn.dataset.emoji;
      if (id && name && !isNaN(price)) {
        addToCart(id, name, price, emoji);
      }
    });

    // 2. cart panel: remove (decrease) via minus buttons (event delegation)
    cartListEl.addEventListener('click', (ev) => {
      const minusBtn = ev.target.closest('.remove-one');
      if (!minusBtn) return;
      const prodId = minusBtn.dataset.id;
      if (prodId) {
        decreaseFromCart(prodId);
      }
    });

    // 3. checkout button — full functional simulation + clear cart
    checkoutBtn.addEventListener('click', () => {
      if (cart.length === 0) {
        alert('your cart is empty — add some products first.');
        return;
      }
      const total = cart.reduce((acc, i) => acc + i.price * i.qty, 0);
      // show summary
      alert(`✅ checkout simulation complete!\nTotal: $${total}\nThank you. (cart will be cleared)`);
      cart = [];         // empty cart
      refreshCartUI();   // updates local storage as well (save inside refresh)
    });

    // 4. focus cart button (header) — smooth scroll to cart panel
    focusCartBtn.addEventListener('click', () => {
      cartPanel.scrollIntoView({ behavior: 'smooth', block: 'center' });
    });

    // 5. (optional) double-check that any legacy empty cart message is ok.

    // initialise: product grid + cart ui
    renderProductGrid();
    refreshCartUI();   // will render cart and sync counts / local storage

    // (bonus) listen for storage event across tabs? not needed but we can keep sync simple
    window.addEventListener('storage', (e) => {
      if (e.key === 'functionalCart') {
        // update cart if changed in another tab
        try {
          const newCart = JSON.parse(e.newValue || '[]');
          cart = newCart;
          refreshCartUI(); // this will also overwrite with new cart
        } catch (er) {}
      }
    });

  })();
</script>
</body>
</html>
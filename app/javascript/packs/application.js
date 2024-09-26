document.addEventListener('turbo:load', () => {
  const categoryToggle = document.getElementById('category-toggle');
  const categoryDropdown = document.getElementById('category-dropdown');
  const brandToggle = document.getElementById('brand-toggle');
  const brandDropdown = document.getElementById('brand-dropdown');

  // カテゴリのプルダウンを制御
  if (categoryToggle && categoryDropdown) {
    categoryToggle.addEventListener('click', (event) => {
      event.preventDefault();
      categoryDropdown.style.display = categoryDropdown.style.display === 'none' ? 'block' : 'none';
      brandDropdown.style.display = 'none'; // ブランドのプルダウンを閉じる
    });
  }

  // ブランドのプルダウンを制御
  if (brandToggle && brandDropdown) {
    brandToggle.addEventListener('click', (event) => {
      event.preventDefault();
      brandDropdown.style.display = brandDropdown.style.display === 'none' ? 'block' : 'none';
      categoryDropdown.style.display = 'none'; // カテゴリのプルダウンを閉じる
    });
  }

  // ページ外をクリックしたときにプルダウンを閉じる
  document.addEventListener('click', (event) => {
    if (!categoryToggle.contains(event.target) && !categoryDropdown.contains(event.target)) {
      categoryDropdown.style.display = 'none';
    }
    if (!brandToggle.contains(event.target) && !brandDropdown.contains(event.target)) {
      brandDropdown.style.display = 'none';
    }
  });
});
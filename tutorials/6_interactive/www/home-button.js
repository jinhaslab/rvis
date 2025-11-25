// 홈 버튼 동적 추가
(function() {
  // DOM이 로드된 후 실행
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', addHomeButton);
  } else {
    addHomeButton();
  }

  function addHomeButton() {
    // 이미 버튼이 있으면 추가하지 않음
    if (document.querySelector('.home-button')) {
      return;
    }

    // 홈 버튼 생성
    const homeButton = document.createElement('a');
    homeButton.href = '/shiny/';
    homeButton.className = 'home-button';
    homeButton.innerHTML = '🏠 홈으로';
    homeButton.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 9999;
      background: white;
      color: #667eea;
      padding: 12px 25px;
      border-radius: 30px;
      text-decoration: none;
      font-weight: bold;
      box-shadow: 0 4px 15px rgba(0,0,0,0.3);
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 8px;
    `;

    // 호버 효과
    homeButton.addEventListener('mouseenter', function() {
      this.style.transform = 'translateY(-2px)';
      this.style.boxShadow = '0 6px 20px rgba(0,0,0,0.4)';
      this.style.background = '#667eea';
      this.style.color = 'white';
    });

    homeButton.addEventListener('mouseleave', function() {
      this.style.transform = 'translateY(0)';
      this.style.boxShadow = '0 4px 15px rgba(0,0,0,0.3)';
      this.style.background = 'white';
      this.style.color = '#667eea';
    });

    // body에 추가
    document.body.appendChild(homeButton);
    console.log('Home button added');
  }
})();

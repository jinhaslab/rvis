// Kakao Login Integration
(function() {
  // Kakao SDK 초기화
  if (!window.Kakao.isInitialized()) {
    window.Kakao.init('c601c1f797c7c78696455fa99c165b38'); // JavaScript 키
    console.log('Kakao SDK initialized:', window.Kakao.isInitialized());
  }

  // 카카오 로그인 함수
  window.kakaoLogin = function() {
    Kakao.Auth.login({
      success: function(authObj) {
        console.log('카카오 로그인 성공', authObj);

        // 사용자 정보 가져오기
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(response) {
            console.log('사용자 정보:', response);

            const userInfo = {
              id: response.id,
              nickname: response.kakao_account.profile?.nickname || '사용자',
              profile_image: response.kakao_account.profile?.profile_image_url || '',
              email: response.kakao_account.email || ''
            };

            // Shiny에 사용자 정보 전달
            Shiny.setInputValue('kakao_user_info', userInfo, {priority: 'event'});

            // 로그인 성공 메시지
            document.getElementById('kakao-login-status').innerHTML =
              '<div style="background: linear-gradient(135deg, #FEE500 0%, #FFEB3B 100%); color: #3C1E1E; padding: 20px; border-radius: 10px; text-align: center; margin: 20px 0;">' +
              '<h3 style="margin: 0;">🎉 카카오 로그인 성공!</h3>' +
              '<p style="margin: 10px 0 0 0;">환영합니다, <strong>' + userInfo.nickname + '</strong>님!</p>' +
              '</div>';
          },
          fail: function(error) {
            console.error('사용자 정보 가져오기 실패', error);
            alert('사용자 정보를 가져오는데 실패했습니다.');
          }
        });
      },
      fail: function(err) {
        console.error('카카오 로그인 실패', err);
        alert('로그인에 실패했습니다. 다시 시도해주세요.');
      }
    });
  };

  // 카카오 로그아웃
  window.kakaoLogout = function() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function(response) {
          console.log('로그아웃 성공');
          document.getElementById('kakao-login-status').innerHTML = '';
          location.reload();
        },
        fail: function(error) {
          console.error('로그아웃 실패', error);
        }
      });
    }
  };

  console.log('Kakao Login script loaded');
})();

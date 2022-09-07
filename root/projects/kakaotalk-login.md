# 카카오톡 로그인 기능 구현

source: `{{ page.path }}`

**참고)** [카카오로그인 개발자 문서](https://developers.kakao.com/docs/latest/ko/getting-started/sdk-js)


- **준비사항**
VUE JS 프로젝트 (이건 상관 없다. 내가 VUEJS 를 써서 그냥 쓴거임)

<ol>
<li>axios</li>
<li>kakao developer console 계정 (비지니스 계정)</li>
<li>앱 등록</li>
<li>플랫폼 등록</li>
<li>각종 상황에 맞는 설정들...</li>
</ol>

위 준비사항은 문서에 잘 정리되어있고, 각자 상황에 필요한 설정대로 하면 되기떄문에 생략...   
코드 구현 위주로 설명을 진행할 예정이다.


**1. JAVASCRIPT SDK 삽입**   
   /public/index.html

```HTML
<head>
    ...
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    ...
</head>
```

**2. Login 페이지, 라우트 구현**   

/src/router/index.js
```javascript
// ...

const routes = [
   // ...,
   {
      path: "/auth/login",
      name: "auth.login",
      meta: {requiresAuth: false, layout: "Layout"},
      component: () =>
              import(/* webpackChunkName: "auth.login" */ "../pages/Login"),
   },
   {
      path: "/auth/handle/:provider",
      name: "auth.handle.social",
      props: true,
      meta: {requiresAuth: false, layout: "Layout"},
      component: () =>
              import(/* webpackChunkName: "auth.handle.social" */ "../pages/SocialCallBack"),
   },
   // ...
];

const router = createRouter({
  routes,
});

export default router;
```   

/src/helper/sns.js
```javascript
// ...

class sns {
    // ...,
   kakaoInit() {
      window.Kakao.init(process.env.VUE_APP_KAKAO_KEY);
   }
   // ...

}

export default new sns();
```



/src/pages/Login.vue
```vue
    <template>
        <div>
        ...
            <button v-on:click="actions.onBtnKakaotalkLogin()">
                카카오톡 로그인
            </button>
        ...
        </div>
    </template>
    
    <script>

    import { ref, onBeforeMount } from "vue";
    import sns from "@/helper/sns";


    export default {
       name: "Login",
       setup() {
          const kakao = ref(null);
          const redirectUri = `${SERVICE_DOMAIN}/auth/handle/kakao`;

          onBeforeMount(async () => {
             if (!window.Kakao.isInitialized()) {
                sns.kakaoInit();
             }
             kakao.value = window.Kakao;
          });



          const kakaotalkLogin = () => {
             const params = {
                redirectUri: `${redirectUri}`,
                scope: "account_email,gender",
             };

             kakao.value.Auth.authorize(params);
          };

          const actions = {
             ...,
             onBtnKakaotalkLogin: () => {
                kakaotalkLogin();
             },
             ...
          }

          return {actions}
       }
    }
    </script>
```   
kakao.value.Auth.authorize(params)   
ㄴ 이 부분이 실행 될때 카카오톡 인증창이 열린다.   
![카카오톡 로그인창](/assets/images/projects/kakao-login/kakao_login_window.png)


kakao.value.Auth.authorize(params) 가 실행될 때,   
params 에 담긴 redirect_uri 와 kakao developer console 에 설정된 uri 랑 다를경우 에러페이지가 뜬다.   

로그인이 성공하면 redirect_uri 로 이동한다.   
위의 /src/router/index.js 파일에 **"auth.handle.social"** 를 redirect_uri 로 설정했다.   

<br/>

**3. sns 모듈 만들기 (kakao)**
SocialCallBack.vue 파일을 보기 전에   
/src/helper/sns.js 에 모듈을 추가하자.   
```javascript
// ...

class sns {
    // ...,
   kakaoInit() {
      window.Kakao.init(process.env.VUE_APP_KAKAO_KEY);
   }
   
   async kakaoAccessToken(code) {
      const kakaoHeader = {
         Authorization: "{{kakao_app_key}}",
         "Content-type": "application/x-www-form-urlencoded;charset=utf-8",
      };
      try {
         const data = {
            grant_type: "authorization_code",
            client_id: "{{kakao_app_key}}",
            redirect_uri: `${"service_domain"}/auth/handle/kakao`,
            code: code,
         };

         const queryString = Object.keys(data)
                 .map((k) => encodeURIComponent(k) + "=" + encodeURIComponent(data[k]))
                 .join("&");
         
         const result = await axios.post(
                 "https://kauth.kakao.com/oauth/token",
                 queryString,
                 { headers: kakaoHeader }
         );
         await window.Kakao.Auth.setAccessToken(result.data.access_token);
      } catch (e) {
         return e;
      }
   }

   async loginToKakao() {
      let userInfo = "";
      await window.Kakao.API.request({
         url: "/v2/user/me",
         success: function (response) {
            userInfo = response;
         },
         fail: function (error) {
            console.log(error);
         },
      });

      const payLoad = {...userInfo}; // 서비스에 맞는 파라미터들로 key, value 를 구성하면 된다.
      
      // 서비스 API
      const res = await ApiService.postAuthSocialApp(payLoad);
      
      // res 에러처리 필요!!
      
      await AuthService.login(); // 각 서비스에 맞는 로그인 로직을 구현한다.
   }

}

export default new sns();
```   
위 코드를 잘 기억하자. SocialCallBack.vue 코드를 보여준다음에 설명하겠다.   

<br />

**4. SocialCallBack.vue 리다이렉트 페이지 만들기**
**/src/pages/SocialCallBack.vue**
```vue
<template>
  <div>
    <div>provider : {{ provider }}</div>
    <div>code : {{ state.code }}</div>
    <div>redirectUri : {{ state.redirectUri }}</div>
    <div>authData : {{ state.authData }}</div>
  </div>
</template>
<script>
import { onMounted, reactive } from "vue";
import { useRoute } from "vue-router";
import sns from "@/helper/sns";

export default {
  name: "SocialCallBack",
  props: {
    provider: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const route = useRoute();
    
    const state = reactive({
      code: null,
      redirectUri: route.path,
      authData: null,
    });
    
    onMounted(async () => {
      const authCode = route.query.code;
      state.code = authCode;

      if (props.provider === "kakao") {
        await sns.kakaoInit();
        await sns.kakaoAccessToken(route.query.code);
        await sns.loginToKakao();
      }
       
    });

    return { state };
  },
};
</script>
```   

카카오 로그인창에서 로그인 성공하면 SocialCallBack.vue 파일로 리다이렉트 되는데,   
브라우져의 uri를 보면 query params 에 **code=~~~** 가 있다. 이게 중요하다.

여러 sns 로그인이 구현되어있을수 있다.
만약 provider 가 kakao 일 경우의 로직을 보면
1. await sns.kakaoInit();
2. await sns.kakaoAccessToken(route.query.code);
3. await sns.loginToKakao();   

이순서대로다.   
위에 sns.js 파일을 보면 kakaoAccessToken 와 loginToKakao 함수가 있다.   
1번 과정은 인스턴스 초기화



kakaoAccessToken 함수를 보면 아래와 같다.
```javascript
    class sns {
      async kakaoAccessToken(code) {
         const kakaoHeader = {
            Authorization: "{{kakao_app_key}}",
            "Content-type": "application/x-www-form-urlencoded;charset=utf-8",
         };
         try {
            const data = {
               grant_type: "authorization_code",
               client_id: "{{kakao_app_key}}",
               redirect_uri: `${"service_domain"}/auth/handle/kakao`,
               code: code,
            };
   
            const queryString = Object.keys(data)
                    .map((k) => encodeURIComponent(k) + "=" + encodeURIComponent(data[k]))
                    .join("&");
   
            const result = await axios.post(
                    "https://kauth.kakao.com/oauth/token",
                    queryString,
                    {headers: kakaoHeader}
            );
            await window.Kakao.Auth.setAccessToken(result.data.access_token);
         } catch (e) {
            return e;
         }
      }
   }
```   


```
const result = await axios.post(
   "https://kauth.kakao.com/oauth/token",
   queryString,
   {headers: kakaoHeader}
);
```   
이 부분이 중요한데,
**"https://kauth.kakao.com/oauth/token"** 이 엔드포인트로 API request 를 하면   
response 로 result.data.access_token 값이 있다.   

<br/>
**(중요)**    

이 값으로 아래와같이 **Kakao.Auth.setAccessToken** api 를 찔러 줘야한다.
```javascript
window.Kakao.Auth.setAccessToken(result.data.access_token);
```   
<br />

3번 과정을 보면 아래와 같다.
```javascript
class sns {
   async loginToKakao() {
      let userInfo = "";
      await window.Kakao.API.request({
         url: "/v2/user/me",
         success: function (response) {
            userInfo = response;
         },
         fail: function (error) {
            console.log(error);
         },
      });

      const payLoad = {...userInfo}; // 서비스에 맞는 파라미터들로 key, value 를 구성하면 된다.

      // 서비스 API
      const res = await ApiService.postAuthSocialApp(payLoad);

      // res 에러처리 필요!!

      await AuthService.login(); // 각 서비스에 맞는 로그인 로직을 구현한다.
   }
}
```   
위 코드에서는 
```javascript
 await window.Kakao.API.request({
         url: "/v2/user/me",
         success: function (response) {
            userInfo = response;
         },
         fail: function (error) {
            console.log(error);
         },
      });
```
ㄴ 위에서 미리 찔렀던 **Kakao.Auth.setAccessToken** 를 먼저 질러서 Success 를 해야   
위 과정을 통과할 수 있다.   


위 과정에서 얻은 userInfo 에 본인의 서비스에 필요한 DB scheme 들이 있을 것이다.   
필요한 값들로 payload 를 구성하고, 구현한 서비스 API(Backend 개발자의 영역)를 찌르면 된다.

서비스 내부의 API 로직은    
해당 유저의 정보가 DB 에 있으면 인증 토큰 발급,   
없을 경우 회원가입 시키고 인증토큰 발급,   
유저의 정보가 있지만 인증토큰이 만료되었을 경우 refresh_token 을 새로 발급하여 다시 서비스 인증토큰 발급   
등의 로직이 구현되어있다.

받아온 response 로 에러처리는 필요하다.

**해당 response 로 front 에서 로그인 처리하는 것도 구현해야한다.**

여기까지 구현했다면 front 개발자가 kakao 로그인 구현을 하는 과정은 끝이다. 이후는 고도화와 비지니스 로직만 잘 구현해보자...





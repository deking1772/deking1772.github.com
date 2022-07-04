# 모바일 레이아웃 만들기

source: `{{ page.path }}`

일반적으로 반응형 웹을 만들때는 모바일 먼저 작업해야 한다.   
이유는 break point를 작게 잡고, 점차 큰화면에 대한 퍼블리싱을 할 때,    

작은 화면 작업 후 큰 화면을 작업 할때, 모바일이 깨질 확률이 적다.   
PC 화면을 먼저 작업하고, 모바일 퍼블리싱을 한다면   
완성된 pc 화면이 깨질 확률이 높아 재작업해야하는 경우가 종종 생긴다.   

물론~! 실력이 있고, 익숙하다면 뭘 먼저 작업해도 상관 없겠지만   
회사에서 만났던 퍼블리셔 분들을 보면 거의 다 모바일부터 작업을 시작했다.   
그러니 공부 하는 입장에서 따라하도록 하자.   
   
   
<hr />
1. 디렉토리 구조   
<img src="/assets/images/vuejs/vite-vue3-filesystem.png" alt="vite vue3 파일시스템" width="300" /><br/>
   
위 구조에서 /src 아래 layout 디렉토리를 만들고,   
/src/layout/DefaultLayout.vue 를 만든다.   
   

/src/layout/DefaultLayout.vue   
```vue
<template>
    <HeaderComponent />
    <slot></slot>

    <FooterComponent/>
</template>

<script lang="ts">
import HeaderComponent from "./partials/HeaderComponent.vue"
import FooterComponent from "./partials/FooterComponent.vue"

</script>
```
   
위 코드에 등장하는 HeaderComponent.vue 와 FooterComponent.vue 파일을 만들어준다.   
   

/src/layout/partials/HeaderComponent.vue   
```vue
<template>
    <div class="header">
        <Logo />
    </div>
</template>

<script setup lang="ts">

</script>

```




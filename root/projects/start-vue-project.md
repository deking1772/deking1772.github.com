# VUE JS 프로젝트 시작하기

source: `{{ page.path }}`

VUE 3.x 버전을 사용할 것이다.

vue 3.x 는 사용하는 방법이 크게 두가지 이다.    
<b>options API 방식</b>과, <b>composition API 방식 </b>중     
composition API 방식을 사용해서 개발 할ㄴ 것이다.   
   
TypeScript도 공부하면서 도입할 예정이다. (처음 써봄)


## 사전 준비사항

1. Vue 는 node.js 기반으로 되어있기 때문에 node가 설치되어야 한다.   
2. Vue cli 설치   
``` 
    > npm install -g @vue/cli 
```   

    ㄴ 정상적으로 설치가 되었다면 아래 명령어로 확인하자.  

    ``` 
      > vue -v 
    ``` 

    ㄴ 프로젝트생성   
    ``` 
      > vue create {프로젝트명} 
    ```   
   
   <br />
    
## 프로젝트 생성 (VUE CLI)
    
``` 
    > cd workspace   
    > vue create hiver-copy
```   
위 명령어를 치면 아래와같이 나온다.

<img src="/assets/images/start-vue-project/first.png" alt="vue create 프로젝트명" width="500" /><br/>
    
여기서 <b>Manually select features</b> 선택!!! 
직접 초기 세팅을 설정하는 것이다.    

<img src="/assets/images/start-vue-project/two.png" alt="vue 초기설정" width="500" /><br/>
space 를 누르면 선택이되서 필요한 사항들을 선택하고
엔터를 누르면 된다.   
맨 밑에 unit testing 과 E2E testing 을 제외하고 모두 선택했다.

그 다음은 순차적으로 원하는 옵션을 선택하면된다.
ㄴ vue 3.x   
ㄴ Use class-style component syntax => No   
ㄴ Use Babel alongside TypeScript => Y   
ㄴ Use history mode for router => Y (히스토리모드 사용, 대충 프로덕션에서 사용하려면 적절한 서버 세팅이 필요하다 는 내용이 같이 나옴.)   
ㄴ Pick a CSS pre-processor => Sass/SCSS (with node-sass)   
ㄴ Pick a linter / formatter config => ESLint + Standard config   
ㄴ Pick additional lint features => Lint on save (스페이스로 둘다 선택할 수 있음)
ㄴ Where do you prefer placing config for Babel, ESLint, etc.? => In dedicated config files   
ㄴ Save this as a preset for future projects? => N (나중에도 이설정을 그대로 사용할거냐는 얘기)


설치가 끝날때 까지 기다리고 나면   
아래 명령어를 실행해서   
브라우져에서 확인 할 수 있다. 

``` 
    > cd hiver-copy     
    > yarn serve    
```   

<img src="/assets/images/start-vue-project/twice.png" alt="프로젝트 실행" width="500" /><br/>

아래와 같이 뜨면 성공!    
<img src="/assets/images/start-vue-project/third.png" alt="브라우져에서 실행" /><br/>


## VITE 세팅...   


위에 vue cli로 프로젝트를 생성한 것은 연습했다치고 잊어버리자!   

 vite 를 세팅하는 이유는... <a href="https://vuejs.org/guide/typescript/overview.html">Using Vue with TypeScript </a> 를 보면 아래와 같은 글이 나온다.


``` 
  If you are currently using Vue 3 + TypeScript via Vue CLI,    
  we strongly recommend migrating over to Vite.   
  We are also working on CLI options to enable transpile-only TS support,   
  so that you can switch to vue-tsc for type checking.
```   
즉, vue3 에서 typescript 를 사용하려면 Vite 를 권장한다는 내용이다.
vue cli 에서도 사용할 수 있기는 하다.   
권장하는 이유는 아래와 같다.

vue cli 는 webpack 기반이다.   
webpack 기반의 라이브러리에서 타입체크는 대표적으로 <b>"ts-loader"</b> 와 같은 방식을 사용한다.   
하지만 이러한 방식은 타입체크를 위해 타입 시스템이 전체 모듈을 알려야하기 때문에   
깔끔한 방법은 아니다. 모듈의 변환을 각각하나씩 하는것은 옳은 방법이 아니다.   
vue clic 에서 ts-loader를 사용한 방식은 아래와 같은 문제를 초래한다.

1. 전처리 변환(ts 파일 -> javascript 파일)을 한다. 이것은 IDE에서 에러를 내지 않는다. 그리고 vue-tsc로 변환한 이전의 코드와 변환된 코드가 맞지 않는다.   

2. 타입체크 속도가 느려질 수 있다.   
   
3. 타입체크는 개발효율을 위해 하는것인데, 개발 효율이 떨어질 수 있다.   
   
<b style="color: red;">결론! 이미 개발된 vue3 + typescript 가 있다면 vite 로 마이그레이션 하는것을 추천!   
  => vue3 에서 typescript 쓸거면 vite 를 사용하는게 좋다~ 이말...   
    그래서 시작을 vite로 함   
    하... vite... 난 단지 프로젝트를 직접 구현해보는게 목적이었는데 점점 깊히들어가는것 같다.   
    그래도 다 피가되고 살이되는 공부들이니 해보자! </b>
       


<a href="https://vitejs.dev/guide/why.html#slow-server-start">vite 공식문서</a>


- ### vite 설치
```
  > cd workspace
  > yarn create vite
```
<img src="/assets/images/start-vue-project/four.png" alt="브라우져에서 실행" /><br/>

ㄴ vite project 이름을 입력한다.   
  => vite-vue3

<img src="/assets/images/start-vue-project/five.png" alt="브라우져에서 실행" /><br/>

vue 선택  
<img src="/assets/images/start-vue-project/six.png" alt="브라우져에서 실행" /><br/> 

vue-ts 선택 (타입스크립트를 적용하기 위해)   
 그럼 설치가 완료된다.

그럼 아래 명령어를 실행해서 프로젝트를 띄워보자   
 ``` 
  > cd vite-vue3
  > yarn
  > yarn dev
 ```

브라우져에 localhost:3000 으로 뜨는걸 확인할 수 있다. 아래와 같이 뜨면 성공!      
<img src="/assets/images/start-vue-project/seven.png" alt="브라우져에서 실행" /><br/> 

이제 vite + vue3 + typescript 로 프론트 개발할 준비가 끝났다.   
앞으로는 vite, vue3, typescript를 공부하면서 프로젝트를 기획하고 만들어 갈것이다. 공식문서틑 틈틈히 정독하도록 하자!!

### typescript 세팅

<a href="/root/VITE/vite-typescript.html">vite typescript 세팅</a>   
 위 링크를 참고해서 세팅하면 된다. tsconfig.json
 ```
 {
  "compilerOptions": {
    "types": ["vite/client"], // 이부분
    "target": "esnext",
    "useDefineForClassFields": true, // 이부분 (이미 세팅되어있음)
    "module": "esnext",
    "moduleResolution": "node",
    "strict": true,
    "jsx": "preserve",
    "sourceMap": true,
    "resolveJsonModule": true,
    "esModuleInterop": true,
    "lib": ["esnext", "dom"],
    "isolatedModules": true, // 이부분
  },
  "include": ["src/**/*.ts", "src/**/*.d.ts", "src/**/*.tsx", "src/**/*.vue"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
 ```
    
<br/>
<br/>
<br/>
<a href="https://wallbono.tistory.com/21">참고한 링크</a>   

## vue-router 세팅
```shell
  > yarn add vue-router@4
```

  /src/router.ts
```typescript
  import { createWebHistory, createRouter } from "vue-router";

  const routes = [
    {
      path: "/",
      name: "Home",
      component: () => import("./pages/Home.vue"),
    },
    {
    path: "/test",
    name: "Test",
    component: () => import("./pages/Test.vue"),
  },
  ];

  const router = createRouter({
  history: createWebHistory(),
  routes,
  });

  export default router;
```   

/src/main.ts
```typescript
import { createApp } from "vue";
import App from "./App.vue";

import router from "./router"; // 추가

createApp(App).use(router).mount("#app"); // .use(router) 추가
```

/src/App.vue
```vue
<template>
  <div>
    <router-view />
  </div>
</template>

<script setup lang="ts">

// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
</script>




```
   
/src/pages 디렉토리 생성   
/src/pages/Home.vue 파일 생성   
```vue
<template>
  <div>
      <h1>홈 입니다.</h1>
  </div>
</template>


<script lang="ts">
import { reactive } from '@vue/reactivity'

export default{
    name:"Home",
    setup(){
        const state = reactive({
            data: "ddd"
        })


        return {state}
    }
}

</script>
```

   
## vuex 세팅

```shell
  > yarn add vuex@next
```

/src/store 디렉토리 생성   
/src/store/index.ts 파일 생성   
```typescrit
import Vuex, { StoreOptions } from "vuex";
import moduleA from "./modules/ModuleA";
import moduleB from "./modules/ModuleB";

export interface RootState {
  data: string;
}
const store: StoreOptions<RootState> = {
  state: { data: "root" },
  modules: { moduleA, moduleB },
  mutations: {
    setData(state, data: string) {
      // -> commit('setData')
      state.data = data;
    },
  },
  actions: {
    setRootData({ commit }, data: string) {
      // -> dispatch('setRootData')
      console.log("RootState set Root Data");
      commit("setData", data);
    },
  },
  getters: {
    data: (state) => state.data, // -> getters['data']
  },
};

export default new Vuex.Store(store);
```   
   
/src/store/modules 디렉토리 생성   
/src/store/modules/ModuleA.ts 파일 생성   
```typescript
import { Module } from "vuex";
import { RootState } from "../index";
import ModuleA from "../../types/ModuleAType";

const module: Module<ModuleA, RootState> = {
  namespaced: true, // (rootState와 구분해 주기 위한 옵션)
  state: { data: "ModuleA Data" },
  mutations: {
    setData(state, data: string) {
      // -> commit('moduleA/setData')
      state.data = data;
    },
  },
  actions: {
    setRootData({ commit }, data: string) {
      // -> dispatch('moduleA/setRootData')
      console.log("module A set Root Data");
      commit("setData", data);
    },
  },
  getters: { data: (state) => state.data }, // -> getters['moduleA/data']
};

export default module;
```   
   
/src/store/modules/ModuleB.ts 파일 생성
```typescript
import { Module } from "vuex";
import { RootState } from "../index";
import ModuleB from "../../types/ModuleBType";

const module: Module<ModuleB, RootState> = {
  namespaced: true,
  state: { data: "ModuleB Data" },
  mutations: {
    setData(state, data: string) {
      // -> commit('moduleB/setData')
      state.data = data;
    },
  },
  actions: {
    setRootData({ commit }, data: string) {
      // -> dispatch('moduleB/setRootData')
      console.log("module B set Root Data");
      commit("setData", data);
    },
  },
  getters: { data: (state) => state.data }, // -> getters['moduleB/data']
};
export default module;
```
   
      
/src/types/ModuleAType.ts 파일 생성   
```typescript
export default interface ModuleA {
  data: string;
}
```   
   
/src/types/ModuleBType.ts 파일 생성   
```typescript
export default interface ModuleB {
  data: string;
}
```   
   
/src/main.ts 수정   
```typescript
import { createApp } from "vue";
import App from "./App.vue";

import router from "./router";
import store from "./store"; // 추가

createApp(App).use(store).use(router).mount("#app"); // .use(store) 추가

```   
   
/src/pages/Home.vue 수정   
```vue
<template>
  <div>
    <h1>안뇽 !</h1>
    <h2>라우터 테스트</h2>
    <router-link :to="routerTest">vuex 테스트하러 가기</router-link>
  </div>
</template>
<script  lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: "Home",
  data() {
    return {
      routerTest: "/test",
    };
  },
});
</script>

<style>
</style>
```   
    
/src/pages/Test.vue 생성   
```vue
<template>
  <div>
    <h2>{{ rootStateData }}</h2>
    <button @click="setRoot">Set Root Data</button>
    <h2>{{ moduleAData }}</h2>
    <button @click="setModuleA">Set ModuleA Data</button>
    <h2>{{ moduleBData }}</h2>
    <button @click="setModuleB">Set ModuleB Data</button>
  </div>
</template>
<script  lang="ts">
import { defineComponent, computed } from "vue";
import { useStore } from "vuex";

export default defineComponent({
  name: "Test",
  setup() {
    const { state, dispatch } = useStore();
    const rootStateData = computed(() => state.data);
    const moduleAData = computed(() => state.moduleA.data);
    const moduleBData = computed(() => state.moduleB.data);

    const setRoot = () => dispatch("setRootData", "testRoot"); //RootState
    const setModuleA = () => dispatch("moduleA/setRootData", "testModuleA"); //ModuleState
    const setModuleB = () => dispatch("moduleB/setRootData", "testModuleB"); //ModuleState

    return {
      rootStateData,
      moduleAData,
      moduleBData,
      setRoot,
      setModuleA,
      setModuleB,
    };
  },
});
</script>

<style>
</style>
```   
   
아래 이미지 처럼 나오면 성공   
<img src="/assets/images/start-vue-project/home-vue.png" alt="vue create 프로젝트명" width="500" /><br/>
   
<b>vuex 테스트 하러가기</b> 링크를 클릭하면 하래 화면이 나온다.   
<img src="/assets/images/start-vue-project/test-vue.png" alt="vue create 프로젝트명" width="500" /><br/>   

프론트엔드의 모든 세팅은 끝났다.   
이제부터는 프로젝트를 개발 하면서 부족한 vite 지식과 typescript 지식을 공부하면서   
프로젝트를 이끌어 나가면 된다.   



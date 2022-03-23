# 텔레포트를 사용하여 모달 구현하기

source: `{{ page.path }}`


## 텔레포트란?

VUE는 SPA다.   
하나의 엘리먼트 (<div id="app"></div>) 안에 크고작은 컴포넌트들이 페이지를 이룬다.   
여기서 컴포넌트화가 잘 되다보면 하위컴포넌트는 점점 depth가 깊어진다.   

그런데 하위 컴포넌트에서 어떤 이벤트가 발생하여 모달을 띄워야할때,    
z-index를 높여서 최상위 돔까지 끌어 올리기는 쉽지않다.   
이때 텔레포트가 유용하게 쓰인다.   
   
물론! 텔레포트를 사용하지 않고, vanilla JS 나 다른 방식을 사용하여 Modal 기능을   
구현할 수도 있다.    
하지만 실무에서 적용하고 사용한 경험으로 비추어 봤을때,   
텔레포트 기능은 정말 간단하고 깔끔한 방식이라는 생각이 든다.

## 예제 코드 (TeleportTest.vue)

```vue
<template>
  <div class="container-lg">
        
    ...
    <button v-on:click="actions.openModal()">
        모달 open
    </button>
    ...
      
    <teleport to="#teleportZone">
      <Modal 
        v-if="state.showModal()"
        v-on:closeModal="actions.closeModal()" 
        />
    </teleport>
  </div>
</template>

<script>
import Modal from "./Modal";
import { reactive } from "vue";

export default {
  name: "TeleportTest",
  components: {
    Modal
  },
  setup() {
    const state = reactive({
      showModal: false,
    });
  

    const actions = {
      openModal: () => {
        state.showModal = true;
      },
      closeModal: () => {
          state.showModal = false;
      }
    };
    return {
      state,
      actions,
    };
  },
};
</script>
```
   
위 코드를 살펴보자. 위 코드가 끝이 아니다.
/public/index.html 파일을 아래와 같이 세팅해 주어야 한다.

```html
<body>
    ...

    <div id="app"></div>
    <div id="teleport"></div>
    ...
</body>
```
teleport 태그에 to="#teleportZone" 이 있다.        
SPA 는 <div id="app"></div> 안에 모든 컴포넌트들이 들어있다.    
그런데 teleport 태그에서 to="#teleportZone" 은 teleport 태그 안에 있는 컴포넌트를   
<div id="app"></div> 와 동등한 위치인 <div id="teleportZone"></div>에 바인딩 시켜서   
모달처럼 동작하게 된다.   
<br/>
<br/>

<b>disabled 옵션</b>   
   
disabled 옵션도 있다. 모든컴포넌트가 <div id="app"></div> 과 동일한 위치인 <div id="teleportZone"></div>에 바인딩 될 필요는 없다.   
전역적으로 사용하는 모달을 제외하고, 지역적으로 사용하는 모달의 경우 :disabled="true"를 써주면 된다.
그럼 <div id="teleportZone"></div>에 모달이 바인딩 되지않고, 해당 위치에 위치하게 된다.

## 예제 코드(disabled option)

```vue
<template>
  <div class="container-lg">
        
    ...
    <button v-on:click="actions.openModal()">
        모달 open
    </button>
    ...
      
    <teleport :disabled="true">
      <Modal 
        v-if="state.showModal()"
        v-on:closeModal="actions.closeModal()" 
        />
    </teleport>
  </div>
</template>

<script>
import Modal from "./Modal";
import { reactive } from "vue";

export default {
  name: "TeleportTest",
  components: {
    Modal
  },
  setup() {
    const state = reactive({
      showModal: false,
    });
  

    const actions = {
      openModal: () => {
        state.showModal = true;
      },
      closeModal: () => {
          state.showModal = false;
      }
    };
    return {
      state,
      actions,
    };
  },
};
</script>
```

전역적으로 사용하는 모달이 아니라면 disabled 욤션을 사용하여 위처럼 쓰면 된다.





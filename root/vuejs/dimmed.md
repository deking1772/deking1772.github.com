# dimmed 컴포넌트 만들기

source: `{{page.path}}`

dimmed 는 모달이나, 팝업창 등을 띄울때   
전체화면을 약간 어두운 배경으로 덮는 프론트엔드 UI 중 하나이다.   

vue 에서 dimmed 컴포넌트를 만들어 보자.
(클래스는 bootstrap 5.x 버전을 사용한 예이다.)

## Dimmed.vue

```vue
<template>
    <div class="dimmed d-flex justify-content-center align-items-center"></div>
</template>

<script>
export default {
  name: "Dimmed",
};
</script>
<style>
.dimmed {
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  z-index: 100;
  opacity: 0.5;
  background-color: rgb(0, 0, 0);
}
</style>
```
위와같이 dimmed 컴포넌트를 만들 수 있다.     
dimmed 컴포넌트는 만들었지만 좀더 응용력있고, 확장성 있게 만들고 싶다.   

## 여러가지로 응용 가능한 dimmed component

전체 화면은 dimmed 하고 로딩 메세지 띄우기
```vue
<template>
  <div class="dimmed d-flex justify-content-center align-items-center">
    <h1 v-if="message" class="text-white">
      {{ message }}
    </h1>
    <loading
      class="mt-15"
      v-bind:active="true"
      v-bind:is-full-page="false"
      v-bind:color="color"
      v-bind:loader="loader"
      v-bind:background-color="backgroundColor"
      v-bind:transition="transition"
    />
  </div>
</template>

<script>
import Loading from "vue-loading-overlay";
export default {
  name: "Dimmed",
  props: {
    message: {
      type: String,
      required: false,
    },
    loader: {
      type: String,
      default: "dots",
      validator: (value) => {
        return ["dots", "bars", "spinner"].includes(value);
      },
    },
    transition: {
      type: String,
      default: "fade",
    },
    color: {
      type: String,
      default: "#A3A3A3",
    },
    backgroundColor: {
      type: String,
      default: "#11ffee00",
    },
  },
  components: {
    Loading,
  },
};
</script>
<style>
.dimmed {
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  z-index: 100;
  opacity: 0.5;
  background-color: rgb(0, 0, 0);
}
</style>
```
<br>
slot 을 이용하여 모달로 사용할 수도 있다.

```vue
<template>
  <div class="dimmed d-flex justify-content-center align-items-center">
    <slot name="modal"></slot>
  </div>
</template>

<script>
export default {
  name: "Dimmed",
};
</script>
<style>
.dimmed {
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  z-index: 100;
  opacity: 0.5;
  background-color: rgb(0, 0, 0);
}
</style>
```
위 dimmed 컴포넌트를 사용하여 모달을 만들면 아래와 같다.   

```vue
<template>
    <dimmed>
        <template #modal>
            <div>
                ...
                모달 UI
                ...
            </div>
        </template>
    </dimmed>
</template>

<script>
export default {
    name: "DimmedModal",
}
</script>
```
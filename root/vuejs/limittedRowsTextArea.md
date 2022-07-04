# 입력에 줄 수 제한이 있는 textarea

source: `{{page.path}}`


회사에서 개발을 하다가 예상치 못하게 시간을 많이 허비한 부분이다.
textarea 에 두 줄 까지만 입력이 가능하게 하는 것이다.
쉽게 생각했지만 생각보다 쉽지 않았다.

아래 해결했던 과정을 정리해보겠다.

과제는 다음과 같았다.


    1. default text 가 p 태그로 감싸져있다.
    2. p 태그를 클릭했을 때, default 텍스트가 textarea 에 채워진채로 p태그가 textarea 로 toggle 되어야한다.
    3. textarea 에 입력은 두 줄만 되어야 한다.

위 과제를 수행하는 컴포넌트를 InlineTextarea.vue 라고 하겠다.
## 1. p 태그 안에 데이터 바인딩 하기


```vue
<!-- InlineTextarea.vue -->
<template>
  <div>
    <p v-html="defaultValue"></p>
  </div>
</template>


<script>
import { reactive, ref } from "vue";
export default {
  name: "InlineTextarea",
  props: {
    defaultValue: {
      type: String,
      default: "",
    },
    textStyles: {
      type: Object,
      default: () => {
        return {
          fontSize: "24px",
          color: "#E5E5EB",
          lineHeight: "34px",
          fontWeight: 700,
        };
      },
    },
    maxRows: {
      type: Number,
      default: 2,
    },
  },
  setup(props, { emit }) {},
};
</script>
```

   우선 p 태그에 채울 defaultValue props 를 받아서 바인딩 했다.
   추가로 props 로 textStyles 와 maxRows를 받아온다.

   textStyle 을 받아오는 이유는 p태그가 토글되어 textarea 에 text가 value 로 들어갈 때 스타일이 변하지 않게 하기 위함이다.
   maxRows를 props 로 받은 이유는 컴포넌트의 확장성을 위해서 이다. maxRows 가 3, 4 일때도 가능하도록 만들 계획이다.

## 2. 토글을 위한 state 데이터 만들기

```vue
<!-- InlineTextarea.vue -->
<template>
  <div>
    <p
      v-if="!state.isEditMode"
      v-html="defaultValue"
      v-bind:style="state.textStyles"
      v-on:click="actions.toggleEditMode()"
    ></p>
    <textarea
      v-if="state.isEditMode"
      type="text"
      v-bind:style="state.textStyles"
      v-bind:value="state.text"
    >
    </textarea>
  </div>
</template>

<script>
import { reactive, ref } from "vue";
export default {
  name: "InlineTextarea",
  props: {
    defaultValue: {
      type: String,
      default: "",
    },
    textStyles: {
      type: Object,
      default: () => {
        return {
          fontSize: "24px",
          color: "#E5E5EB",
          lineHeight: "34px",
          fontWeight: 700,
        };
      },
    },
    maxRows: {
      type: Number,
      default: 2,
    },
  },
  setup(props, { emit }) {
    const state = reactive({
      isEditMode: false,
      text: props.defaultValue,
      textStyles: {
        ...props.textStyles,
        height: `${props.textStyles.lineHeight}px`,
      },
    });
    const actions = {
      toggleEditMode: () => {
        state.isEditMode = !state.isEditMode;
      },
    };
    return { state, actions };
  },
};
</script>

```
   state 에 isEditMode 라는 변수를 선언 했다. true 일때, actions.toggleEditMode 에의해 토글된다.
   토글된 textarea 에는 state.text 가 value 로 들어가고, props 로 받은 textStyles에  {height: lineHeight } 를 해준다.
   textarea 와 p 태그의 높이를 고정시켜서 두개의 태그가 토글 되더라도 UI 상에서 흔들림 없게 하기 위함이다. 

   토글된 이후에는 textarea에 focus 이벤트를 걸어주자.

```vue
<!-- InlineTextarea.vue textarea 에 토글 되고나서 focus 이벤트 걸기 -->
<template>
  <div>
    <p
      v-if="!state.isEditMode"
      v-html="defaultValue"
      v-bind:style="state.textStyles"
      v-on:click="actions.toggleEditMode()"
    ></p>
    <!-- ref 추가  -->
    <textarea
      ref="textareaElement"
      v-if="state.isEditMode"
      type="text"
      v-bind:style="state.textStyles"
      v-bind:value="state.text"
    >
    </textarea>
  </div>
</template>

<script>
import { reactive, ref } from "vue";
export default {
  name: "InlineTextarea",
  props: {
    defaultValue: {
      type: String,
      default: "",
    },
    textStyles: {
      type: Object,
      default: () => {
        return {
          fontSize: "24px",
          color: "#E5E5EB",
          lineHeight: "34px",
          fontWeight: 700,
        };
      },
    },
    maxRows: {
      type: Number,
      default: 2,
    },
  },
  setup(props, { emit }) {
    const textareaElement = ref(); // <---- 여기 추가


    const state = reactive({
      isEditMode: false,
      text: props.defaultValue,
      textStyles: {
        ...props.textStyles,
        height: `${props.textStyles.lineHeight}px`,
      },
    });
    const actions = {
      toggleEditMode: () => {
        state.isEditMode = !state.isEditMode;
        // 여기 추가됨.
         if (state.isEditMode) {
          setTimeout(() => {
            textareaElement.value.focus();
          }, 50);
        } 
      },
    };
    return { state, actions, textareaElement }; // <--- 여기 textareaElement 추가됨
  },
};
</script>
```

   toggleEditMode 함수를 자세히 보자. state.isEditMode 가 true 로 되었을 때, textareaElement 에 focus 이벤트를 주는데,
   setTimeout이 걸려있다. 이유는 setTimeout 없이 focus 이벤트를 주면 v-if 로 state.isEditMode = true 로 textarea가 dom 에 렌더링 되기 전에
   textareaElement.value.focus() 함수가 실행되므로 textarea 를 못찾아서 에러가 발생하기 때문이다.

   이제 본격적으로 입력에대한 처리를 해보자.


## textarea 입력에 대한 처리

```vue
<!-- InlineTextarea.vue input 이벤트에대한 로직 처리 -->
<template>
  <div>
    <p
      v-if="!state.isEditMode"
      v-html="defaultValue"
      v-bind:style="state.textStyles"
      v-on:click="actions.toggleEditMode()"
    ></p>

    <textarea
      ref="textareaElement"
      v-if="state.isEditMode"
      type="text"
      v-bind:style="state.textStyles"
      v-bind:value="state.text"
      v-on:input="actions.inputEvent($event)"
      v-on:keypress="actions.keyPressEvent($event)"
    >
    </textarea>
  </div>
</template>

<script>
import { reactive, ref } from "vue";
export default {
  name: "InlineTextarea",
  props: {
    defaultValue: {
      type: String,
      default: "",
    },
    textStyles: {
      type: Object,
      default: () => {
        return {
          fontSize: "24px",
          color: "#E5E5EB",
          lineHeight: "34px",
          fontWeight: 700,
        };
      },
    },
    maxRows: {
      type: Number,
      default: 2,
    },
  },
  setup(props, { emit }) {
    const textareaElement = ref();


    const state = reactive({
      isEditMode: false,
      text: props.defaultValue,
      textStyles: {
        ...props.textStyles,
        height: `${props.textStyles.lineHeight}px`,
      },
      inputCount: 0,
    });
    const actions = {
      toggleEditMode: () => {
        state.isEditMode = !state.isEditMode;
        // 여기 추가됨.
         if (state.isEditMode) {
          setTimeout(() => {
            textareaElement.value.focus();
          }, 50);
        } 
      },
      inputEvent: (e) => {
        state.inputCount += 1;
        textareaElement.value.removeAttribute("maxlength");
        let lineHeight = props.textStyles.lineHeight.replace("px", "");
        let textareaHeight = textareaElement.value.scrollHeight;
        let numberOfLines = Math.floor(textareaHeight / lineHeight);
        if (numberOfLines > props.maxRows) {
          textareaElement.value.setAttribute(
            "maxlength",
            e.target.value.length - 1
          );
          state.text = e.target.value.slice(0, -1);
        } else {
          state.textStyles.height = `${textareaHeight}px`;
          if (state.inputCount === 1) {
            state.text = e.target.value;
          }
        }
      },
      keyPressEvent: (e) => {
        let lineHeight = props.textStyles.lineHeight.replace("px", "");
        let textareaHeight = textareaElement.value.scrollHeight;
        let numberOfLines = Math.floor(textareaHeight / lineHeight);
        if (numberOfLines === props.maxRows && e.keyCode === 13) {
          e.preventDefault();
          return false;
        }
      },
    };
    return { state, actions, textareaElement };
  },
};
</script>
```
   textarea 에 v-on 디렉티브로 input 이벤트에는 actions.inputEvent($event) method 가 걸려있고,
   keypress 이벤트에는 actions.keyPressEvent($event) 가 걸려있다.

   우선 알아두어야 할 점은 textarea 의 input 이벤트에서 e.preventDefault(); 로 입력을 제한하는것은 통하지않는다.
   이번에 처음알게된 사실이다. 해보면 안된다는것을 알 수 있다.

   먼저 inputEvent 함수를 살펴보자.

```javascript
    inputEvent: (e) => {
        state.inputCount += 1;
        textareaElement.value.removeAttribute("maxlength");
        let lineHeight = props.textStyles.lineHeight.replace("px", "");
        let textareaHeight = textareaElement.value.scrollHeight;
        let numberOfLines = Math.floor(textareaHeight / lineHeight);
        if (numberOfLines > props.maxRows) {
            textareaElement.value.setAttribute(
            "maxlength",
            e.target.value.length - 1
            );
            state.text = e.target.value.slice(0, -1);
        } else {
            state.textStyles.height = `${textareaHeight}px`;
            if (state.inputCount === 1) {
            state.text = e.target.value;
            }
        }
    },
```
   state.inputCount += 1; 는 마지막에 설명 하겠다.
   textareaElement.value.removeAttribute("maxlength"); 이부분도 마지막에 설명하겠다.

   let lineHeight = props.textStyles.lineHeight.replace("px", ""); 이부분은
   textarea 의 lineHeight 값이다. props로 받아왔고 타입은 string 이다. 뒤에 px 을 제거해주고 숫자만 남긴다.
   let textareaHeight = textareaElement.value.scrollHeight; 이 부분은 textarea 의 입력된 줄수의 높이와 같다. 즉, 
   한줄이면 lineHeight와 같고, 두줄이면 lineHeight*2 와 같다.
   let numberOfLines = Math.floor(textareaHeight / lineHeight); 줄수를 구하는 식이다.

```javascript
    if (numberOfLines > props.maxRows) {
        textareaElement.value.setAttribute(
        "maxlength",
        e.target.value.length - 1
        );
        state.text = e.target.value.slice(0, -1);
    } 
```
   줄 수가 maxRows 보다 크면 로직을 탄다.
```javascript
   textareaElement.value.setAttribute(
        "maxlength",
        e.target.value.length - 1
    );
```
   우선 textarea 의 maxlength 를 현재 입력된 텍스트 길이보다 1개 적게 걸어준다.
   이유는 입력 이벤트가 먼저 일어나기 때문에 현재 입력된 텍스트길이와 같게 설정해주면 3번째 줄로 넘어가서 마지막 텍스트가 입력된다.
   maxlength 를 1개 더 적게 설정한다고 해서 3번째 줄 입력이 안되는 것은 아니다.
   그래서 이후에 아래와 같이 해준다.

```javascript
    state.text = e.target.value.slice(0, -1);
```
   textarea 에 바인딩되어있는 state.text 를 현재입력된 텍스트의 마지막문자를 제거하여 업데이트 해준다.
   그러면 세번째로 입력된 텍스트가 지워지면서 세번째줄로 안넘어같것처럼 UI가 보여질 것이다.

```javascript
    else {
        state.textStyles.height = `${textareaHeight}px`;
        if (state.inputCount === 1) {
            state.text = e.target.value;
        }
    }
```
   이부분을 보면 textarea 의 height 를 동적으로 변화시켜준다.
   첫번째 줄에서 두번쨰줄로 입력이 넘어갈 때 textarea 의 height 가 업데이트 된다.
   이제 state.inputCount 에대해서 설명하겠다. 이유는 못찾았지만. p태그에서 textarea로 처음 토글되고 focus이벤트 이후 입력을 하려고 하면 첫번째 글자가 먹는다.(입력이 안된다.)
   그래서 else 문에 state.text 에 강제로 현재 값을 넣어주었다.(input 이벤트가 먼저 발생하기 때문에)
   첫 문자만 한번에 입력되면 되서 if 문으로 inputCount =1 인 경우에만 예외적으로 처리를 해주었다.


   마지막으로 keyPressEvnet 를 보자.
```javascript
    keyPressEvent: (e) => {
        let lineHeight = props.textStyles.lineHeight.replace("px", "");
        let textareaHeight = textareaElement.value.scrollHeight;
        let numberOfLines = Math.floor(textareaHeight / lineHeight);
        if (numberOfLines === props.maxRows && e.keyCode === 13) {
        e.preventDefault();
        return false;
    }
```
   줄바꿈에대한 처리이다. 즉, 엔터키를 누를때 발생한다. 로직은 입력중인 줄이 두번째 줄일 때, 엔터를 입력하면 e.preventDefault()가 입력을 제한한다.
   keyPress event 에서는 input 이벤트를 e.preventDefault() 로 막을 수 있다.
   추가적인 미션은 textarea 에서 focusout 되었을 때, api 를 쏴서 데이터를 업데이트 후 다시 p 태그로 토글 되는것이다.
   물론 p태그에는 textarea 에 입력된 텍스트가 노출되어야 한다. 이 이야기는 주제와 벗어나므로 생략하기로 한다.






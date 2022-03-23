# 트랜지션 사용하기

source: `{{ page.path }}`


트랜지션은 element 가 생성되거나 사라질때 애니메이션 효과를 주는 기법이다.     
VUE 에서 사용하는 방법을 보자.   

```vue
<template>
    <div>
        <button v-on:click="actions.showText()">show text</button>
        <button v-on:click="actions.hideText()">hide text</button>


        <Transition name="slide-fade">
            <h1 v-if="state.isShow">Hello~!</h1>
        </Transition>
    </div>
</template>

<script>
import { reactive } from "vue";

export default {
    name:"TransitionComponent",
    setup() {
        const state = reactive({
            isShow: false
        });

        const actions = {
            showText: () => {
                state.isSHow = true
            },
            hideText: () => {
                state.isSHow = false
            } 
        }

        return { state , actions}
    }
}
</script>

<style scoped>
  .slide-fade-enter-active {
    transition: all 1s ease-out;
  }

  .slide-fade-leave-active {
    transition: all 1s cubic-bezier(1, 0.5, 0.8, 1);
  }

  .slide-fade-enter-from,
  .slide-fade-leave-to {
    transform: translateY(30px);
    opacity: 0;
  }
</style>

```
<br>
transition 을 사용할때는 transition 태그를 사용하고, 이름을 지정 해 주어야한다.   
name="slide-fade" 라고 했다고 하자.    
그럼 style 태그에 <br><br>
.slide-fade-enter-active (생성 될때 transition css) <br>
.slide-fade-leave-active (사라질 때 transition css) <br>
.slide-fade-enter-from,  .slide-fade-leave-to (transitionY(px) 은 사라지고, 나타낼때 방향이다.)<br><br>
위처럼 클래스 이름이 정해지고, 해당클래스에 css로 애니메이션을 지정해주면 원하는 애니메이션으로   
트랜지션을 만들 수 있다.


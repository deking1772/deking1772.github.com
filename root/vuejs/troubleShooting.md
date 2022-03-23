# trouble shooting

source: `{{ page.path }}`

## Composition API emits 옵션

우선 emits option 사용의 시작은 회사 부사수인 로마노님이었다.   
컴포넌트에 emits 옵션을 사용했다. 뭔지도 모르고...   
어떤 용도인지 잘 모르면 사용하지 말라고 알려주었고, 제대로 알고 사용하라고 말해주었다.  

그리고 한 달정도가 지났을까. emits의 용도를 정확히 알았다.   
vue3 로 개발을 해본 개발자라면 아래와 같은 경고 문구를 간혹 만났을지도 모른다.   

<img src="/assets/images/vuejs/vue_warning1.png" alt="뷰js 경고" /><br/> 

위 경고 내용은 컴포넌트가 <b>하나의 태그로 감싸져있지 않고, 해당 컴포넌트에서 emit을 사용하면</b> 발생하는 경고다.

이해를 위해 리스트를 포함하는 부모컴포넌트와 리스트    
하나하나를 표시하는 자식컴포넌트로 표현을 하겠다.   
아래 예시 코드를 보자.
```
    // ItemComponent.vue (자식 컴포넌트)
    <template>
        <div>
            ...
            <button v-on:click="$emit('emitName')">click me</button>
            ...
        </div>

        <div>
            ...
        </div>
    </template>

    <script>
        export default {
            name: "ItemComponent",
            props: {...},
            setup() {
                ...
            }
        }
    </script>
```   
```
    // 부모컴포넌트 ListComponent.vue
    <template>
        <div>
            ...
            <ItemComponent 
                v-for="(item,index) in list"
                v-bind:key=index
            />
            ...
        </div>
    </template>
```   
위와같이 코딩을 하면 발생하는 경고이다.   
위 경고를 없애는 방법은 두가지이다.   


<b>첫번째</b>  
    - ItemComponent.vue 파일을 하나의 div 태그로 감싼다.   

```
    // ItemComponent.vue

    <template>
        <div>
            <div>
            ...
            <button v-on:click="$emit('emitName')">click me</button>
            ...
        </div>

        <div>
            ...
        </div>
        </div>
    </template>

    <script>
        export default {
            name: "ItemComponent",
            props: {...},
            setup() {
                ...
            }
        }
    </script>
```   

<b>두번째</b> 
    - emits 옵션을 사용한다.   

```
    // ItemComponent.vue (자식 컴포넌트)
    <template>
        <div>
            ...
            <button v-on:click="$emit('emitName')">click me</button>
            ...
        </div>

        <div>
            ...
        </div>
    </template>

    <script>
        export default {
            name: "ItemComponent",
            props: {...},
            emits: ['emitName'],
            setup() {
                ...
            }
        }
    </script>
 ```      
 위와같이 사용하면 경고가 사라지는것을 확인할 수 있다.
   
      

## v-on:keyup.enter="() => {}" 이벤트 두번 발생

간단한 트러블 슈팅   
v-on:keyup.enter 이벤트는 input 에서 엔터를 입력했을때 발생하는 이벤트다.   

그런데

v-on:keyup.enter 는 엔터를 누를 때, 그리고 뗄때 이벤트가 두번 발생 한다.
      
이를 방지하려면  
v-on:keyup.enter 말고 v-on:keypress.enter 를 써야한다.   


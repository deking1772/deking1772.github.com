# VITE

source: `{{ page.path }}`


# VITE 에 대해서....



# VITE typescript config

## isolatedModules
공식문서에 의하면 (<a href="https://vitejs.dev/guide/features.html#typescript-compiler-options">vite tsconfig</a>) 아래와 같이 나와있다.
``` 
    Some configuration fields under compilerOptions in tsconfig.json require special attention.

    isolatedModules#
    Should be set to true.

    It is because esbuild only performs transpilation without type information, it doesn't support certain features like const enum and implicit type-only imports.

    You must set "isolatedModules": true in your tsconfig.json under compilerOptions, so that TS will warn you against the features that do not work with isolated transpilation.

    useDefineForClassFields#
    Starting from Vite 2.5.0, the default value will be true if the TypeScript target is ESNext. It is consistent with the behavior of tsc 4.3.2 and later. It is also the standard ECMAScript runtime behavior.

    But it may be counter-intuitive for those coming from other programming languages or older versions of TypeScript. You can read more about the transition in the TypeScript 3.7 release notes.

    If you are using a library that heavily relies on class fields, please be careful about the library's intended usage of it.

    Most libraries expect "useDefineForClassFields": true, such as MobX, Vue Class Components 8.x, etc.

    But a few libraries haven't transitioned to this new default yet, including lit-element. Please explicitly set useDefineForClassFields to false in these cases.
```
해석하면 tsconfig.json > compilerOptions 아래 옵션에 isolatedModules 을 true 로 설정 해야 된다는 내용이다.   
이유는 vite 에서는 pre-bundling 을 하는데, 이때 esbuild 라는 것을 사용한다.   
esbuild 는 고립된 모듈의 const enum 이나 implicit type-only imports 등등 의 몇가지 기능들을 지원하지 않기 때문이다.   
isolatedModules 를 true 로 설정하면 TS 는 위와같이 지원하지 않는 몇가지 기능들에 대한 문제가 생겼을 때 에러를 발생 시킬 것이다. 

## useDefineForClassFields
vite 공식문서에 의하면 이옵션 또한 true 로설정하라는 내용이다.   
ㄴ 이유는 대충 읽어보면 대세가 그렇다는 내용이다.ㅋㅋㅋㅋㅋ 자세히 알아보실 분들은 직접 찾아보시길...

## Client Types

tsconfig.json > compilerOptions 에 "types": ["vite/client"] 를 추가하면   
아래와 같은 타입을 제공한다. => 뭔소린지 모르겠으니 일단 따라해보자...

    - Asset imports (e.g. importing an .svg file)
    - Types for the Vite-injected env variables on import.meta.env
    - Types for the HMR API on import.meta.hot
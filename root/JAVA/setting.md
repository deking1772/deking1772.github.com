# JDK, JVM(JRM), ECLIPSE 설치

source: `{{ page.path }}`




1. [JDK 설치](https://www.oracle.com/java/technologies/downloads/){:target="_blank"}

2. [JRE(=JVM) 8 버전 설치 (JAVA 가상머신)](https://www.oracle.com/java/technologies/java-archive-javase10-downloads.html){:target="_blank"}

3. eclipse 설치   

    => 실행(java virtual machine 경로 설정 - 내가 원하는 디렉토리를 만들기) - JAVA_LAB 으로 함.

```
eclipse -> create a java project

project name -> first 로 함.
JRE 버전 선택

src > package 생성

클래스 만들기(command + N ) - Firtst 로 했음.
```

- **컨벤션**

   클래스이름은 대문자   
   패키지이름은 소문자


**First 클래스에 Hello World 출력하기**
```JAVA
package first;

public class HelloWorld {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Hellow world11");
	}
}
```

**컴파일 결과**
![컴파일 결과](/assets/images/java/setting/compile-result.png)   


<br/>
**컴파일 및 실행 과정 설명**   

>컴파일 -> .class file 이 bin 디렉토리 하위에 first directory 가 있고, 그 안에 class file 이 생성된다.   
컴파일하면 class file 은 bin 디렉토리 하위에 만들고, 실행하면 .이 파일을 실행한다!!



**자바를 쓰면 좋은점**
- 플랫폼에 영향을 받지 않으므로 다양한 환경에서 사용
- 객체지향 언어라서 유지보수 쉽고, 확장성이 좋다.
- 프로그램이 안정적이다.
- 풍부한 기능을 제공하는 오픈소스다.


!["자바 컴파일 및 실행 방식 C와 비교](/assets/images/java/setting/java-benefit.png)

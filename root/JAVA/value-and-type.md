# 변수와 자료형

source: `{{ page.path }}`


컴퓨터는 0과 1로 자료를 표현한다.   
따라서 숫자나 문자로도 0과 1의 조합으로 표현된다.   
기본적으로 2진수에 대해서 알아야 한다.

```
ex)
00000 -> 0
00001 -> 1
00010 -> 2
00011 -> 3
.
.
.
```

=> 2진수로 표현하면 길이가 길어지므로   
   8진수나 16진수를 사용하기도 한다.

```
8비트 ex)
114 -> 76

16바트 ex)
1A -> 26
```

숫자 10을 10진수, 8진수, 16진수로 출력해보자
```
int num = 10; -> 10진수
int bNum = 0B1010; -> 2진수 (0B 로 시작)
int oNum = 012 -> 8진수 (0 으로 시작)
int hNum = 0XA -> 16진수 (0x 로시작)
```

**이클립스에 연습해보자**  

  **mac => command + n** 을 입력하면 아래와 같이 나온다.
 
![JAVA PROJECT 생성](/assets/images/java/value-and-type/create-project.png "JAVA PROJECT 생성 이미지")
  Java Project 를 입력하고 next!!

project name 은 chapter2 로 했다.

src 하위에 패키지를 만든다. 이름은 binary 로 했다.

binary 패키지 안에 클래스를 만든다.  
이름은 binaryTest 로 했다.   
아래와 같이 만들어지면 잘 한거다.
![JAVA CLASS 생성](/assets/images/java/value-and-type/creat-class.png "자바 클래스 경로 이미지")


<br/>

**음의 정수 표현**   

  : 정수의 가장 왼쪽에 존재하는 비트는 부호비트!!!   
  MSB: 가장 중요한 비트라는 뜻    
     
ex)   
`
    -5 를 표현하기!! (8bit 기준)   
    일단 5를 표현해보자.   
    => 00000101   
`   

   
- 음수 만들기    
=> 1의 보수를 취한 값에 1을 더한다.
   
```
1의 보수 = 11111010   

1을 더한 값 = 11111101 -> 이진수로 -5 이다.
```

코드에서 32비트로 표시해보자.
binary 프로젝트에 binaryTest2 클래스를 만들고 실행해보자. 

```JAVA
package binary;

public class binaryTest2 {

	public static void main(String[] args) {
		// 음수 값 구하기 (32 bit)
		int num1 = 0B00000000000000000000000000000101;
		int num2 = 0B11111111111111111111111111111011; // num1의 1의보수에 +1 한 값! (num1 의 음수)
		
		int sum = num1 + num2;
		
		System.out.println(num1); // 5
		System.out.println(num2); // -5
		System.out.println(sum); // 0

	}

}

```

**컴파일 결과**   
![컴파일 결과](/assets/images/java/value-and-type/compile-result.png)


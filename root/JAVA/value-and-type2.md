# 변수와 자료형(2)

source: `{{ page.path }}`

- **변수의 정의**
    
    프로그램에서 사용되는 자료를 저장하기 위한 공간   
    할당받은 메모리의 주소 대신 부르는 이름   

<br />

- **변수 선언과 초기화**

```JAVA
package binary;

public class VariableEx {

	public static void main(String[] args) {
		int num; // 변수 선언
		num = 10; // lValue(left), rValue(right)

		System.out.println(num);
	}

}

```
=> 결과 : 10 출력   




- **변수 선언시 유의점**

    변수이름은 알파베 쑷자, _,$ 로 구성된다   
    대소문자를 구분한다.    
    숫자로 시작할 수 없다   
    키워드도 변수의 이름으로 사용할 수 없다.    
    이름 사이에 공백이 있을 수 없다.

***tip)***   
변수명은 카멜을 주로 쓴다.   
변수에 의미를 제대로 부여하는게 중요하다.



- 변수가 저장되는 공간의 특성 - 자료형
  정수형 문자형 실수형 논리형 (표 이미지 보고 마크다운으로 만들기)   

| 자료형 | 바이트 크기 | 수의 범위 |
|---|:---:|---:|
| `byte` | 1 | -2^7 ~ 2^7 - 1 | 
|  `short` | 2 | -2^7 ~ 2^7 - 1 | 
| `int` | 4 | -2^7 ~ 2^7 - 1 |
| `long` | 8 | -2^7 ~ 2^7 - 1 | 


- **정수 자료형**

```JAVA
package binary;

public class ByteVariable {

	public static void main(String[] args) {
		byte bData = -128;
		System.out.println(bData);

		byte bData2 = 127; // 128 이상일 경우 error ->byte 의 단위를 넘었기 떄문에!!
		System.out.println(bData2);

	}

}
```
<br />

- **int, long**

```JAVA
package binary;

public class VariableEx2 {

	public static void main(String[] args) {

		int num = 10; // 여기서 10은 리터럴 이라고 부른다.
		int level = 50; // 모든 숫자는 4byte로 저장한다.

		// int num = 123456789000; // int 가 저장할 수 없는 큰수 -> long ??

		// long num1 = 123456789000 // long 으로 했는데도 에러!!!

		// 해답은 숫자뒤에 L 을 붙여준다. => 8byte 로 변수에 할당한다.
		long num2 = 12345678900L;

		System.out.println(num2);


	}

}

```


- **char - 문자 자료형**   
   컴퓨터에서는 문자도 내부적으로 비트조합으로 표현    
   자바에서는 문자를 2바이트로 처리   
   
<br/>   
   
인코딩 - 각문자에 따른 특정한 숫자값(코드값)을 부여    

디코딩 - 숫자값을 원래의 문자로 변환

- **문자세트**   
  아스키 : 1 바이트로 영문자, 숫자, 특수문자들을 표현함   
  유니코드 : 한글과 같은 복잡한 언어를 표현하기 위한 표준 이코딩 UTF-8, UTF-16 이 대표적   
  문자를 변수에ㅐ 저장하면 문자에 해당하는 코드값이 저장   
  자바는 유니코드 UTF-16 인코딩 사용   

```JAVA
package binary;

public class CharacterEx {

	public static void main(String[] args) {
		char ch = 'A';
		
		System.out.println(ch); // A
		System.out.println((int)ch); // 65
		
		ch = 65;
		
		System.out.println(ch); // A
		System.out.println((int)ch); // 65
			
		
		int ch2 = 67;
		
		System.out.println(ch2); // 67
		System.out.println((char)ch2); // C
	
	}

}
```


- **float, double - 실수 자료형**   
  float 은 4바이트, double 은 8바이트   



- 실수는 기본적으로 long 형으로 처리   
**float 형으로 사용하는 경우 숫자에 f,F 를 명시함**

```JAVA
package binary;

public class DoubleEx {

	public static void main(String[] args) {

		double dNum = 3.14;
		float fNum = 3.14f; // 3.14 만 쓰면 error!!
	}

}

```



- **boolean - true, false (논리형)**   


<br/>

- **자료형 없이 변수 사용하기 (자바 10)**
  지역변수 자료형 추론 (local variable type interface):   
  변수에 대입되는 값을 보고 컴파일러가 추론   

- **자료형이 필요한 이유**: 수를 선언 할 때는 변수가 사용할 메모리 크기와 타입을 구분하기 위해 자료형을 사용   


```JAVA
package binary;

public class DoubleEx {

	public static void main(String[] args) {

		double dNum = 3.14;
		float fNum = 3.14f; // 3.14 만 쓰면 error!!

		System.out.println(fNum);


		var dNum2 = 3.14; // var 는 자료형 추론이 된다. JAVA 10 이

		System.out.println(dNum2);

		var num = 10; // 이순간 num 은 int 형으로 고정된다.
		System.out.println(num);

		//num = 3.14 // error
	}

}

```




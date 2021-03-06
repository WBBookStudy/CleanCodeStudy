# 객체와 자료구조

## 자료 추상화

### example 1
```
public class point {
    public double x;
    public double y;
}
```
-> 
```
public interface point {
    double getX();
    double getY();
    void setCartesian(double x, double y);
    double getR();
    double getTheta();
    void setPolar(double r, double theta);
}
```
이런식으로 추상화로 제공한다.


### example 2
```
public interface Vehicle {
    double getFuelTankCapacityInGallons();
    double getGallonsOfGasoline
}
```
-> 
```
public interface Vehicle {
    double getPercentFuelRemaining();
}
```
똑같은 interface형식으로 제공하지만 사용자가 의미있게 사용할 수 있는 방식으로 제공하는듯?


## 자료 / 객체 비대칭 

### 절차지향적 예제
```
public class Square {
    public Point topLeft;
    public double side;
}

public class Rectangle {
    ...
}

public class Circle {
    ...
}

public class Geometry {
    public final double PI = 3.14~~~~
    
    public double area(Object shape) {
        if (shape instanceof Square) {
            ...
        }
        else if (shape instanceof Rectangle) {
            ...
        }
        else if (shape instanceof Circle) {
            ...
        }
        ...
    }
}
```

### 객체지향형 예제
```

public class Square implements Shape {
    ...
    
    public double area() {
        return side * side;
    }
}

public class Rectangle implements Shape {
    ...
}

public class Circle implements Shape {
    ...
}

```

case 1. 특정 함수를 추가하려면? 예를들면 높이를 구하는 함수라던가
 -> 절차지향 방식으로 코드를 작성했으면 자료구조는 변경할 필요 없이 Geometry라는 클래스에 함수를 추가해주기만 하면 된다. 반면 객체지향 방식으로 코드를 작성했다면 모든 자료구조의 해당 함수를 넣어주는 수정이 필요할것이다.
 
case 2. 특정 클래스(여기선 도형)을 추가한다면?
-> 절차지향 방식으로 코드를 작성했다면 Geometry의 area함수를 오류없이 수정해야한다. 반면 객체지향 방식으로 코드를 작성했다면, 수정이 되는 함수나 클래스 없이 새로 추가한 클래스만 추가해주면 될것이다.

즉, 객체지향이든 절차지향이든 특정상황에서 유리한거지 '어떤 패러다임이 무조건 좋다' 이렇지는 않다는뜻

## 디미터 법칙

### 디미터법칙이란? 
 -> 모듈은 자신이 조작하는 객체의 속사정을 몰라야한다는 휴리스틱
 -> 좀 더 세부적으로 예시를 들자면 클래스 C의 매서드 f는 다음과 같은 객체의 메서드만 호출해야한다
 -> 클래스C, f가 생성한 객체, f인수로 넘어온객체, C인스턴스 변수에 저장된 객체
 
 ### 기차충돌
 ```
 final String outputDir = ctxt.getOptions().getScratchDir().getAbsolutePath()
 ```
 위와같이 특정함수안의 객체의 함수를호출하고 이런식의 코드. 지양해야 한다고함..
 -> 의문점) 그런데 rxSwift나 SwiftUI는 저런코드를 기본적으로 엄청 사용한다...... 책의 저자는 안좋다고 했지만 딱히 그렇지도 않은걸까?
 
 
## 잡종 구조
위와 같은 문제로 객체지향, 절차지향이 짬뽕된 코드가 나옴.. 이러지말자..


## 구조체 감추기
```
BufferedOutputStream bos = ctxt.createScratchFileStream(classFileName);
```
위의 코드를 이런식으로 개선한듯

## 자료 전달 객체
```
public class Address {
    private String city;
    private String street;
    private String zip;
    
    public Address(String city, String street, String zip) {
        self.city = city
        self.street = street
        self.zip = zip
    }
    
    public String getCity() {
        return self.city;
    }
    
    public String getStreet() {
        return self.street;
    }
    
    public String getZip() {
        return self.zip;
    }

}
```
함수는 존재하지않고 정말 단순 데이터 전달용 클래스


## 활성레코드
위의 자료전달객체에 함수를 넣어놓는 형식, 좋은방법이 아니다.


 
 
 
 
 
 

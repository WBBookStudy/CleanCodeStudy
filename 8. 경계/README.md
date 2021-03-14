# 경계

## 외부
-> 개발자가 의도하지 않은 방법으로 사용할 수 있는 여지를 없애버리자
### ex)
```
public class MyFramework {
    func setMyInfo(_ :[String : String])
    func getUserInfo() -> [String : String]
}
```
-> 
```
public class MyFramework {
    typealias InfoKey = String
    func setMyInfo(_ :[InfoKey : MyInfo])
    func getUserInfo() -> MyInfo
}

public class MyInfo {
    name: String
    age: Int
}
```
++ [예제](https://hanweeee.tistory.com/7)

## 경계 살피고 익히기
-> 타사라이브러리를 사용해 개발을 할 경우 발생한 에러가 내가 만든 에러인지, 타사 라이브러리에서 발생된 에러인지 파악하는대 시간이 오래걸림. -> 학습테스트를 이용하자 !
#### 학습테스트? : 신규 라이브러리등을 적용할때 유닛테스트의 개념으로 미리 테스트코드를 만들자 

## log4j
-> 자바용인것같아서 그냥 넘어가겠습니다..... 필요하신분은 알아서 찾아 쓰시길..

## 학습 테스트는 공짜 이상이다
학습 테스트에 드는 비용은 없다. 어쨋든. API를 배워야하므로..
학습테스트는 신규버전에 대한 대응도 할 수 있으며, 안정성을 가져가도록 도와준다.
-> 결국 TDD를 하자! 라는 말인듯

## 아직 존재하지 않는 코드를 사용하기
존재하지않는 코스트를 작성해야한다면? 인터페이스 설계를 우선 먼저 하자.
예제의 FakeTransmitter클래스를 구현하는것처럼 Stub클래스를 생생해서 테스트에 적극 활용하자 !
-> 더미데이터를 만들어서 테스트

## 깨끗한경계
앞에서의 예제처럼 인터페이스를 제공함으로써 명확하게 코드를 작성하자. 그렇게된다면 코드를 변경하는데 많은 투자와 재작업이 필요하지 않다.




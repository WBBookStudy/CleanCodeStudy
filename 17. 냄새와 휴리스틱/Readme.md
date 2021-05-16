# 17. 냄새와 휴리스틱
## 주석
### C1: 부적절한 정보
 다른 시스템에 저장할 정보는 주석으로 적절치 못하다. (Jir나, Git Commit로그 같은) 일반적으로 작성자, 최종 수정일, Software Problem Report번호 등과 같은 메터정보만 주석으로 넣는다.
 
### C2: 쓸모 없는 주석
 오래된 주석, 엉뚱한 주석, 잘못된 주석은 안좋다. 쓸모없어진 주석은 제빨리 삭제하자. 

### C3: 중복된 주석
코드만으로 충분한테 구구절절 설명하는 주석이 중복된 주석. 
ex1)
```
i++; // i증가
```

ex2) 함수 서명만 달랑 기술하는 javadoc
```
/**
* @param sellRequest
* @return 
* @throws ManagedComponentException
*/
```

### C4: 성의없는 주석
간결명료하게 성의있게 작성하자

### C5: 주석 처리된 코드
읽는 사람을 헷갈리게 만드는 흉물 그 자체
만약 혹시몰라서 남겨두는거라면, 지우고 필요할때 깃에서 가져오자..


## 환경
### E1: 여러 단계로 빌드해야한다
빌드는 간단히 한 단계로 끝나야한다. 빌드하기전에 소스코드 관리 시스템에서 이것저것 따로 체크아웃하게해서는 안된다.

### E2: 여러 단계로 테스트해야한다.
모든 단위테스트는 한 명령으로 돌려야한다. 그 방법이 빠르고, 쉽고, 명백해야함.


## 함수
### F1: 너무 많은 인수
함수에서 인수의 개수는 작을수록 좋다.

### F2: 출력 인수
출력 인수는 직관을 정면으로 위배한다. 함수에서 뭔가의 상태를 변경해야 한다면 출력인수를 쓰지 말고 함수가 속한 객체의 상태를 변경한다.

### F3: 플래그 인수
boolean 인수는 함수가 여러 기능을 수행한다는 명백한 증거다. 플래그 인수는 혼란을 초래하므로 피해야한다.

### F4: 죽은 함수
아무도 호출하지 않는 함수는 삭제한다. 소스코드 관리 시스템이 모두 기억하므로 걱정할 필요 없다.


## 일반
### G1: 한 소스 파일에 여러 언어를 사용한다.
어떤 자바 소스 파일은 XML, HTML, YAML, javadoc, javaScript, 영어 등을 포함한다. 좋게 말하면 혼란스럽고, 나쁘게 말하면 조잡
이상적으론 소스 파일 하나에 언어 하나만 사용하는것이 가장 좋다.

### G2: 당연한 동작을 구현하지 않는다.
최소 놀람의 원칙(The Principle of Suprise)에 의거해 함수나 클래스는 다른 프로그래머가 당연하게 여길 만한 동작과 기능을 제공해야한다. 
ex)
```
Day day = DayDate.StringToDay(String dayName);
```
당연한 동작을 구현하지 않으면 코드를 읽거나 사용하는 사람이 더 이상 함수 이름만으로 함수 기능을 직관적으로 예상하기 어려워진다.

### G3: 경계를 올바로 처리하지 않는다.
스스로의 직관에 의존하지 마라. 모든 경계 조건(아마 틀릴 가능성이 있는 애매한 조건..?)을 찾아내고, 모든 경계 조건을 테스트하는 테스트 케이스를 작성하라

### G4: 안전 절차 무시
컴파일러 경고를 꺼버리면 빌드가 쉬워질지 모르지만 큰일 날 수 있음. 실패하는 테스트 케이스를 일단 제껴두고 나중으로 미루는 태도는 매우 위험

### G5: 중복
> DRY(Dont't Repeat Yourself)원칙
 - 코드에서 중복을 발견할 때 마다 추상화할 기회로 간주하라. 
 - 중복된 코드를 하위 루틴이나 다른 클래스로 분리하라. 
 - 추상화로 중복을 정리하면 설계 언어의 어휘가 늘어난다.
 - 쉬워지고, 빨라지고, 오류가 적어진다
#### case1) 복붙코드
#### case2) 여러 모듈에서 일련의 switch/case 혹은 if/else 문으로 똑같은 조건을 거듭 확인하는 중복 -> 이런 중복은 [다형성(polymorphism)](https://ko.wikipedia.org/wiki/%EB%8B%A4%ED%98%95%EC%84%B1_(%EC%BB%B4%ED%93%A8%ED%84%B0_%EA%B3%BC%ED%95%99))으로 대체해야 한다.
#### case3) 알고리즘이 유사하나 코드가 서로 다른 중복 -> [TEMPLEATE METHOD 패턴](https://yaboong.github.io/design-pattern/2018/09/27/template-method-pattern/)이나 [STRATEGY패턴](https://gmlwjd9405.github.io/2018/07/06/strategy-pattern.html)으로 중복을 제거하자

### G6: 추상화 수준이 올바르지 못하다.
모든 저차원 개념은 파생 클래스에 넣고, 모든 고차원 개념은 기초 클래스에 넣는다.
예를들어, 세부 구현과 관련한 상수, 변수, 유틸리티 함수는 기초 클래스에 넣으면 안된다.
때로는 기초 클래스와 파생 클래스로 분리하고, 때로는 소스 파일과 모듈과 컴포넌트로 분리한다.
ex)
```
public interface Stack {
    Object pop() throws EmptyException;
    void push(Object o) throws FullException;
    double percentFull();
    class EmptyException extends Exception {}
    class FullException extends Exception {}
}
```
percentFull함수는 추상화 수준이 올바르지 못하다. Stack을 구현하는 방법은 다양하다. Full이라는 정도를 표현할 경우의 수가 여러가지. 그러므로 이 함수는 BoundedStack과 같은 파생 인터페이스에 넣어야한다.

### G7: 기초 클래스가 파생 클래스에 의존한다.
개념을 기초 클래스와 파생 클래스로 나누는 가장 흔한 이유는 고차원 기초 클래스 개념을 저차원 파생 클래스 개념으로부터 분리해 독랍성을 보장하기 위해서다.
일반적으로 기초 클래스는 파생 클래스를 아예 몰라야 마땅하다.

### G8: 과도한 정보
잘 정의된 모듈은 인터페이스가 아주 작다. 하지만 작은 인터페이스로 많은 동작이 가능하다. 부실하게 정의된 모듈은 인터페이스가 구질구질하다. 
잘 정의된 인터페이스는 많은 함수를 제공하지 않고, 결합도가 낮다.
우수한 소프트웨어 개발자는 클래스나 모듈 인터페이스에 노출할 함수를 제한할 줄 알아야 한다. 
클래스가 제공하는 메서드 수는 적고, 함수가 아는 변수도 작을 수록 좋다. 클래스 안에 들어있는 인스턴스 변수 수도 작을 수록 좋다.
 - 자료를 숨겨라.  
 - 유틸리티 함수를 숨겨라.
 - 상수와 임시 변수를 숨겨라. 
 - 메서드나 인스턴스 변수가 넘쳐나는 클래스를 피하라.
 - 하위 클래스에서 필요하다는 이유로 protected변수나 함수를 마구 생성하지 마라
 - 인터페이스를 매우 작게 그리고 매우 깐깐하게 만들어라
 - 정보를 제한해 결합도를 낮춰라
 
### G9: 죽은 코드
죽은 코드란 실행되지 않는 코드를 가리킨다. 
죽은 코드는 시간이 지나면 악취를 풍기기 시작한다. 적절한 장례식을 치뤄주라. 시스템에서 제거하라.

### G10: 수직 분리
변수와 함수는 사용되는 위치에 가깝게 정의한다. 지역 변수는 처음으로 사용하기 직전에 선언하며 수직으로 가까운 곳에 위치해야한다.
비공개 함수는 처음으로 호출한 직후에 정의한다. 


### G11: 일관성 부족
어떤 개념을 특정 방식으로 구현했다면 유사한 개념도 같은 방식으로 구현한다. 표기법은 신중하게 선택하며, 일단 선택한 표기법은 신중하게 따른다.

### G12: 잡동사니
아무도 사용하지 않는 변수, 아무도 호출하지 않는 함수, 정보를 제공하지 못하는 주석은 모두 제거하자.

### G13: 인위적 결합
서로 무관한 개념을 인위적으로 결합하지 않는다. 예를들어 일반적인 enum은 특정 클래스에 속할 이유가 없다. 범용 static 함수도 마찬가지로 특정 클래스에 속할 이유가 없다.
함수, 상수, 변수를 선언할 때는 시간을 들여 올바른 위치를 고민한다.

### G14: 기능 욕심
클래스 메서드는 자기 클래스의 변수와 함수에 관심을 가져야지 다른 클래스의 변수와 함수에 관심을 가져서는 안된다. 

ex)
```
public class HourlyPayCalculator {
    public Money calculateWeeklyPay(HourlyEmployee e) {
        int tenthRate = e.getTenthRate().getPennies();
        int tenthWorked = e.getTenthWorked();
        ...
        
        return new Money(...);
    }
}
```
calculateWeeklyPay 메서드는 HourlyEmployee객체에서 온갖 정보를 가져온다. 즉, calculateWeeklyPay 메서드는 HourlyEmployee 클래스의 범위를 욕심낸다.

### G15: 선택자 인수
함수 호출 끝에 달리는 false만큼 밉살스런 코드도 없다.
선택자 인수는 목적을 기억하기 어려울 뿐 아니라 각 선택자 인수가 여러 함수를 하나로 조합한다. 

ex)
```
public int calculateWeeklyPay(boolean overtime) {
    ...
    double overtimeRate = overtime ? 1.5 : 1.0 tenthRate;
    int overtimePay = (int)Math.round(overTime * overTimeRate);
    return straightPay + overtimePay;
}
```
->
```
public int straightPay() {
    return getTenthsWorked() * getTenthRate();
}

public int overTimePay() {
    ...
}

private int overTimeBonus(int overTimeTenths) {
    double bonus = 0.5 * getTenthRate() * overTimeTenths;
    ...
}

```

### G16: 모호한 의도
코드를 짤 때는 의도를 최대한 분명히 밝힌다.
ex) overTimePay method
```
public int m_otCalc() {
    return iThsWkd * iThsRte +
    (int) Math.round(0.5 * iThsRte *
      Math.max(0, iThsWkd - 400)
    );
}
```
-> ???

### G17: 잘못 지운 책임
코드는 독자가 자연스럽게 기대할 위치에 배치한다.
때로는 성능을 높히고자 기대할 위치가 아닌 다른 위치에 배치할 수도 있다. 그래도 괜찮지만, 그러려면 이런 사실을 반영해 함수 이름을 제대로 지어야한다.

### G18: 부적절한 static 함수

ex)
```
HourlyPayCalculator.calculatePay(employee, overtimeRate);
```
-> 알고리즘이 추후에 바뀔 가능성이 농후

### G19: 서술적 변수 

프로그램 가독성을 높이는 가장 효과적인 방법 중 하나가 계산을 여러 단계로 나누고 중간 값으로 서술적인 변수 이름을 사용하는 방법.

ex)
```
Matcher match = headerPattern.matcher(line);
if (match.find())
{
    String key = match.group(1);
    String value = match.group(2);
    headers.put(key.toLowerCase(), value);
}
```

### G20: 이름과 기능이 일치하는 함수
```
Date newDate = date.add(5);
```
-> 뭘 더하는걸까
->
```
Date newDate = date.addDay(5);
```

### G21: 알고리즘을 이해하라
프로그램이 돌아간다, 테스트가 성공한다 로는 부족함. 알고리즘이 올바르다는 사실을 확인하고 이해해야한다.

### G22: 논리적 의존성은 물리적으로 드러내라
한 모듈이 다른 모듈에 의존한다면 물리적인 의존성도 있어야 한다.

ex)
```
public class HourlyReport {
    ...
    private final int PAGE_SIZE = 55;
    ...

    public void genReport() {
        if (page.size() == PAGE_SIZE) {
            ...
        }
    }
}
```
-> 하드코딩 된 부분을 함수로 만들자

### G23: if/else 또는 Switch/case 문보다 다형성을 사용하라
 - 대다수가 개발자가 switch 문을 사용하는 이유는 그 상황에서 가장 올바른 선택이기 보다는 당장 손쉬운 선택이끼 때문. 다형성을 먼저 고려하자
 - 유형보다 함수가 더 쉽게 변하는 경우는 극히 드뭄
 
### G24: 표준 표기법을 따르라
이런것을 위한 문서가 없어야한다.

### G25: 매직 숫자는 명명된 상수로 교체하라
ex)
```
#define PI = 3.14
```

ex2)
```
assertEquals(7777, Employee.find("John Doe").employeeNumber());
```
->
```
assertEquals(HOURLY_EMPLOYEE_ID, Employee.find(HOURLU_EMPLOYEE_NAME.employeeNumber());
```

### G26: 정확하라
검색 결과 중 첫 번째 결과만 유일한 결과로 간주하는 행동은 순진하다. 부동소수점으로 통화를 표현하는 행동은 거의 범죄다.
코드에서 무언가를 결정할 때는 정확히 결정한다.
코드에서 모호성과 부정확은 의견차나 게으름의 결과다.

### G27: 관례보다 구조를 사용하라
추상메서드 >>>> switch/case

### G28: 조건을 캡슐화하라
부울 논리는 이해하기 어렵다.
조건의 의도를 분명히 밝히는 함수로 표현하라.
ex)
```
if (shouldBeDeleted(timer))
```
->
```
if (timer.hasExpired() && !timer.isRecurrent())
```

### G29: 부정 조건은 피하라
ex)
```
if (!buffer.shouldNotCompact())
```
-> 
```
if (buffer.shouldCompact())
```

### G30: 함수는 한 가지만 해야한다.
ex)
```
public void pay() {
    for (Employee e: employees) {
        if (e.isPayday()) {
            Money pay = e.calculatePay();
            e.deliverPay(pay);
        }
    }
}
```
-> 
```
public void pay() {
    for (Employee e: employees)
        payIfNecessary(e);
}

private void payIfNecessary(Employee e) {
    if (e.isPayday())
        calculayeAndDeliverPay(e);
}

private void calculayeAndDeliverPay(...) {
    ...
}
```

### G31: 숨겨진 시간적인 결합
때로는 시간적인 결합이 필요하다. 하지만 시간적인 결합을 숨겨서는 안된다.
함수를 짤 때는 함수 인수를 적절히 배치해 함수가 호출되는 순서를 명백히 드러낸다.

### G32: 일관성을 유지하라
코드 구조를 잡을 때는 이유를 고민하라.
그리고 그 이유를 코드 구조로 명백히 표현하라.
구조에 일관성이 없어 보인다면 남들이 맘대로 바꿔도 괜찮다고 생각한다. 시스템 전반에 걸쳐 구조가 일관성이 있다면 남들도 일관성을 따르고 보존한다.

### G33: 경계 조건을 캡슐화하라.
경계조건은 빼먹거나 놓치기 십상이다. 경계조건은 한 곳에서 별도로 처히한다. 코드 여기저기에서 처리하지 않는다. 다시말해, 코드 여기저기에 +1이나 -1을 흩어놓지 않는다.

### G34: 함수는 추상화 수준을 한 단계만 내려가야 한다.
함수 내 모든 문장은 추상화 수준이 동일해야한다. 그리고 그 추상화 수준은 함수 이름이 의미하는 작업보다 한 단계만 낮아야한다.

### G35: 설정 정보는 최상위 단계에 둬라
추상화 최상위 단계에 둬야 할 기본값 상수나 설정 관련 상수를 저차원 함수에 숨겨서는 안된다. 대신 고차원 함수에서 저차원 함수를 호출할 때 인수로 넘긴다.

### G36: 추이적 탐색을 피하라
일반적으로 한 모듈은 주변 모듈을 모를수록 좋다. 좀 더 구체적으로 A가 B를 사용하고 B가 C를 사용하더라도 A가 C를 알아야 할 필요는 없다는 뜻이다.
-> 디미터 법칙, 부끄럼 타는 코드 작성



## 자바 



## 이름

### N1: 서술적인 이름을 사용하라
이름은 성급하게 정하지 않는다. 서술적인 이름을 신중하게 고른다.
사용자의 예상대로 돌아가도록 이름을 사용하자

### N2: 적절한 추상화 수준에서 이름을 선택하라
구현을 드러내는 이름은 피하라. 작업 대상 클래스나 함수가 위치하는 추상화 수준을 반영하는 이름을 선택하라.

ex) 
```
public interface Modem {
    boolean dial(String phoneNumber);
    ...
}
```
->
```
public interface Modem {
    boolean connect(String connectionLocator);
    ...
}
```

### N3: 가능하다면 표준 명명법을 사용하라.
그래야 쉽다.

### N4: 명확힌 이름
함수나 변수의 목적을 명확히 밝히는 일므을 선택하자.
길어도 괜찮다.

### N5: 긴 범위는 긴 이름을 사용하라
```
private void rollmany(int n, int pins) {
    for (int i = 0 ; i < n ; i++) {
        g.roll(pins);
    }
}
```

### N6: 인코딩을 피하라
이름 유형 정보나 범위 정보를 넣어서는 안된다.
m_같은 접두어를 더이상 붙힐 필요가 없다. 
헝가리안을 쓰자

### N7 이름으로 부수 효과를 설명하라
함수, 변수, 클래스가 하는 일을 모두 기술하는 이름을 사용한다. 이름에 부수 효과를 숨기지 않는다.
ex)
```
public ObjectOutputStream getOss() throws IOException {
    if (m_oos == null {
        m_oos = newObjectOutputStream(m_socket.getOutputStream());
    }
}
```



## 테스트
### T1: 불충분한 테스트
테스트 케이스는 잠재적으로 깨질 만한 부분을 모두 테스트해야한다. 테스트 케이스가 확인하지 않는 조건이나 검증하지 않는 계산이 있다면 그 테스트는 불완전하다.

### T2: 커버리지 도구를 사용하라!
커버리지 도구는 테스트가 빠뜨리는 공백을 알려준다. 커버리지 도구를 사용하면 테스트가 불충분한 모듈, 클래스, 함수를 찾기가 쉬워진다.

### T3: 사소한 테스트를 건너뛰지 말아라
사소한 테스트는 짜기 쉽다. 사소한 테스트가 제공하는 문서적 가치는 구현에 드는 비용을 넘어선다.

### T4: 무시한 테스트는 모호함을 뜻한다.
때로는 요구사항이 불분명하기에 프로그램이 돌아가는 방식을 확신하기 어렵다. 
선택 기준은 모호함이 존재하는 테스트 케이스가 컴파일이 가능한지 불가능한지에 달렸다.

### T5: 경계 조건을 테스트하라
경계 조건은 각별히 신경 써서 테스트한다

### T6: 버그 주변은 철저히 테스트하라
버그는 서로 모이는 경향이 있다. 한함수에서 버그를 발견했다면 그 함수를 철저히 테스트하는 편이 좋다.

### T7: 실패 패턴을 살펴라
때로는 테스트 케이스가 실패하는 패턴으로 문제를 진단할 수 있다.

### T8: 테스트 커버리지 패턴을 살펴라
통과하는 테스트가 실행하거나 실행하지 않는 코드를 살펴보면 실패하는 테스트 케이스의 실패 원인이 드러난다.

### T9: 테스트는 빨라야한다.









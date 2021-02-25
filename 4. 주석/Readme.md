
# 주석
## 나쁜 코드에 주석을 달지 마라. 새로 짜라.
 - 브라이언 W. 커니핸, P.J 플라우거
 주석은 나쁜 코드를 보완하지 못한다.
 
 ### 코드로 의도를 표현하라
 ex)
 ```
// 직원에게 복지 혜택을 받을 자격이 있는지 검사한다.
if ((empoyee.isWorkHard) && (employee.age > 65)
```
->
```
if (employee.isEligibleForFullBenefits()) {
 ...
}

func isEligibleForFullBenefits() -> Bool {
    return ((self.isWorkHard) && (self.age > 65)
}
```

### 좋은 주석

1. 법적인 주석
```
//
//  ViewController.swift
//  AutoScrollHeightTest
//
//  Created by hanwe lee on 2020/07/30.
//  Copyright © 2020 hanwe. All rights reserved.
//
```
요즘엔 IDE에서 자동으로 만들어줌...



2. 정보를 제공하는 주석
```
// kk:mm:ss EEE, MMM dd, yyyy형식이다
Pattern timeMatcher = Pattern.compile("\\d*:\\d*:\\d* \\w*, \\w* \\d*, \\d*")
```
-> 하지만 Date형태의 데이터를 리턴한다면? 이방법이 좋다고는 되어있는데 최선은 아니라고 한다.



3. 의도를 설명하는 주석
```
func compareTo(Obj o) -> myEnumValue {
    if (o is MyWikiMember) {
        var returnValue = .notYetSeleted
        ...
        return returnValue
    }
    return .first //오른쪽 유형이므로 정렬순위가 더 높다.
}
```



4. 의미를 명료하게 밝히는 주석
```
func testCompareTo() {
    ...
    assertTrue(a.compareTo(a) == 0) // a == a
    assertTrue(a.compareTo(b) != 0) // a != b
    assertTrue(a.compareTo(ab) == 0) // ab == ab
}
```
-> 좋은 주석이라고 말은 할 수 있지만 주석을 잘못달 경우 찾기 엄청 힘들다



5. 결과를 경고하는 주석
```
public static SimpleDateFormat makeStandardHttpDateForamt() {
    // SimpleDateFormat은 스레드에 안전하지 못하다.
    // 따라서 각 인스턴스를 독립적으로 생성해야한다. 
    ...
}
```
-> 그나마 합리적인 주석



6. todo 주석
```
//todo-MdM 현재 필요하지 않다.
// 체크아웃 모델을 도입하면 함수가 필요없다.
func makeVersion() -> String {
  ...
}
```
-> 만약 필요없는 코드라면 지우는게 더 낫다



7. 중요성을 강조하는 주석
```
String listItemContent = match.group(3).trim();
// 여기서 trim은 정말 중요하다. trim 함수는 문자열에서 시작 공백을 제거한다.
// 문자열에서 시작 공백이 있으면 다른 문자열로 인식되기 때문이다.
...
```

### 나쁜 주석

1. 주절거리는 주석
```
public void loadProperties() {
    try {
        ...
    }
    catch(IOException e) {
        //속성 파일이 없다면 기본값을 모두 메모리로 읽어 들였다는 의미다.
    }
}
```
->  도통 무슨소리인지 모르겠는 주석. 명확하게 말해야한다.  명확히 어디에서 읽어들였는지 등..




2. 같은 이야기를 중복으로 하는 주석
```
// this.closed가 true일 때 반환되는 유틸리티 메서드다.
// 타임아웃에 도달하면 예외를 던진다.
public synchroized void waitForClose(final long timeoutMillis)
throws Exception
{
    if(!closed) {
        wait(timeoutMillis);
        if (!closed)
            throw ~~
    }
}
```



3. 오해할 여지가 있는 주석
-> 위의 2번 예제에서 코드를보면 주석에는 this.closed가 true일때 반환된다고 써있음
하지만 wait함수를 타기 전에 true로 바뀌게되면? throw는 wait가 실행된다음 호출되기떄문에 명확히 말하자면 true일때 반환되는것이 아니다. 안좋은 주석을 보게되면 개발자는 혼란에 빠진다.. (왜 이렇게 느리지..)



4. 의무적으로 다는 주석
-> 정말 쓸모없는짓.



5. 있으나 마나 한 주석
```
 /*
    기본 생성자
 */
 init() {
    ...
 }
 
 /*
    날짜값
 */
 let date: Date = Date()
```
-> 이런식으로 주석을 달아놓으면 개발자가 주석을 전부 무시해버린다.



6. 함수나 변수로 표현할 수 있다면 주석을 달지 마라.
```
// 전역 목록 <smodule>에 속하는 모듈이 우리가 속한 하위 시스템에 의존하는가?
if (smodule.getDependSubsystem().contain(subSysMod.getSubSystem()))
```
이것을
```
ArrayList moduleDependees = smodule.getDependSubsystems();
String ourSubSystem = subSysMod.getSubSystem();
if (moduleDependees.contains(ourSubSystem))
```
-> good 



7. 닫는 괄호에 다는 주석



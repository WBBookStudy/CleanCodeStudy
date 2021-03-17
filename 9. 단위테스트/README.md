# 단위테스트

## TDD 법칙 세 가지
1. 실패하는 단위 테스트를 작성할 때까지 실제 코드를 작성하지 않는다.
2. 컴파일은 실패하지 않으면서 실행이 실패하는 정도로만 단위 테스트를 작성한다.
3. 현재 실패하는 테스트를 통과할 정도로만 실제 코드를 작성한다.

## 깨끗한 테스트 코드 유지하기
#### 테스트 코드는 실제 코드 못지 않게 중요하다. 유명무실한, 오히려 방해가 되는 테스트코드를 작성하고 싶지않으면 깨끗한 테스트코드를 유지하자.

### 테스트는 유연성, 유지보수성, 재사용성을 제공한다.
#### 코드에 유연성, 유지보수성, 재사용성을 제공하는 버팀목은 단위테스트 !

### 깨끗한 테스트 코드
#### 깨끗한 테스트 코드를만들려면? 세 가지가 필요하다. 가독성, 가독성, 가독성
ex1)
```
public void testGetPageHieratchyAsXml() throws Exception {
  crawler.addPage(root, pathParser.parse("PageOne"));
  crawler.addPage(root, pathParser.parse("PageOne.ChildOne"));
  crawler.addPage(root, pathParser.parse("PageTwo"));
  
  request.setResource("root");
  request.addInput("type", "pages");
  Reponder responder = new SerializedPageResponder();
  SimpleResponse = response = 
    (SimpleResponse) responder.makeResponse (
        new FitNessContext(root), request);
  String xml = response.getContent();
  
  assertEquals("text/xml", response.getContentType());
  assertSubString("<name>PageOne</name>", xml);
  assertSubString("<name>PageOne.ChildOne</name>", xml);
  assertSubString("<name>PageTwo</name>", xml);
}
```

ex2)
```
public void testGetPageHierarchyAsXml() throws Exception {
  makePages("PageOne", "PageOne.ChildOne", "PageTwo");
  
  submitRequest("root", "type:pages");
  
  assertResponseIsXML();
  assertResponseContains(
    "<name>PageOne</name>", "<name>ChildOne</name>", "<name>PageTwo</name>"
  );

}
```
#### 테스트 코드는 본론에 돌입해 진짜 필요한 자료 유형과 함수만을 사용한다.

### 도메인에 특화된 테스트 언어
#### 위의 ex2)는 도메인에 특화된 언어, 계속해서 리펙토링을 통해 API들을 생성해나가야한다.

### 이중 표준
#### 단순, 간결, 표현력이 풍부해야하지만, 효율적일 필요는 없다.
ex1)
```
@Test
  public void turnOnLoTempAlarmAtThreashold() throws Exception {
    hw.setTemp(WAY_TOO_COLD);
    controller.tic();
    assertTrue(hw.heaterState());
    assertTrue(hw.blowerState());
    assertFalse(hw.coolerState());
    assertFalse(hw.hiTempAlarm());
    assertTrue(hw.loTempAlarm());
  }
```

ex2)
```
@Test
  public void turnOnLoTempAlarmAtThreshold() throws Exception {
    wayTooCold();
    assertEquals("HBchL", hw.getState());
  }
```

## 테스트당 assert 하나
ex1)
```
public void testGetPageHierarchyAsXml() throws Exception {
  makePages("PageOne", "PageOne.ChildOne", "PageTwo");
  
  submitRequest("root", "type:pages");
  
  assertResponseIsXML(); //출력이 XML이다.
  assertResponseContains( 
    "<name>PageOne</name>", "<name>ChildOne</name>", "<name>PageTwo</name>"
  ); // 특정 문자열을 포함한다.
}
```

ex2)
```
public void testGetPageHierarchyAsXml() throws Exception {
  givenPages("PageOne", "PageOne.ChildOne", "PageTwo");
  whenRequestIsIssued("root", "type:pages");
  
  then ResponseShouldBeXML();
}

public void testGetPageHierarchyHasRightTags() throws Exception {
  givenPages("PageOne", "PageOne.ChildOne", "PageTwo");
  
  whenRequestIsIssued("root", "type:pages");
  thenResponseShouldContain(
    "<name>PageOne</name>", "<name>ChildOne</name>", "<name>PageTwo</name>"
  )
}
```

-> 중복된 코드가 많아짐.
이 책의 저자는 이 규칙을 무조건적으로 따르지는 않아도 된다고 생각함. 다만, 가능하면 assert는 적게..

### 테스트 당 개념 하나
ex) 메소드를 테스트하는 장황한 코드
```
public void testAddMonths() {
  SerialDate d1 = SerialDate.createInstance(31, 5, 2004);
  
  SerialDate d2 = SerialDate.addMonths(1, d1);
  assertEquals(30, d2.getDayOfMonth());
  assertEquals(6, d2.getMonth());
  assertEquals(2004, d2.getYYYY());
  
  SerialDate d3 = SerialDate.addMonths(2, d1);
  assertEquals(31, d3.getDayOfMonth());
  assertEquals(7, d3.getMonth());
  assertEquals(2004, d3.getYYYY());
  
  SerialDate d4 = SerialDate.addMonths(1, SerialDate.addMonths(1, d1));
  assertEquals(30, d4.getDayOfMonth());
  assertEquals(7, d4.getMonth());
  assertEquals(2004, d4.getYYYY());
}
```

-> 이 테스트코드의 문제는 테스트케이스가 여러개가 있는것이 아니다. 문제는 한 테스트코드에서 여러가지의 개념을 테스트한다는 사실이다.


## F.I.R.S.T.
### 깨끗한 테스트의 다섯가지 규칙

### 빠르게(Fast)
#### 테스트는 빨라야한다. 빨라서 자주 돌릴 수 있어야한다.

### 독립적으로(Indepentent)
#### 테스트는 서로 의존하면 안된다. 만약 테스트가 서로 의존하고 있다면, 한 테스트의 오류를 찾기위해 다른 테스트도 뒤져야한다. 원인 찾기가 너무 힘들어진다.

### 반복가능하게(Repeatable) 
#### 테스트는 어떤 환경에서도 반복 가능해야 한다. 실제 환경, QA 환경, 심지어 네트워크가 안되는 환경에서도 테스트가 가능해야한다.

### 자가검증하는(Self-Validating)
#### 테스트의 결과는 Bool이다. 로그따위를 써서는 안된다.

### 적시에(Timely)
#### 테스트는 적시에 작성해야한다. 단위테스트는 테스트하려는 실제 코드를 구현하기 직전에 구현한다. 만일 반대의 순서로 작성을 하게된다면, 테스트코드를 작성하면서 이코드는 테스트코드를 작성하기 힘들구나 라고 생각하는 상황이 올 수 있다. 최악의 경우 테스트가 불가능 할 수 있다.





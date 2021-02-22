
# 함수 
함수의 길이는 짧게, 이름은 분명하게 작성하여 체계잡힌 함수를 기반으로 시스템이라는 이야기를 풀어나가라

## 1. 작게 만들어라

함수를 만드는 첫째 규칙은 "작게!" 이고, 두번째 규칙은 "더 작게!"이다.

### example 1-1
```
//페이지 렌더링을 위한 간단한 test 함수
public static String testPageRender(PageData pageData) throws Exception{
  boolean isTestPage = pageData.hasAttribute("test");
  if(isTestPage){
    TestPage testPage = pageData.getTestPage(); 
    StringBuffer newPageContent = new StringBuffer(); 
    getTestPageList(testPage, pageData);
    newPageContent.append(pageData.getContent());
    includeTeardownPage(testPage, newPageContent);
    pageData.setContent(newPageContent.toString());
  }
  return pageData.getHtml();
}
```

### example 1-2
```
//
public static String testPageRender(PageData pageData) throws Exception{
  if(isTestPage(pageData))
    getTestPageListAndincludeTeardownPage(pageData)
  return loginData.getHtml();
}
```

## 2. 한가지만 해라

함수는 한 가지의 기능을 해야한다. 그 한 가지를 잘 해야한다. 그 한가지만을 해야한다.


## 3. 함수 당 추상화 수준은 하나로

함수가 확실하게 '한 가지' 작업만 하려면 함수 내 모든 문장의 추상화 수준이 동일해야 한다. 
[참고] - https://sosimhan-dev.tistory.com/4


## 4. Switch 문

함수는 한가지의 기능을 수행하도록 작성하도록 하지만, switch문은 본질적으로 여러가지의 일을 처리하기에 되도록 지양한다. if/else 가 여럿 이어지는 구문도 마찬가지다.

### example 4-1
```
public static String calculatePay(Employee e) throws Exception{
  switch(e.type) {
	  case COMMISSIONED :
		  return calculateCommissionedPay(e);
		case HOURLY :
		  return calculateHourlyPay(e);
    case SALARIED :
		  return calculateSalariedPay(e);
		default :
			throw ne Exception(subcode);
}
```
위 예제는 유형이 늘어날수록 코드가 길어질 뿐더러, 한가지 작업만 수행하지도 않는다. switch문은 다형적 객체를 생성하는 코드에서만 쓰고 웬만해서는 사용하지 말자


## 5. 서술적인 이름을 사용하라

함수의 이름을 붙일때는 길어도 상관없으니, 일관성 있게 쉽게 읽히는 단어를 사용하여 함수 기능을 잘 표현하는 이름을 선택하라.

### example 5-1
```
//게시글 리스트 조회 기능
public static String processBoardList(Board board) throws Exception{
  ...
}
//게시글 등록 기능
public static String processBoardInsert(Board board) throws Exception{
  ...
}
//게시글 수정 기능
public static String processBoardUpdate(Board board) throws Exception{
  ...
}
//게시글 삭제 기능
public static String processBoardDelete(Board board) throws Exception{
  ...
}
```

## 6. 함수 인수

함수에서 이상적인 인수 개수는 0개(무항)이다. 최선은 입력 인수가 없는 경우이고, 차선은 입력인수가 1개뿐인 경우이다. 인수가 많을수록 테스트도 힘들다.


## 7. 부수 효과를 일으키지 마라

함수에 남몰래 원래의 목적과 다르게 또다른 기능을 넣거나, 변수 수정등을 하는것을 지양하라.


## 8. 오류 코드보다 예외를 사용하라

오류 코드 대신 예외를 사용하면 오류 처리 코드가 원래 코드에서 분리되므로 코드가 깔끔해진다. try/catch 는 코드 구조에 혼란을 일으킬수 있으므로 별도 함수로 처리하는 것이 좋다.


## 9. 반복하지 마라

중복을 없애라. 중복은 코드길이를 늘릴뿐 아니라 알고리즘이 바뀌면 그만큼의 수정이 필요하다.


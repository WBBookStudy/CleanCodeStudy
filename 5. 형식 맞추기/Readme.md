
# 형식 맞추기
프로그래머라면 형식을 깔끔하게 맞춰 코드를 짜야 한다. 코드 형식을 맞추기 위한 간단한 규칙을 정하고 그 규칙을 착실히 따라야 한다.

## 1. 형식을 맞추는 목적

코드 형식은 의사소통의 일환이다. 맨처음 잡아놓은 구현 스타일과 가독성 수준은 유지보수 용이성과 확장성에 계속 영향을 미친다.  


## 2. 적절한 행 길이를 유지하라

적은 줄의 파일로도 커다란 시스템을 구축할수 있다. 반드시 지킬 엄격한 규칙은 아니지만 바람직한 규칙으로 삼아라. 일반적으로 큰 파일보다 작은 파일이 이해하기 쉽다.  

### 2-1. 신문 기사처럼 작성하라

이름은 간단하면서도 설명이 가능하게 짓는다. 이름만 보고도 올바른 모듈을 살펴보고 있는지 아닌지를 판단할 정도로 신경써서 짓고, 소스파일 첫 부분은 고차원 개념과 알고리즘을 설명한다. 아래로 내려갈수록 의도를 세세하게 묘사한다. 마지막에는 가장 저차원 함수와 세부내역이 나온다.

### 2-2. 개념은 빈 행으로 분리하라

빈 행은 새로운 개념을 시작한다는 시각적 단서다. 코드를 읽어 내려가다 보면 빈 행 바로 다음 줄에 눈길이 멈춘다.
```
//빈 행으로 분리시 가독성이 좋다
package fitnesse.wikitext.widgets;

import java.util.regex.*;

public class BoldWidget extends ParentWidget{
  public static final String REGEXP = "'''.+?'''"
  
  pravate static final Pattern pattern = Pattern.compile("'''(.+?)'''", Pattern.MULTILINE + Pattern.DOTALL);
  
  public BoldWidget(ParentWidget parent, String text) throws Exception {
    super(parent);
    Matcher match = pattern.matcher(text);
    match.find();
    addChildWidgets(match.group(1));
  }
  
  public String render() throws Exception {
    StringBuffer html = new StringBuffer("<b>");
    html.append(childHtml()).append("</b>");
    return html.toString();
  }  
}


// 빈 행이 없는 경우, 가독성이 현저히 떨어진다
package fitnesse.wikitext.widgets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class BoldWidget extends ParentWidget {
	public static final String REGEXP = "'''.+?'''";
	private static final Pattern pattern = Pattern.compile("'''(.+?)'''",
		Pattern.MULTILINE + Pattern.DOTALL
	);
	public BoldWidget(ParentWidget parent, String text) throws Exception {
		super(parent);
		Matcher match = pattern.matcher(text);
		match.find();
		addChildWidgets(match.group(1));
	}
	public String render() throws Exception {
		StringBuffer html = new StringBuffer("<b>");
		html.append(childHtml()).append("</b>");
	    return html.toString();
	}
}

```


### 2-3. 세로 밀집도

세로 밀집도는 연관성을 의미한다. 서로 밀접한 코드행은 세로로 가까이 놓여야 한다.
```
//주석으로 두 인스턴스 변수를 떨어뜨려 놓음
public class ReporterConfig {
    /**
     * 리포터 리스너의 클래스 이름
    */
    private String m_className;						//인스턴스 변수 1

    /**
     * 리포터 리스너의 속성
    */
    private List<Property> m_properties = new ArrayList<Property>();	//인스턴스 변수 2
    public void addProperty(Property property) {
        m_properties.add(property);
}

//두 인스턴스 변수를 밀접하게 배치
public class ReporterConfig {
    private String m_className;						//인스턴스 변수 1
    private List<Property> m_properties = new ArrayList<Property>();	//인스턴스 변수 2

    public void addProperty(Property property) {
        m_properties.add(property);
}
```



### 2-4. 수직 거리

같은 파일에 속할 정도로 밀접한 개념은 세로거리로 연관성을 표현한다. 여기서 연관성이란 한 개념을 이해하는데 다른 개념이 중요한 정도다.
연관성이 깊은 두 개념이 멀리 떨어져 있으면 코드를 읽는 사람이 소스 파일과 클래스를 여기저기 뒤지게 된다.

#### 2-4-1. 변수선언

변수는 사용하는 위치에 최대한 가까이 선언한다. 지역 변수같은 경우 각 함수 맨 처음에 선언한다.
```
private static void readPreferences() {
      InputStream is = null;		//지역변수는 각 함수 맨 처음에 선언한다.
      
      try {
          is = new FileInputStream(getPreferencesFile());
          setPreferences(new Properties(getPreferences()));
          getPreferences().load(is);
      } catch (IOException e) {
          try {
              if (is != null)
                  is.close();
          } catch (IOException e1) {
          }
      }
  }
```


#### 2-4-2. 인스턴스 변수

자바에서는 인스턴스 변수는 클래스 맨 처음에 선언한다. 인스턴스 변수 간에 세로로 거리를 두지 않는다
일반적으로 C++에서는 모든 인스턴스 변수를 클래스 마지막에 선언하는 가위 규칙(scissors rule)을 적용하지만, 
중요한 건 잘 알려진 위치에 인스턴스 변수를 모아놓아야 하며 변수 선언을 어디서 찾을지 모두가 알고 있어야 한다.

#### 2-4-3. 종속 함수
한 함수가 다른 함수를 호출할 경우 두 함수는 세로로 가까이 배치하며 호출하는 함수를 호출되는 함수보다 먼저 배치한다.
규칙적으로 함수를 배치하면 호출되는 함수를 찾기 쉬워지며 그만큼 모듈 전체의 가독성도 높아진다.
```
public class WikiPageResponder implements SecureResponder {
  protected WikiPage page;
  protected PageData pageData;
  protected String pageTitle;
  protected Request request;
  protected PageCrawler crawler;

  public Response makeResponse(FitNesseContext context, Request request)
    throws Exception {
    String pageName = getPageNameOrDefault(request, "FrontPage");  //getPageNameOrdefault 함수를 첫번쨰로 호출
    loadPage(pageName, context);				   //loadPage 함수를 두번쨰로 호출
    if (page == null)						   //결과에 따라 notFoundResponse 혹은 makePageResponse 함수를 순차적으로 호출
      return notFoundResponse(context, request);			
    else
      return makePageResponse(context);
  }

  private String getPageNameOrDefault(Request request, String defaultPageName)		//첫번째로 getPageNameOrdefault 함수 정의
  {
    String pageName = request.getResource();
    if (StringUtil.isBlank(pageName))
      pageName = defaultPageName;

    return pageName;
  }

  protected void loadPage(String resource, FitNesseContext context)			//두번째로 loadPage 함수 정의
    throws Exception {
    WikiPagePath path = PathParser.parse(resource);
    crawler = context.root.getPageCrawler();
    crawler.setDeadEndStrategy(new VirtualEnabledPageCrawler());
    page = crawler.getPage(context.root, path);
    if (page != null)
      pageData = page.getData();
  }

  private Response notFoundResponse(FitNesseContext context, Request request)		//세번째로 notFoundResponse 함수 정의
    throws Exception {
    return new NotFoundResponder().makeResponse(context, request);
  }

  private SimpleResponse makePageResponse(FitNesseContext context)			//네번째로 makePageResponse 함수 정의
    throws Exception {
    pageTitle = PathParser.render(crawler.getFullPath(page));
    String html = makeHtml(context);

    SimpleResponse response = new SimpleResponse();
    response.setMaxAge(0);
    response.setContent(html);
    return response;
  }
}
```

#### 2-4-4. 개념적 유사성

개념적인 친화도가 높을수록 코드를 가까이 배치한다. 친화도가 높은 요인은 여러가지인데 앞서 본 함 함수가 다른 함수를 호출해 생기는 직접적인 종속성이 한 예다.
변수와 그 변수를 사용하는 함수도 한 예다. 비슷한 동작을 수행하는 일군의 함수또한 좋은 예이다.
```
public class Assert {
    static public void assertTrue(String message, boolean condition) {
        if (!condition)
            fail(message);
    }
    
    static public void assertTrue(boolean condition) {
        assertTrue(null, condition);
    }
    static public void assertFalse(String message, boolean condition) {
        assertTrue(message, !condition);
    }
    static public void assertFalse(boolean condition) {
        assertFalse(null, condition);
    }
}
```

## 3. 가로 형식 맞추기

요즘 모니터가 커져 보여지는 길이가 길어졌지만, 프로그래머는 평균적으로 짧은 행을 선호한다. 길게 작성한 코드여도 최대 120자 정도의 행 길이로 제한하는것을 지향한다.

### 3-1. 가로 공백과 밀집도

가로 공백을 사용해 밀접한 개념과 느슨한 개념을 표현한다. 함수 이름과 이어지는 괄호 사이에는 공백 넣지 않는다. 함수를 호출하는 코드에서 괄호 안 인수는 공백으로 분리한다.
```
private void measureLine(String line) {
    lineCount++;
    int lineSize = line.length();
    totalChars += lineSize;				//할당 연산자를 강조하기 위해 앞뒤로 공백을 준다
    lineWidthHistogram.addLine(lineSize, lineCount);	//함수 호출하는 코드에서 괄호 안 인수는 공백으로 분리
    recordWidestLine(lineSize);				//일반적으로 함수이름과 이어지는 괄호사이에는 공백을 주지 않는다
}
```

```
//연산자 우선순위를 강조하기 위한 공백 사용 example
public class Quadratic {
    public static double root1(double a, double b, double c) {
        double determinant = determinant(a, b, c);	
        return (-b + Math.sqrt(determinant)) / (2*a);		//승수사이에는 공백이 없지만 항 사이에는 공백이 들어간다.
    }
    
    public static double root2(int a, int b, int c) {
        double determinant = determinant(a, b, c);
        return (-b - Math.sqrt(determinant)) / (2*a);
    }
    
    private static double determinant(double a, double b, double c) {
        return b*b - 4*a*c;
    }
    
    //개인적인 의견으로 항과 항사이는 우선순위 적으로 공백으로 분리하는게 맞고 승수에 공백이 없다기보단 곱셈or나눗셈 부분은 공백이 없고 덧셈이나 뺄셈에는 공백이 들어가는게 맞는거 같음...
}
```


### 3-2. 가로 정렬
#### 3-2 Example1
```
//가로정렬을 시킨 example
public class FitNesseExpediter implements ResponseSender {
  private Socket          socket;
  private InputStream     input;
  private OutputStream    output;
  private Request         request;
  private Response        response;
  private FitNesseContext context;
  private ExecutorService executorService;
  private long            requestParsingTimeLimit;
  private long            requestProgress;
  private long            requestParsingDeadline;
  private boolean         hasError;
    
  public FitNesseExpediter(Socket 	   s, 
  			   FitNesseContext context) throws IOException {
    this.context =                 context;
    this.socket =                  s;
    input =                        s.getInputStream();
    output =                       s.getOutputStream();
    this.requestParsingTimeLimit = 10000;
  }
}
```
위 예제와 같이 정렬을 할 때 여러 단점이 있다.
+ 코드가 엉뚱한 부분을 강조해 진짜 의도가 가려진다.
+ 변수 유형보다 변수 이름부터 읽게 된다.
+ 할당 연산자는 안 보이고 오른쪽 피연산자에 집중되게 된다
+ 코드 형식을 자동으로 맞춰주는 도구는 위의 정렬을 무시한다
+ 위와 같이 코드 선언부가 길면 클래스를 쪼개야 한다

위와 같은 이유로 아래와 같이 정렬을 하지않음으로 오히려 중대한 결함을 찾기 쉬워진다.
#### 3-2 Example2
```
//가로정렬을 하지않은 example
public class FitNesseExpediter implements ResponseSender {
  private Socket socket;
  private InputStream input;
  private OutputStream output;
  private Request request;
  private Response response;
  private FitNesseContext context;
  private ExecutorService executorService;
  private long requestParsingTimeLimit;
  private long requestProgress;
  private long requestParsingDeadline;
  private boolean hasError;
    
  public FitNesseExpediter(Socket s, FitNesseContext context) throws IOException {
    this.context = context;
    this.socket = s;
    input = s.getInputStream();
    output = s.getOutputStream();
    this.requestParsingTimeLimit = 10000;
  }
}
```

### 3-3. 들여쓰기

범위로 이뤄진 계층을 표현하기 위해 코드를 들여쓴다. 들여쓰기한 코드의 경우 구조가 한눈에 들어온다.
주의할점은
+ 파일 수준인 문장은 들여쓰지 않는다(클래스)
+ 메서드는 클래스보다 한 수준 들여쓴다
+ 메서드 코드는 메서드 선언보다 한 수준 들여쓴다
+ 블록 코드는 블록을 포함하는 코드보다 한 수준 들여쓴다

때로는 간단한 if문, 짧은 while문, 짧은 함수에서 들여쓰기를 무시하고 싶기도 하다.
하지만 이런 경우에도 들여쓰기를 하는것을 지향하자.
```
//들여쓰기를 무시한 경우
public class CommentWidget extends TextWidget {
    public static final String REGEXP = "^#[^\r\n]*(?:(?:\r\n)|\n|\r)?";
    
    public CommentWidget(ParentWidget parent, String text) {super(parent, text);}
    public String render() throws Exception {return "";}
}

//들여쓰기를 적용한 경우
public class CommentWidget extends TextWidget {
    public static final String REGEXP = "^#[^\r\n]*(?:(?:\r\n)|\n|\r)?";
    
    public CommentWidget(ParentWidget parent, String text) {
        super(parent, text);
    }
    
    public String render() throws Exception {
        return "";
    }
}
```
#### 3-3-1. 가짜범위

때로는 빈 while문이나 빈 for문을 접한다. body가 없는 while문은 세미콜론을 새 행에다 들여쓰자.
```
while(dis.read(buf, 0, readBufferSize) != -1)
;
//이부분은 정확히 어떤 의미인지 모르겠다...
```

## 4. 팀 규칙

프로그래머라면 각자 선호하는 규칙이 있다. 하지만 팀에 속한다면 자신이 선호해야 할 규칙은 바로 팀 규칙이다.
팀은 한가지 규칙에 합의하고, 모든 팀원은 그 규칙을 따르는것을 지향하자.
개개인이 마음대로 짜대는 코드는 피해야한다. 좋은 시스템은 읽기 쉬운 문서로, 스타일은 일관적이고 매끄러워야 한다.

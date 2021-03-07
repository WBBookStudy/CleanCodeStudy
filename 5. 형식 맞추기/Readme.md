
# 형식 맞추기
프로그래머라면 형식을 깔끔하게 맞춰 코드를 짜야 한다. 코드 형식을 맞추기 위한 간단한 규칙을 정하고 그 규칙을 착실히 따라야 한다.

## 1. 형식을 맞추는 목적

코드 형식은 의사소통의 일환이다. 맨처음 잡아놓은 구현 스타일과 가독성 수준은 유지보수 용이성과 확장성에 계속 영향을 미친다.  
  
## 2. 적절한 행 길이를 유지하라

적은 줄의 파일로도 커다란 시스템을 구축할수 있다. 반드시 지킬 엄격한 규칙은 아니지만 바람직한 규칙으로 삼아라. 일반적으로 큰 파일보다 작은 파일이 이해하기 쉽다.  

### 2-1. 신문 기사처럼 작성하라

이름은 간단하면서도 설명이 가능하게 짓는다. 이름만 보고도 올바른 모듈을 살펴보고 있는지 아닌지를 판단할 정도로 신경써서 짓고, 소스파일 첫 부분은 고차원 개념과 알고리즘을 설명한다.
아래로 내려갈수록 의도를 세세하게 묘사한다. 마지막에는 가장 저차원 함수와 세부내역이 나온다.

### 2-2. 개념은 빈 행으로 분리하라

빈 행은 새로운 개념을 시작한다는 시각적 단서다. 코드를 읽어 내려가다 보면 빈 행 바로 다음 줄에 눈길이 멈춘다.

### example 2-2
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

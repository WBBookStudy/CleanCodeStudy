# 창발성(創發性)

## 소프트웨어 설계 품질을 크게 높여준다고 믿어지는 켄트 벡이 제시한 단순한 설계 규칙 네가지
1. 모든 테스트를 실행한다.
2. 중복을 없앤다.
3. 프로그래머 의도를 표현한다.
4. 클래스와 메서드 수를 최소로 줄인다.

위 목록의 순서는 중요도 순이고, 네가지 규칙을 따르면 코드 구조와 설계를 파악하기 쉬워져 SRP([single responsibility principle:단일책임원칙](https://ko.wikipedia.org/wiki/%EB%8B%A8%EC%9D%BC_%EC%B1%85%EC%9E%84_%EC%9B%90%EC%B9%99)), 
DIP([dependency inversion principle:의존 관계 역전 원칙](https://ko.wikipedia.org/wiki/%EC%9D%98%EC%A1%B4%EA%B4%80%EA%B3%84_%EC%97%AD%EC%A0%84_%EC%9B%90%EC%B9%99)) 와 같은 원칙을 적용하기 쉬워지며 우수한 설계의 창발성을 촉진시킬 수 있다.

## 1. 단순한 설계 규칙 1 - 모든 테스트를 실행한다.
테스트가 가능한 시스템을 만들려고 하면 설계 품질이 더불어 높아진다.
테스트 케이스를 많이 작성할수록 개발자는 DIP와 같은 원칙을 적용하고, 의존성 주입, 인터페이스, 추상화 등과 같은 도구를 사용해 결합도를 낮춘다.
테스트가 가능한 시스템을 만들려는 노력은 결국, 낮은 결합도와 높은 응집력이라는 결과를 낳고 이것은 객체 지향 방법론이 지향하는 목표를 자연스럽게 달성하게 된다.

## 2. 단순한 설계 규칙 2~4: 리팩터링
테스트 코드를 모두 작성하면 코드와 클래스를 정리할 수 있어진다.
구체적으로 코드를 점진적으로 리팩터링 해나간다.
1. 코드를 추가하고
2. 추가한 코드가 설계 품질을 낮추는지 확인한 후
3. 품질을 낮춘다면 깔끔히 정리한 후 테스트 케이스를 돌려 기존 기능을 깨트리지 않았다는 사실을 확인한다.

코드를 정리하면서 시스템이 깨질까 걱정할 필요가 없다. 테스트 케이스가 있으니까.
리팩터링 단계에서는 품질을 높이는 기법이라면 무엇이든 적용해도 괜찮다.
1. 응집도를 높이고
2. 결합도를 낮추고
3. 관심사를 분리하고
4. 시스템 관심사를 모듈로 나누고
5. 함수와 클래스 크기를 줄이고
6. 더 나은 이름을 선택하고
이러한 다양한 기법을 동원한다.

## 3. 중복을 없애라
우수한 설계에서 중복은 커다란 적이다. 중복은 추가작업, 추가 위험, 불필요한 복잡도를 뜻한다.
### 3-1. 중복 sample
집합 클래스에 다음 메서드가 있다고 가정할시
```
int size(){}  //개수를 반환
boolean isEmpty(){}  //부울값을 반환
```
아래와 같이 중복구현을 줄일수 있다.
```
boolean isEmpty(){
    return 0 == size();
}
```
### 3-2. 중복 sample
```
public void scaleToOneDimension(float desiredDimension, float imageDimension) {
  if (Math.abs(desiredDimension - imageDimension) < errorThreshold)
    return;
  float scalingFactor = desiredDimension / imageDimension;
  scalingFactor = (float)(Math.floor(scalingFactor * 100) * 0.01f);
  
  RenderedOpnewImage = ImageUtilities.getScaledImage(image, scalingFactor, scalingFactor);
  image.dispose();
  System.gc();
  image = newImage;
}

public synchronized void rotate(int degrees) {
  RenderedOpnewImage = ImageUtilities.getRotatedImage(image, degrees);
  image.dispose();
  System.gc();
  image = newImage;
}
```
scaleToOneDimension 메서드와 rotate 메서드에는 동일한 코드가 일부 존재한다. 아래와 같이 코드를 정리해 중복을 제거한다
```
public void scaleToOneDimension(float desiredDimension, float imageDimension) {
  if (Math.abs(desiredDimension - imageDimension) < errorThreshold)
    return;
  float scalingFactor = desiredDimension / imageDimension;
  scalingFactor = (float) Math.floor(scalingFactor * 10) * 0.01f);
  replaceImage(ImageUtilities.getScaledImage(image, scalingFactor, scalingFactor));
}

public synchronized void rotate(int degrees) {
  replaceImage(ImageUtilities.getRotatedImage(image, degrees));
}

private void replaceImage(RenderedOp newImage) {  //공통 부분을 새로운 매서드로 만들고 보니 SRP를 위반한다. 새로운 클래스로 옮겨도 좋다.
  image.dispose();
  System.gc();
  image = newImage;
}
```
### 3-3. 중복 sample
Templete Method 패턴(고차원 중복을 제거할 목적으로 사용하는 기법) 
 - 어떤 작업을 처리하는 일부분을 서브 클래스로 캡슐화해 전체 일을 수행하는 구조는 바꾸지 않으면서 특정 단계에서 수행하는 내역을 바꾸는 패턴. 즉, 전체적으로는 동일하면서 부분적으로는 다른 구문으로 구성된 메서드의 코드 중복을 최소화 할 때 유용하다.
```
public class VacationPolicy {
  public void accrueUSDDivisionVacation() {
    // 지금까지 근무한 시간을 바탕으로 휴가 일수를 계산하는 코드
    // ...
    // 휴가 일수가 미국 최소 법정 일수를 만족하는지 확인하는 코드
    // ...
    // 휴가 일수를 급여 대장에 적용하는 코드
    // ...
  }
  
  public void accrueEUDivisionVacation() {
    // 지금까지 근무한 시간을 바탕으로 휴가 일수를 계산하는 코드
    // ...
    // 휴가 일수가 유럽연합 최소 법정 일수를 만족하는지 확인하는 코드
    // ...
    // 휴가 일수를 급여 대장에 적용하는 코드
    // ...
  }
}
```
최소 법정 일수를 계산하는 코드를 제외하면 두 메서드는 거의 동일하기 때문에, template method 패턴을 적용해 중복을 제거할 수 있다.
```
abstract public class VacationPolicy {
  public void accrueVacation() {
    caculateBseVacationHours();
    alterForLegalMinimums();
    applyToPayroll();
  }
  
  private void calculateBaseVacationHours() { /* ... */ };
  abstract protected void alterForLegalMinimums();
  private void applyToPayroll() { /* ... */ };
}

public class USVacationPolicy extends VacationPolicy {
  @Override protected void alterForLegalMinimums() {
    // 미국 최소 법정 일수를 사용한다.
  }
}

public class EUVacationPolicy extends VacationPolicy {
  @Override protected void alterForLegalMinimums() {
    // 유럽연합 최소 법정 일수를 사용한다.
  }
}
```
하위 클래스에서 method를 구현하여 각각의 중복되지 않는 정보(기능)을 채운다.

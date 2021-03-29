# 오류처리
깨끗한 코드와 오류 처리는 확실히 연관성이 있다. 오류 처리는 중요하지만 오류 처리 코드로 인해 프로그램 논리를 이해하기 어려워 진다면 깨끗한 코드라 부르기 어렵다.

## 1. 오류 코드보다 예외를 사용하라
오류코드를 사용할시 코드가 복잡해진다. 함수를 호출한 즉시 오류를 확인해야 하기 때문이다.
예외처리를 할시 코드도 더 깔끔해지고 논리가 오류처리 코드와 뒤섞이지 않게 된다.

### 1-1. 오류코드 sample
```
public class DeviceController {
	...
	public void sendShutDown() {
		DeviceHandle handle = getHandle(DEV1);
		// 디바이스 상태를 점검한다
		if (handle != DeviceHandle.INVALID) {
			// 레코드 필드에 디바이스 상태를 저장한다
			retrieveDeviceRecord(handle);
			// 디바이스가 일시정지 상태가 아니라면 종료한다.
			if (record.getStatus() != DEVICE_SUSPENDED) {
				pauseDevice(handle);
				clearDeviceWorkQueue(handle);
				closeDevice(handle);
			} else {
				logger.log("Device suspended. Unable to shut down");
			}
		} else {
			logger.log("Invalid handle for: " + DEV1.toString());
		}
	}
	...
}

```

### 1-2. 예외처리 sample
```
public class DeviceController {
	...
	public void sendShutDown() {
		try {
			tryToShutDown();
		} catch (DeviceShutDownError e) {
			logger.log(e);
		}
	}
	
	private void tryToShutDown() throws DeviceShutDownError {
		DeviceHandle handle = getHandle(DEV1);
		DeviceRecord record = retrieveDeviceRecord(handle);
		
		pauseDevice(handle); 
		clearDeviceWorkQueue(handle); 
		closeDevice(handle);
	}

	private DeviceHandle getHandle(DeviceID id) {
		...
		throw new DeviceShutDownError("Invalid handle for: " + id.toString());
		...
	}
	...
}

```

## 2. Try-Catch-Finally 문부터 작성하라
try 블록에 무슨일이 생기든지 catch 블록은 프로그램 상태를 일관성 있게 유지해야 한다.
그러므로 예외가 발생할 코드를 짤때는 try-catch-finally 문으로 시작하는 편이 낫다.
그러면 try블록에서 무슨 일이 생기든지 호출자가 기대하는 상태를 정의하기 쉬워진다.
먼저 강제로 예외를 일으키는 테스트 케이스를 작성한 후 테스트를 통과하게 코드를 작성하는 방법을 권장한다. 
그러면 자연스럽게 try블록의 트랜잭션 범위부터 구현하게 되므로 범위 내 트랜잭션 본질을 유지하기 쉬워진다.
```
//파일이 없으면 예외를 던지는지 알아보는 단위 테스트
@Test(expected = StorageException.class)
public void retrieveSectionShouldThrowOnInvalidFileName() {
    sectionStore.retrieveSection("invalid - file");
}
//try catch로 예외를 던지므로 테스트가 성공한다
public List<RecordedGrip> retrieveSection(String sectionName) {
    try {
        FileInputStream stream = new FileInputStream(sectionName)
    } catch (Exception e) {
        throw new StorageException("retrieval error", e);
    }
    return new ArrayList<RecordedGrip>();
}

```
그런뒤 예외 유형을 좁혀 실제 예외를 찾아내면서 리펙토링한다.
```
public List<RecordedGrip> retrieveSection(String sectionName) {
    try {
        FileInputStream stream = new FileInputStream(sectionName);
        stream.close();
    } catch (FileNotFoundException e) {
        throw new StorageException("retrieval error", e);
    }
    return new ArrayList<RecordedGrip>();
}

```

## 3. 미확인(unchecked) 예외를 사용하라
확인된 예외는 OCP(Open Closed Principle, 개방폐쇄원칙 - '소프트웨어 개체는 확장에 대해 열려 있어야 하고, 수정에 대해서는 닫혀 있어야 한다'는 프로그래밍 원칙)를 위반한다. 
하위 단계에서 코드를 변경하면 상위 단계 메서드 선언부를 전부 고쳐야 한다.
throw 경로에 위치하는 모든 함수가 최하위 함수에서 던지는 예외를 알아야 하므로 캡슐화가 깨진다.

|  | Checked Exception | UnChecked Exception |
|---|:---:|:---:|
| 확인 시점 | 컴파일 시점 | 런타임 시점 |
| 처리 여부 | 반드시 처리 | 명시적으로 처리하지 않아도 됨 |
| 트랜잭션 처리 | roll-back 하지 않음 | roll-back 함 |
| 예시 | IOException, ClassNotFoundException | NullPointerException, ArithmeticException |

## 4. 예외에 의미를 제공하라
예외에 정보를 충분히 담아서 던지면, 오류가 발생한 원인과 위치를 찾기 쉬워진다.

## 5. 호출자를 고려해 예외 클래스를 정의하라
오류를 분류할 수 있는 방법은 많다.
- 발생한 위치
- 발생한 컴포넌트
- 유형 : 네트워크 실패, 디바이스 실패, 프로그래밍 오류 등

하지만 프로그래머에게 가장 중요한 관심사는 오류를 잡아내는 방법이 되어야 한다.
외부 라이브러를 그대로 사용한 경우에는 외부 라이브러리가 던질 예외를 모두 잡아야 한다.

```
ACMEPort port = new ACMEPort(12);

try {
    port.open();
} catch (DeviceResponseException e) {
    reportPortError(e);
    logger.log("Device response exception", e);
} catch (ATM1212UnlockedException e) {
    reportPortError(e);
    logger.log("Unlock exception", e);
} catch (GMXError e) {
    reportPortError(e);
    logger.log("Device response exception");
} finally {
...
}
```
대다수 상황에서 오류를 처리하는 방식은 오류 종류와 무관하게 비교적 일정하다
1. log를 남긴다
2. 계속 수행가능한지 확인한다
위 경우에도 예외 유형과 무관하게 모두 동일했다. 이 경우 외부 라이브러리를 호출하는 API를 감싸면서 예외 유형을 하나만 던지게 수정해보자.


```
LocalPort port = new LocalPort(12);

try {
    port.open();
} catch (PortDeviceFailure e) {
    reportError(e);
    logger.log(e.getMessage(), e);
} finally {
...
}

public class LocalPort {
    private ACMEPort innerPort;

    public LocalPort(int portNumber) {
        innerPort = new ACMEPort(portNumber);
    }

    public void open() {
        try {
        innerPort.open();
        } catch (DeviceResponseException e) {
            throw new PortDeviceFailure(e);
        } catch (ATM1212UnlockedException e) {
            throw new PortDeviceFailure(e);
        } catch (GMXError e) {
            throw new PortDeviceFailure(e);
        }
    }
}
```
외부 API를 감싸는 클래스는 매우 유용하다. 외부 API와 프로그램 사이에 의존성이 크게 줄어든다.

## 6. 정상 흐름을 정의하라
catch문에서 예외를 처리하는 경우 코드가 지저분해지는 일이 발생할 수 있다.

```
try {
    MealExpenses expenses = expenseReportDAO.getMeals(employee.getID());
    //식비를 비용으로 청구시 총계에 더한다
    m_total += expenses.getTotal();
} catch(MealExpensesNotFound e) {
    //그게 아니면 일일 기본 식비를 총계에 더한다
    m_total += getMealPerDiem();
}
```
식비를 비용으로 청구했다면 그걸 더하고, 아니면 일일 기본 식비를 더하는 코드이다. 
만약 청구식비가 없으면 일일 기본 식비를 반환하도록 DAO를 수정하면 아래와 같이 간결하게 된다.
```
 public class PerDiemMealExpenses implements MealExpenses {
     public int getTotal() {
         // 기본값으로 일일 기본 식비를 반환한다.
     }
 }
```
```
 MealExpenses expenses = expenseReportDAO.getMeals(employee.getID());
 m_total += expenses.getTotal();
```
이와같은 경우를 특수사례패턴(Special Case Pattern) 이라 한다.
클래스를 만들거나 객체를 조작해 특수 사례를 처리하는 방식이다.

## 7. null을 반환하지마라
null을 반환하면 호출자가 null을 확인해야 한다. null확인 코드로 가득한 화면을 계속봐야 한다. 
이건 호출자에게 문제를 떠넘기는 행위이다.
null 대신 예외를 던지거나 특수 사례 객체(ex. Collections.emptyList())를 반환하라.
```
List<Employee> employees = getEmployees();

if (employees != null) {
    for(Employee e : employees) {
        totalPay += e.getPay();
    }
}
```
위 예의 경우 null이 아닌 빈 리스트를 반환한다면 더 깨끗해진다.
```
List<Employee> employees = getEmployees();

for(Employee e : employees) {
    totalPay += e.getPay();
}

public List<Employee> getEmployees() {
	if (..직원이 없다면..)
		return Collections.emptyList();
}
```

## 8. null을 전달하지 마라
인수로 null을 전달하면 함수 내에서 예외를 던지거나 assert 문을 사용할 수는 있다. 
하지만 NullPointException 문제를 해결해 줄 수는 없다.
애초에 null을 넘기지 못하도록 금지하는 정책이 합리적이다.

```
double xProjection(Point p1, Point p2) {
    if(p1 == null || p2 == null){
        throw InvalidArgumentException("Invalid argument for MetricsCalculator.xProjection");
    }
    return (p2.x - p1.x) * 1.5;
}
```


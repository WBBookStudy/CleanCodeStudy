# 오류처리
깨끗한 코드와 오류 처리는 확실히 연관성이 있다. 오류 처리는 중요하지만 오류 처리 코드로 인해 프로그램 논리를 이해하기 어려워 진다면 깨끗한 코드라 부르기 어렵다.

## 1. 오류 코드보다 예외를 사용하라


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

## 3. 미확인(unchecked) 예외를 사용하라

## 4. 예외에 의미를 제공하라

## 5. 호출자를 고려해 예외 클래스를 정의하라

## 6. 정상 흐름을 정의하라

## 7. null을 반환하지마라

## 8. null을 전달하지 마라

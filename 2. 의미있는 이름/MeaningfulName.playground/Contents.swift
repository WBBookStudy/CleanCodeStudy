import UIKit

/*의미 있는 이름*/

//MARK: 의도를 분명히 밝혀라 Example

//example 1
func addFunc(t: Int, v1: String, v2: String, flag: Bool) -> String {
    var middle: String = ""
    if flag {
        middle = " "
    }
    if t == 0 {
        return v1 + middle + v2
    }
    else if t == 1 {
        return v1 + middle + v2 + "!"
    }
    else {
        return v1 + middle + v2 + "?"
    }
}

//example 2
enum appendedChar: Int {
    case none
    case questionMark
    case exclamationMark
}

func getAppendString(type: appendedChar, origin: String, appended: String, isAddBlank: Bool) -> String {
    var blank: String = ""
    if isAddBlank {
        blank = " "
    }
    var resultStr: String = origin + blank + appended
    switch type {
    case .none:
        break
    case .questionMark:
        resultStr = resultStr + "?"
        break
    case .exclamationMark:
        resultStr = resultStr + "!"
        break
    }
    return resultStr
}

print("test1:\(addFunc(t: 1, v1: "hi", v2: "hello", flag: true))")
print("test2:\(getAppendString(type: .questionMark, origin: "hello", appended: "there", isAddBlank: true))")

//MARK: 그릇된 정보를 피하라 Example

//example 1
func signVC(vcJson: String) -> String {
    //sign somthing
    return "signed credential"
}

func presentWithAnimationVC(vc: UIViewController, completion: (() -> ())?) {
    // with animation present
    completion?()
}

//example 2
func signVerifiableCredential(jsonCredential: String) -> String {
    //sign somthing
    return "signed credential"
}

//MARK: 의미있게 구분하라
//파라미터의 이름을 의미있게 만들자. param1, param2같은 의미없는 이름은 지양하도록

//MARK: 발음하기 쉬운 이름을 사용하라
//example
class DtaRcrd102 {
    private var genymdhms: Date? = nil
}

class Customer {
    private var generationTimeStamp: Date? = nil
}

//MARK: 검색하기 쉬운 이름을 사용하라

//MARK: 인코딩을 피하라
// 헝가리식 표기법을 고집할 필요는 없음. m_ b_ 와 같은 변수의 타입을 표기할 필요까지는 없다. 옜날방법

//MARK: 자신의 기억력을 자랑하지 마라
// 아무 의미 없이 변수의 이름을 연장하지 말라는 뜻인듯.. a와 b를 사용했으니 다음은 c?? 이런식

//MARK: 클래스의 이름
//클래스의 이름은 명사형이 좋다.

//MARK: 메서드의 이름
//메서드의 이름은 동사형이 좋다. 필요에 따라서 접두어 get, set , is와 같은 것을 붙혀도 좋다.

//example

func userName(dbTableName: String, id: Int) -> String {
    //DB에서 특정table에 있는 key값에 해당하는 유저의 이름을 가져온다
    return "userName"
}

func getUserNameFromDB(dbTableName: String, id: Int) -> String {
    //DB에서 특정table에 있는 key값에 해당하는 유저의 이름을 가져온다
    return "userName"
}

//MARK: 기발한 이름은 피하라
//본인만 아는 단어로 이름을 만들지 말아라. 일반적으로 개발자들이 사용하는 방식으로 명명을 해라.

//MARK: 한 개념에 한 단어를 사용하라
//추상적인 개념 하나에 단어 하나를 선택해 통일해서 써야한다. 동일한 동작을 하면서 클래스마다 fetch, get등으로 바꿔가면서 명명해서는 안된다.

//MARK: 말장난을 하지 마라
//한 단어를 두 가지 목적으로 사용해서는 안된다. 예를들면 insert와 append의 개념을 가진 다른 두개의 함수의 이름을 add로 동일하게 만들어서는 안된다.

//MARK: 해법 영역에서 가져온 이름을 사용하라
//MARK: 문제 영역에서 가져온 이름을 사용하라
// -> 이거 두개는 무슨소린지 잘 모르겠음.

//MARK: 의미있는 맥락을 추가하라
//위에 작성해놓은 getAppendString 함수를 본다면 isAddBlank의 용도로 생각 할 수 있을듯.



![header](https://capsule-render.vercel.app/api?type=waving&color=0:4FDEB0,100:01C1F8&height=300&section=header&text=SPARKLE&fontSize=90&fontColor=FFFFFF&animation=twinkling&desc=iOS-United&descAlignY=70)

# 프로젝트 설명
반복되는 데이트 속 연인과의 설렘과 짜릿함을 되찾아줄
우리 둘만의 불꽃, SPARKLE

# UNI iOS Developers
![IMG_7613](https://github.com/U-is-Ni-in-Korea/iOS-United/assets/128811092/bb61e667-cde1-4c95-87f7-67b22a69b134)

|박익범|김사랑|류창휘|홍유정|
|------|---|---|---|
|<a href="https://github.com/parkikbum"><img src="https://img.shields.io/badge/github-000000?style=flat-square&logo=Github&logoColor=white"/></a>|<a href="https://github.com/sarang3009"><img src="https://img.shields.io/badge/github-000000?style=flat-square&logo=Github&logoColor=white"/></a>|<a href="https://github.com/ryuchanghwi"><img src="https://img.shields.io/badge/github-000000?style=flat-square&logo=Github&logoColor=white"/></a>|<a href="https://github.com/hyj422"><img src="https://img.shields.io/badge/github-000000?style=flat-square&logo=Github&logoColor=white"/></a>|

# GitFlow
## branch

### main

<aside>
🤚 버저닝 해서 배포가 된 브랜치

</aside>

### develop

<aside>
🤚 feature 별로 나눈 브랜치가 합쳐지는 브랜치

</aside>

### feature

<aside>
🤚 구현할(수정할) 이슈를 만들고 작업을 진행할 브랜치

</aside>

![Untitled](https://github.com/GGumPiece/GGumPiece_iOS/assets/73978827/6a90c619-6e0d-471f-80c7-0f8e072b791d)

# Branch naming

```swift
작업종류_이슈넘버_(내이름)

feat_{issuenumber}_park
refactor_{issuenumber}_ryu
fix_{issuenumber}_hong
```

<aside>

	🤚 `feat`
UI작업이나 기능작업을 포함한 신규 구현 관련된 작업시의 브랜치 분기

</aside>

<aside>

	🤚 `refactor`
기능의 변경 없이 앱의 구조 개선이나, 코드 개선작업시의 브랜치 분기

</aside>

<aside>

	🤚 `fix`
bug수정과 관련된 작업 진행시 
브랜치 분기

</aside>

# commit message

```swift
🔨[FIX] : 버그, 오류 해결
➕[ADD] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시
✨[FEAT] : 새로운 기능 구현
✅[CHORE] : 코드 수정, 내부 파일 수정
⚰️[DEL] : 쓸모없는 파일,코드 삭제
♻️[REFACTOR] : 전면 수정이 있을 때 사용합니다
🔀[MERGE]: 다른브렌치를 merge 할 때 사용합니다.
```

# 코드 컨벤션

<details>
<summary> 🍎 네이밍 </summary>
<div markdown="1">

### 💧클래스, 구조체

- **UpperCamelCase** 사용

```swift
// - example

struct MyTicketResponseDTO {
}

class UserInfo {
}
```

### 💧함수

- **lowerCamelCase** 사용하고 동사로 시작

```swift
// - example

private func setDataBind() {
}
```

### 💧**뷰 전환**

- pop, push, present, dismiss
- 동사 + To + 목적지 뷰 (다음에 보일 뷰)
- dismiss는 dismiss + 현재 뷰

```swift
// - example pop, push, present

popToFirstViewController()
pushToFirstViewController()
presentToFirstViewController()

dismissFirstViewController()
```

### 💧**register**

- register + 목적어

```swift
// - example

registerXib()
registerCell()
```

### 💧서버 통신

- 서비스함수명 + WithAPI

```swift
// - example

fetchListWithAPI()

requestListWithAPI()
```

fetch는 무조건 성공

request는 실패할 수도 있는 요청

### 💧애니메이션

- 동사원형 + 목적어 + WithAnimation

```swift
showButtonsWithAnimation()
```

### 💧**델리게이트**

delegate 메서드는 프로토콜명으로 네임스페이스를 구분

**좋은 예:**

```swift
protocol UserCellDelegate {
  func userCellDidSetProfileImage(_ cell: UserCell)
  func userCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}

protocol UITableViewDelegate {
    func tableview( ....) 
    func tableview...
}

protocol JunhoViewDelegate {
    func junhoViewTouched()
    func junhoViewScrolled()
}
```

Delegate 앞쪽에 있는 단어를 중심으로 메서드 네이밍하기

**나쁜 예:**

```swift
protocol UserCellDelegate {
    // userCellDidSetProfileImage() 가 옳음
  func didSetProfileImage()
  func followPressed(user: User)

  // `UserCell`이라는 클래스가 존재할 경우 컴파일 에러 발생  (userCell 로 해주자)
  func UserCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}
```

함수 이름 앞에는 되도록이면 `get` 을 붙이지 않습니다.

### 💧**변수, 상수**

- **lowerCamelCase** 사용

```swift
let userName: String
```

### 💧**열거형**

- 각 case 에는 **lowerCamelCase** 사용

```swift
enum UserType {
    case viewDeveloper
    case serverDeveloper
}
```

### 💧**약어**

약어로 시작하는 경우 소문자로 표기, 그 외에는 항상 대문자

```swift
// 좋은 예:
let userID: Int?
let html: String?
let websiteURL: URL?
let urlString: String?
```

```swift
// 나쁜 예:
let userId: Int?
let HTML: String?
let websiteUrl: NSURL?
let URLString: String?
```

### 💧**기타 네이밍**

```swift
setUI() : @IBOutlet 속성 설정
setLayout() : 레이아웃 관련 코드
setDataBind() : 배열 항목 세팅. 컬렉션뷰 에서 리스트 초기 세팅할때
setAddTarget() : addtarget 모음
setDelegate() : delegate, datasource 모음
setCollectionView() : 컬렉션뷰 관련 세팅
setTableView() : 테이블뷰 관련 세팅
initCell() : 셀 데이터 초기화
registerXib() : 셀 xib 등록.
setNotification() : NotificationCenter addObserver 모음

헷갈린다? set을 쓰세요 ^^

```
</details>

<details>
<summary> 🍎 코드 레이아웃 </summary>
<div markdown="1">

### 💧**들여쓰기 및 띄어쓰기**

- 들여쓰기에는 탭(tab) 대신 **4개의 space**를 사용합니다.
- 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
    
    `let names: [String: String]?`
    
    `let name: String`
    
- 연산자 오버로딩 함수 정의에서는 연산자와 괄호 사이에 한 칸 띄어씁니다.
    
    `func ** (lhs: Int, rhs: Int)`
    

### 💧**줄바꿈**

- 함수를 호출하는 코드가 최대 길이를 초과하는 경우에는 파라미터 이름을 기준으로 줄바꿈합니다.
**파라미터가 3개 이상이면 줄바꿈하도록!!**
    
    **단, 파라미터에 클로저가 2개 이상 존재하는 경우에는 무조건 내려쓰기합니다.**
    
    ```swift
    UIView.animate(
      withDuration: 0.25,
      animations: {
        // doSomething()
      },
      completion: { finished in
        // doSomething()
      }
    )
    ```
    
- `if let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.
    
    ```swift
    if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female {
      // ...
    }
    ```
    
- `guard let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다. `else`는 마지막 줄에 붙여쓰기
    
    ```swift
    guard let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female else { return }
    
    guard let self = self 
    else { return } (X)
    
    guard let self = self else { return } (O)

    ```
- else 구문이 길 시 줄바꿈
  

### 💧**빈 줄**

- 클래스 선언 다음에 , extension 다음에 한 줄 띄어주기
- 빈 줄에는 공백이 포함되지 않도록 합니다.  ( 띄어쓰기 쓸데없이 넣지 말기 )
- 모든 파일은 빈 줄로 끝나도록 합니다. ( 끝에 엔터 하나 넣기)
- MARK 구문 위와 아래에는 공백이 필요합니다.
    
    ```swift
    // MARK: Layout
    
    override func layoutSubviews() {
      // doSomething()
    }
    
    // MARK: Actions
    
    override func menuButtonDidTap() {
      // doSomething()
    }
    ```
    

### 💧**임포트**

모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.

```swift
import UIKit

import Moya
import SnapKit
import SwiftyColor
import Then
```

```swift
import UIKit

import SwiftyColor
import SwiftyImage
import JunhoKit
import Then
import URLNavigator
```

</details>


<details>
<summary> 🍎 클로저 </summary>
<div markdown="1">

- 파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.
    
    **좋은 예:**
    
    ```
    let completionBlock: (() -> Void)?
    ```
    
    **나쁜 예:**
    
    `let completionBlock: (() -> ())? let completionBlock: ((Void) -> (Void))?`
    
- Closure 정의시 파라미터에는 괄호를 사용하지 않습니다.
    
    **좋은 예:**
    
    ```swift
    { operation, responseObject in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    { (operation, responseObject) in
      // doSomething()
    }
    ```
    
- Closure 정의시 가능한 경우 타입 정의를 생략합니다.
    
    **좋은 예:**
    
    ```swift
    ...,
    completion: { finished in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    ...,
    completion: { (finished: Bool) -> Void in
      // doSomething()
    }
    
    completion: { data -> Void in
      // doSomething()
    } (X)
    ```
    
- Closure 호출시 또다른 유일한 Closure를 마지막 파라미터로 받는 경우, 파라미터 이름을 생략합니다.
    
    **좋은 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5) {
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5, animations: { () -> Void in
      // doSomething()
    })
    ```
    
</details>

<details>
<summary> 🍎 주석 </summary>
<div markdown="1">

코드는 가능하면 자체적으로 문서가 되어야 하므로, 코드와 함께 있는 인라인(inline) 주석은 피한다.

### 💧**MARK 주석**

```swift
class ViewController: UIViewController {
    // MARK: - Property
    // MARK: - UI Property
    // MARK: - Life Cycle
    // MARK: - Setting
    // MARK: - Action Helper
    // MARK: - @objc Methods
    // MARK: - Custom Method
}

// MARK: - Extensions
```


### 💧**퀵헬프 주석**

커스텀 메서드, 프로토콜, 클래스의 경우에 퀵헬프 주석 달기

```swift
/// (서머리 부분)
/// (디스크립션 부분)
class MyClass {
    let myProperty: Int

    init(myProperty: Int) {
        self.myProperty = myProperty
    }
}

/**summary
(서머리 부분)
> (디스크립션 부분)

- parameters:
    - property: 프로퍼티
- throws: 오류가 발생하면 customError의 한 케이스를 throw
- returns: "\\(name)는 ~" String
*/
func printProperty(property: Int) {
        print(property)
    }

```

- 참고 :

</details>

<details>
<summary> 🍎 프로그래밍 권장사항 </summary>
<div markdown="1">

### 💧**Type Annotation 사용**

**좋은 예:**

```swift
let name: String = "철수"
let height: Float = "10.0"
```

**나쁜 예:**

```swift
let name = "철수"
let height = "10.0"
```

### 💧**UICollectionViewDelegate, UICollectionViewDatsource 등 시스템 프로토콜**

프로토콜을 적용할 때에는 extension을 만들어서 관련된 메서드를 모아둡니다.

**좋은 예**:

```swift
final class MyViewController: UIViewController {
  // ...
}

// MARK: - UITableViewDataSource

extension MyViewController: UITableViewDataSource {
  // ...
}

// MARK: - UITableViewDelegate

extension MyViewController: UITableViewDelegate {
  // ...
}
```

**나쁜 예:**

```swift
final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  // ...
}

// 프로토콜 여러개를 한곳에 몰아서 때려넣지 말자!
```

</details>


<details>
<summary> 🍎 기타규칙 </summary>
<div markdown="1">

- `self` 는 최대한 사용을 지양 → `**알잘딱깔센 self…**`
- `viewDidLoad()` 에서는 함수호출만
- delegate 지정, UI관련 설정 등등 모두 함수와 역할에 따라서 extension 으로 빼기
- 필요없는 주석 및 Mark 구문들 제거
- `deinit{}` 모든 뷰컨에서 활성화
- `guard let` 으로 unwrapping 할 시, nil 가능성이 높은 경우에는 `else{}` 안에 `print()` 해서 디버깅하기 쉽게 만들기
- `return` 사용시 두 줄 이상 코드가 있을 시, 한 줄 띄고 `return` 사용
    
    ```swift
    func fetchFalse() -> Bool {
            return false
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
            guard let data else { return false }
            
            return true
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
            guard let data else {
                    return false 
            }
            return true
    } (X)
    ```
    
    ### 추가 규칙
    
    - `약어 지양`
    → TVC보다는 TableViewCell
    
    ### Function naming Rule
    
    - **set_ 형태로 작성**
    → setUI, setData
        - `setLayout()`, `setStyle()`, `setDelegate()`
    
    ### MARK 주석
    
    ```swift
    class ViewController: UIViewController {
        // MARK: - Property
        // MARK: - UI Property
        // MARK: - Life Cycle
            // MARK: - Setting
        // MARK: - Action Helper
        // MARK: - Custom Method
    }
    
    // MARK: - UITableView Delegate
    ```
    
    - 마크 주석 미사용시 삭제
    
    ### 프로퍼티 생성은 레이아웃 순서대로지만,  collectionView, tableView는 최상단에 적읍시다
    
    ```swift
    private let tableView: UITableView = {
            let view = UITableView()
            // ...
            return view
    }()
    
    private let view = UIView()
    
    private let view2 = UIView()
    ```
    
    ### 뷰의 생명주기를 담당하는 함수 안에는, 직접적인 구현 보다는 함수 호출만 진행
    
    ```swift
    ~~override viewDidLoad() {
            super.viewDidLoad()
            self.view.addsubView(uniView)
    }~~
    ```
    
    ```swift
    override viewDidLoad() {
            super.viewDidLoad()
            self.addUniView()
    }
    private func addUniView() {
            super.viewDidLoad()
            self.view.addsubView(uniView)
    }
    
    ```
    
</details>
    
   

# foldering 
<img width="690" alt="image" src="https://github.com/GGumPiece/GGumPiece_iOS/assets/73978827/f9f017d4-e0db-49d9-8587-fe9997f2a063">


# 가용 라이브러리

SPM을 이용

```swift
Kingfisher //이미지처리
Alamofire // 네트워크
Snapkit //레이아웃
Then //코드 간결화
Sentry //error tracking
kakao-ios-sdk //socialLogin
firebase-auth //socialLogin

```

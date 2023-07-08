#Git flow
# branch

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f7497795-62f3-4da0-b47e-8e874df9e350/Untitled.png)

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

#foldering
- 코드 레이아웃
    
    ### 코드 들여쓰기
    
    - 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
    
    ```swift
    let names: [String: String]?
    ```
    
    ### 빈줄
    
    - 빈줄에는 공백이 포함되지 않도록 합니다.
    - MARK 구문 위와 아래에는 공백이 필요합니다.
    
    ```swift
    // MARK: - Layout
    
    override func layoutSubviews() {
      // doSomething()
    }
    
    // MARK: - Actions
    
    override func menuButtonDidTap() {
      // doSomething()
    }
    ```
    
- 네이밍
    
    ### 클래스와 구조체의 네이밍
    
    - 클래스와 구조체의 이름에는 UpperCamelCase를 사용합니다
    
    ```swift
    class SomeClass {
      // class definition goes here
    }
    
    struct SomeStructure {
      // structure definition goes here
    }
    ```
    
    ### 함수의 네이밍
    
    - 함수 이름에는 lowerCamelCase를 사용합니다.
    
    ```swift
    func name(for user: User) -> String?
    ```
    
    - Action 함수의 네이밍은 ‘주어+동사+목적어’형태를 사용합니다.
    - Tap(눌렀다 뗌)*은 `UIControlEvents`의 `.touchUpInside`에 대응하고, *Press(누름)*는 `.touchDown`에 대응합니다.
    - *will~*은 특정 행위가 일어나기 직전이고, *did~*는 특정 행위가 일어난 직후입니다.
    - *should~*는 일반적으로 `Bool`을 반환하는 함수에 사용됩니다.
    
    ```swift
    func backButtonDidTap() {
      // ...
    }
    ```
    
    event (touch, gesture …) 등의 액션을 추가할때는 따로 설정된 함수를 선언해서 쓰자!
    
    ```swift
    lazy var button = UIButton().then {
    	$0.addTarget(self, #selector(buttonDidTap), .touchUpInside)
    }
    이런식으로 하지말고
    
    func addAction() {
    	self.button.addtarget() ....
    }
    같은 식으로 정리 해서 사용하기
    ```
    
    **내 class 안의 변수 호출시에는 무조껀 self 사용** 
    
    ### 변수 & 상수 네이밍
    
    - lowerCamelCase를 사용합니다.
    
    ```swift
    let maximumNumberOfLines = 3
    ```
    
    ### 열거형
    
    - enum의 이름은 UpperCamelCase, enum case는 lowerCamelCase를 사용합니다.
    
    ```swift
    enum Result {
      case .success
      case .failure
    }
    ```
    
    ### 프로토콜
    
    - 프로토콜 이름에는 UpperCamelCase를 사용합니다.
    
    ```swift
    protocol SomeProtocol {
      // protocol definition goes here
    }
    
    struct SomeStructure: SomeProtocol, AnotherProtocol {
      // structure definition goes here
    }
    
    class SomeClass: SomeSuperclass, SomeProtocol, AnotherProtocol {
        // class definition goes here
    }
    
    extension UIViewController: SomeProtocol, AnotherProtocol {
      // doSomething()
    }
    ```
    
    ### 약어
    
    - 약어로 시작하는 경우 소문자로 표기하고, 그외의 경우에는 항상 대문자로 표기합니다.
    
    ```swift
    let userID: Int?
    let html: String?
    let websiteURL: URL?
    let urlString: String?
    ```
    
- 추가적인 규칙
    
    ### Additional Rules
    
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

#foldering 
## 폴더링

```swift
Uni-iOS
	│
  |── Source
  │   |── Extensions
  │   |── Models
  │   |── Repository
  │   |── Global
	│        └── Shared
  │   |── Scene
	│	  │   |── ViewController
	│	  │	  |── View
	│	  │	  |── Cells
	│	  │	    |── CollectionViewCell
	│	  │	    |── TableViewCell
	│	  |		└── Components
  │   └── Supports
	│			    |── AppDelegate.swift
	│					└── SceneDelegate.swift
  └── Resource
     |── LaunchScreen.storyboard
     |── Assets.xcassets
     └── Info.plist
```

 

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

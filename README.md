# STORM_iOS
STORM_iOS

- <h2>줄바꿈</h2>

- `if let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.

  ```swift
  if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
    let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
    user.gender == .female {
    // ...
  }
  ```

- `guard let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다. `else`는 `guard`와 같은 들여쓰기를 적용합니다.

  ```swift
  guard let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
    let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
    user.gender == .female
  else {
    return
  }
  ```

MARK 한줄 띄우기

- 모든 파일은 빈 줄로 끝나도록 합니다.

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

- <h2>네이밍</h2>

<h3>동사의 변형</h3>

영어에서 동사는 세 가지 형태로 사용됩니다. ***동사원형 - 과거형 - 과거분사\***.

| 동사 원형         | ~~과거형~~              | 과거 분사         |
| ----------------- | ----------------------- | ----------------- |
| request(요청하다) | ~~requested(요청했다)~~ | requested(요청된) |
| make(만들다)      | ~~made(만들었다)~~      | made(만들어진)    |
| hide(숨다)        | ~~hid(숨었다)~~         | hidden(숨겨진)    |

### ✏️ 다음에서는 동사 원형을 사용합니다.

- 함수 및 메서드
- Bool 변수 (조동사 + 동사원형)
  - `canBecomeFirstResponder`, `shouldRefresh` 등
- Life Cycle 관련 delegate 메서드 (조동사 + 동사원형)
  - `didFinish`, `willAppear`, `didComplete` 등

### ✏️ 다음에서는 과거 분사를 사용합니다.

- 명사 수식
  - `requestedData`, `hiddenView`
- Bool 변수
  - `isHidden`, `isSelected`

<h3>단수와 복수</h3>

인스턴스 하나는 단수형으로 이름 짓고 Array나 List 타입은 복수형으로 이름 지어줍니다.

**좋은 예:**

```swift
let album: Album
let albums: [Album]
```

**나쁜 예:****

```swift
let albumList: [Album]
let albumArray: [Album]
```

### 클래스

- 클래스 이름에는 UpperCamelCase를 사용합니다.
- 클래스 이름에는 접두사Prefix를 붙이지 않습니다.

### 함수

- 함수 이름에는 lowerCamelCase를 사용합니다.

- 함수 이름 앞에는 되도록이면 `get`을 붙이지 않습니다.

  **좋은 예:**

  ```swift
  func name(for user: User) -> String?
  ```

  **나쁜 예:**

  ```swift
  func getName(for user: User) -> String?
  ```

- Action 함수의 네이밍은 '주어 + 동사 + 목적어' 형태를 사용합니다.

  - 버튼에는 *Press(누름)* 을 사용합니다.
  - *will~*은 특정 행위가 일어나기 직전이고, *did~*는 특정 행위가 일어난 직후입니다.
  - *should~*는 일반적으로 `Bool`을 반환하는 함수에 사용됩니다.

  **좋은 예:**

  ```swift
  func backButtonDidPress() {
    // ...
  }
  ```

  **나쁜 예:**

  ```swift
  func back() {
    // ...
  }
  
  func tapBack() {
    // ...
  }
  ```

### 변수

- 변수 이름에는 lowerCamelCase를 사용합니다.

<h4>Bool 변수</h4>

- Bool 변수명을 지을 때는 is로 시작합니다.

  ✏️ `isSelected` vs `selected`

  문법적으로만 보면 `isSelected`과 `selected` 둘 다 맞다고 할 수 있으나, `is`를 써주는 것이 컨벤션이다보니 맞춰주도록 합니다.

### 상수

- 상수 이름에는 lowerCamelCase를 사용합니다.

  **좋은 예:**

  ```swift
  let maximumNumberOfLines = 3
  ```

  **나쁜 예:**

  ```swift
  let kMaximumNumberOfLines = 3
  let MAX_LINES = 3
  ```

### 열거형

- enum의 각 case에는 lowerCamelCase를 사용합니다.

  **좋은 예:**

  ```swift
  enum Result {
    case .success
    case .failure
  }
  ```

  **나쁜 예:**

  ```swift
  enum Result {
    case .Success
    case .Failure
  }
  ```

<h3>중복 제거</h3>

- 불필요하게 의미가 중복되는 코드는 제거하여 간결하고 읽기 좋은 코드를 완성합니다. 

  **좋은 예:**

```swift
struct User {
  let identifier: String
}

let id = user.identifier
```

​    **나쁜 예:**

```swift
struct User {
  let userID: String
}

let id = user.userID
```

- <h2>클로저</h2>

파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.

**좋은 예:**

```swift
let completionBlock: (() -> Void)?
```

**나쁜 예:**

```swift
let completionBlock: (() -> ())?
let completionBlock: ((Void) -> (Void))?
```

- Closure 정의 시 매개변수에는 괄호를 사용합니다.

  **좋은 예:**

  ```swift
  { (operation, responseObject) in
    // doSomething()
  }
  ```

  **나쁜 예:**

  ```swift
  { operation, responseObject in
    // doSomething()
  }
  ```



- ## 클래스와 구조체

  - 클래스와 구조체 내부에서는 `self`를 명시적으로 사용합니다.

  - 구조체를 생성할 때에는 Swift 구조체 생성자를 사용합니다.

    **좋은 예:**

    ```
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    ```

    **나쁜 예:**

    ```
    let frame = CGRectMake(0, 0, 100, 100)
    ```



- ## 프로토콜

- 프로토콜 적용할 시 extension 만들어서 관련된 메서드를 모아두기 하나의 뷰 프로토콜은 같은 extension 함수에 넣기

- 더이상 상속이 발생하지 않는 클래스는 항상 `final` 키워드로 선언합니다.

- 프로토콜을 적용할 때에는 extension을 만들어서 관련된 메서드를 모아둡니다.

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

  **나쁜 예**:

  ```swift
  final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // ...
  }
  ```

  - <h2>스위프트의 getter</h2>

  스위프트에서 어떤 인스턴스를 리턴하는 함수나 메서드에 `get`을 사용하지 않습니다. `get` 없이 바로 타입 이름(명사)으로 시작합니다.

  ```swift
  func date(from string: String) -> Date?
  func anchor(for node: SCNNode) -> ARAnchor?                          
  func distance(from location: CLLocation) -> CLLocationDistance        
  func track(withTrackID trackID: CMPersistentTrackID) -> AVAssetTrack? 
  ```

  - <h2>`fetch`, `request`, `perform`</h2>

  다음과 같이 사용 용도에 따라 함수명을 구분합니다.

  ### ✏️ 결과를 바로 리턴하는 `fetch`

  ```swift
  //PHAsset - Photos Framework
  class func fetchAssets(withLocalIdentifiers identifiers: [String], options: PHFetchOptions?) -> PHFetchResult<PHAsset>
  
  //PHAssetCollection - Photos Framework
  class func fetchAssets(in assetCollection: PHAssetCollection, options: PHFetchOptions?) -> PHFetchResult<PHAsset>
  
  //NSManagedObjectContext - Core Data
  func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult
  ```

  ### ✏️ 유저에게 요청하거나 작업이 실패할 수 있을 때 `request`

  ```swift
  //PHImageManager
  func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID
  
  //PHAssetResourceManager
  func requestData(for resource: PHAssetResource, options: PHAssetResourceRequestOptions?, dataReceivedHandler handler: @escaping (Data) -> Void, completionHandler: @escaping (Error?) -> Void) -> PHAssetResourceDataRequestID
  
  //CLLocationManager
  func requestAlwaysAuthorization()
  func requestLocation()
  
  //MLMediaLibrary
  class func requestAuthorization(_ handler: @escaping (MPMediaLibraryAuthorizationStatus) -> Void)
  ```

  **request는 실패할 수 있는 작업이거나 누군가가 요청을 거절 할 수도 있을 때 사용합니다.**

  ### ✏️ 작업의 단위가 클로져나 Request로 래핑 되어있으면 `perform` 혹은 `execute`

  ```swift
  //VNImageRequestHandler
  func perform(_ requests: [VNRequest]) throws
  
  //PHAssetResourceManager
  func performChanges(_ changeBlock: @escaping () -> Void, completionHandler: ((Bool, Error?) -> Void)? = nil)
  
  //NSManagedObjectContext
  func perform(_ block: @escaping () -> Void)
  
  //CNContactStore
  func execute(_ saveRequest: CNSaveRequest) throws
  
  //NSFetchRequest
  func execute() throws -> [ResultType]
  ```

  파라미터로 Request 객체나 Closure를 받을 경우에는 `perform`이나 `execute` 을 사용합니다.

네이밍 컨벤션에는 다음과 같은 문서를 참고하였습니다.
https://github.com/StyleShare/swift-style-guide
https://soojin.ro/blog/english-for-developers-swift

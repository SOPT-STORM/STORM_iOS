# ⚡️🌪STORM iOS🌪⚡️

<img src = "https://user-images.githubusercontent.com/55133871/87793056-b0277880-c87f-11ea-9f5a-62bcb3054a31.gif" width = "100%">

<img src = "https://user-images.githubusercontent.com/55133871/87793832-c41faa00-c880-11ea-96c9-4b85d248149e.png" width = "20%">

<br>

<b>실시간 브레인스토밍 협업 플랫폼 - STORM</b>
> STORM은 효율적인 아이디어 회의를 돕는 온라인 툴이자 브레인스토밍을 함께하는 서비스입니다.
<br> 라운드마다 목표와 제한 시간을 설정해 각자 아이디어를 고민해보고,
<br> 각 라운드 후에는 팀원들이 함께 의견을 나눌 수 있습니다.
<br> 프로젝트가 끝난 뒤에는 최종 정리를 통해 라운드 및 카드 목록을 한눈에 볼 수 있으며,
<br> 좋은 아이디어 카드들은 따로 스크랩해 모아볼 수 있습니다.<br><br>

<br>

개발 기간 : 2020-06-30~2020-07-18 <br>

---------------------------------------

## :zap: 진행사항:zap:

[STORM IA & 기능명세서 참고](https://docs.google.com/spreadsheets/d/1a4JL1O6FLVjjnCx7rg4781ici10yg-ZGDMqT5empflk/edit#gid=2048172274) 

* 개발 진행상황과 파트 내 구현 담당자를 확인할 수 있습니다.



<h4>🚪로그인 </h4> : Signin

<img src="https://user-images.githubusercontent.com/31477658/86931137-b4aeab80-c172-11ea-8d6a-fe300705d3e9.gif"  width="180" height="370">

    ▶️ 카카오, 구글 연동 로그인 뷰.

    💻 Firebase와 KakaoSDK 사용하여 연동 로그인 구현.
    💻 뒤 gif는 로티로 넣음.

<h4>🌪메인뷰</h4> : Main

개발 진행 중

<h4>👤 프로젝트 참여 for 호스트</h4> : Project for Host

<h4>👥 프로젝트 참여 for 멤버</h4> : Project for Member

<img src="https://user-images.githubusercontent.com/31477658/86931569-37d00180-c173-11ea-8a2e-3e810d18987d.png"  width="220" height="370">

​    ▶️ 프로젝트 참여 전 대기하는 호스트와 멤버를 위한 뷰.

​    💻 테이블 뷰 사용, socket 통신으로 실시간 멤버 접속 확인 가능. 브레인스토밍 룰 확인 버튼 클릭 시 팝업뷰로 전환.


<img src="https://user-images.githubusercontent.com/31477658/86931770-749bf880-c173-11ea-9a98-a85b55c1f72d.png"  width="220" height="370">



​    ▶️ 브레인스토밍 룰을 리마인드해주는 팝업 뷰



<h4>📝 라운드 진행</h4> : On Round

<img src="https://user-images.githubusercontent.com/31477658/86909210-aea8d280-c152-11ea-9922-02d17666526b.png"  width="180" height="370">


​    ▶️ 라운드 진행시 그림그리기와 텍스트 입력을 위한 뷰.

1. 되돌리기 - 자신이 그린 한 획 을 지울 수 있습니다.
2. 복구 - 되돌리기 버튼으로 지운 획을 복구 할 수 있습니다.
3. 삭제 - 그림을 전체 삭제 합니다. 
4. 텍스트 입력 모드로 전환 할 수 있습니다.
5. 그림그리기 모드로 전환 할 수 있습니다.

<h4>🔖 라운드 정리</h4> : Wrapup Round

개발 진행 중


<h4>📕 라운드 종료</h4> : Round Finished

<img src="https://user-images.githubusercontent.com/31477658/86932025-c5abec80-c173-11ea-9503-9cfd0360f0b8.png"  width="220" height="370">

​    ▶️ 라운드 종료 후 참여한 프로젝트/라운드 정보와 스토밍한 카드를 모아서 보여주는 뷰.

​    💻 컬렉션뷰 사용, 상단 뷰 스와이프 시 reload.data, 페이지 컨트롤 사용

<img src="https://user-images.githubusercontent.com/31477658/86932328-2e936480-c174-11ea-82a4-db7ef4d5f90a.png"  width="220" height="370">

​    ▶️ 라운드 종료 후 스토밍한 카드를 클릭했을 때 보여지는 상세 카드 뷰.

​    💻 메모 저장 기능, 프로필 사진과 스크랩 버튼

<img src="https://user-images.githubusercontent.com/31477658/86932335-30f5be80-c174-11ea-869c-8183fcd63ab4.png"  width="220" height="370">

​    ▶️ 라운드 종료 후 스크랩한 카드를 모아서 보여주는 뷰.

​    💻 컬렉션뷰 사용



--------------------------------------

## 어려웠던 기능 구현 & Key-Takeaways 💡

**🚪로그인 Kakao api, Google api 사용** | 지현

```swift
    let providers:[FUIAuthProvider] = [
                FUIGoogleAuth()
            ]
  self.authUI!.providers = providers
  self.authUI!.delegate = self
            
  let authViewController = CustomViewController(authUI: self.authUI!)
            
  authViewController.modalPresentationStyle = .fullScreen
  // 
            
  self.present(authViewController, animated: false, completion: nil)
```
> FUI를 사용하여 CustomViewController을 생성 후, user = Auth.auth().currentUser 현 유저가 없다면 CustomViewController를 present

```swift
    private let loginButton: KOLoginButton = {
    let button = KOLoginButton()
    button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
    }()
```
>Firebase에서 카카오 연동 로그인은 제공하지 않기 때문에 따로 CustomViewController에 연동 로그인 버튼 생성 후 addSubView

**🎨Drawing기능 구현** | 승환

```swift
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]()) // 사용자가 첫번째 화면 터치시 lines 배열에 CGPoint 배열 추가
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else {return} // 사용자의 touch move event 발생 시, point변수에 터치지점 좌표 저장
        
        guard var lastLine = lines.popLast() else {return}
        
        lastLine.append(point) // lines 배열의 마지막 원소(line: [CGPoint])를 빼낸 후 point 추가
        lines.append(lastLine) // lines 배열
        
        setNeedsDisplay() // setNeedDisplay() 호출 - 시스템에 뷰가 다시 그려져야 함을 알리는 메소드로 뷰를 다시 그려 업데이트 함, setNeedsDisplay() 호출 시 draw(_ rect: CGRect) 실행
    }
}
```

```swift
    override func draw(_ rect: CGRect) {

        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return} // 2D그림을 그리기 위한 context
        
        context.setStrokeColor(UIColor.black.cgColor) // 색상 검정 설정
        context.setLineWidth(3) // 선 굵기 3 설정
        context.setLineCap(.round) // line의 endpoint 라운드 설정
        
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p) // 배열의 첫번째 p: CGPoint지점에서 새로운 subpath 시작
                } else {
                    context.addLine(to: p) // p 까지 직선 라인 추가
                }
            }
        }
    
        context.strokePath()
    }
    }
}
```


**📶socket 통신**

(TBD)

**🎥Animation 적용 **| 지윤

브레인 스토밍 룰 리마인더 팝업뷰 구현 시 애니메이션 적용

- Extension 코드

- 

  ```swift
  import UIKit
  
  extension UIViewController {
      func showAnimate()
      {
          self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
          self.view.alpha = 0.0;
          UIView.animate(withDuration: 0.25, animations: {
              self.view.alpha = 1.0
              self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          });
      }
      
      func removeAnimate()
      {
          UIView.animate(withDuration: 0.25, animations: {
              self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
              self.view.alpha = 0.0;
              }, completion:{(finished : Bool)  in
                  if (finished)
                  {
                      self.view.removeFromSuperview()
                  }
          });
      }
  }
  
  ```

- **Key Takeaways**
  - 애니메이션 없이는 딱딱한 팝업뷰였는데, 자연스러운 화면 전환이 모두 애니메이션을 적용을 통해 구현된다는 것을 깨달았음.
  - CGAffineTransform을 통해 뷰의 이동을 구현할 수 있음을 알게 되었음.

**📢Notification**

(TBD)

------------------------------------------------------

<h2>🗂폴더 그룹핑 방식🗃</h2>


- 기본적으로 MVC 패턴을 지향합니다. (source: ["Lecture 2: MVC's"](https://www.youtube.com/watch?v=w7a79cx3UaY) Youtube Michel Deiman Channel)

<img src="https://user-images.githubusercontent.com/31477658/86932466-600c3000-c174-11ea-99d6-dbfc9a15f953.png" />

<img src="https://user-images.githubusercontent.com/31477658/86932469-61d5f380-c174-11ea-83b8-d05297092ad7.png" />

- 스토리보드(플로우차트) + 기능 기준으로 최상위 폴더 그룹핑합니다.

<img src="https://user-images.githubusercontent.com/31477658/86933626-b29a1c00-c175-11ea-8fc7-dda68cb37828.png"  width="250" height="370">

- 최상위 폴더 및 스토리보드 이름은 다음과 같습니다.
  - 로그인 : Signin
  - 메인뷰: Main
  - 프로젝트 참여 for 호스트: Project For Host
  - 프로젝트 참여 for 멤버: Project For Member
  - 라운드 진행: On Round
  - 라운드 정리: Wrapup Round
  - 라운드 종료: Round Finished
    \+ Popup, Extension(스토리보드 X), Network(스토리보드 X)
- 최상위 폴더 아래는 MVC패턴을 따라 Model/View(Cell)/Controller로 나눕니다.

-----------------------------------------------------

<h2> 💜STORM iOS 팀원소개💛</h2>

- 이지윤 - iOS파트의 i개발자
- 김지현 - iOS파트의 O개발자
- 이승환 - iOS파트의 S개발자

**저희 셋이 있어야만 iOS가 완성됩니다.**

더 자세한 팀원 소개가 보고 싶다면? [노션 STORM 팀원 소개 링크](https://www.notion.so/STORM-e0234061dd594af79f1035691830e698)

-----------------------------

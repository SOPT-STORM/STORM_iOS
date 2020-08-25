//
//  NetworkManager.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Alamofire

class NetworkManager {
    // Singleton 객체
    static let shared = NetworkManager()
    
    
    
    private init() {}

    //private let baseURL = "http://4f0efeac24d1.ngrok.io"
    
    var user_idx = 0
    
    private let baseURL = "http://3.34.179.75:3000"

//    private let baseURL = "http://6cc8b8f248dd.ngrok.io" // 임시 url
//    
    // userImg - String 일지 File일지 아직 미정 (연동 끝나야 확인 가능)
//    func signIn(userName: String, googleToken: String?, KakaoToken: String?, userImg: String, completion: @escaping (Response?) -> Void) {
//    
//        let url = baseURL + "/user"
//        
//        let parameters = User(user_name: userName, user_token_google: googleToken, user_token_kakao: KakaoToken, user_img: userImg, user_idx: nil)
//        
//        let request = AF.request(url,
//                   method: .post,
//                   parameters: parameters,
//                   encoder: JSONParameterEncoder.default,
//                   headers: nil)
//        
//        request.responseDecodable(of: Response.self) { response in
//           switch response.result {
//           case let .success(result):
//            completion(result)
//           case let .failure(error):
//            print("Error description is: \(error.localizedDescription)")
//           }
//        }
//    }
    
    func fetchProjectList(completion: @escaping (Response?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/project/user/" + "\(user_idx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 프로젝트 참여하기
    func enterProject(projectCode: String, completion: @escaping (ProjectIdxResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/project/enter"
        
        let parameters = ProjectWithCode(user_idx: user_idx, project_code: projectCode)
         
         let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: ProjectIdxResponse.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (GET) 라운드 참여자 목록
    func fetchMemberList(roundIdx: Int, completion: @escaping (MemberResponse?) -> Void) {
        let url = baseURL + "/round/memberList/" + "\(roundIdx)"
        
        print(url)
        
        let request = AF.request(url)
        
        request.responseDecodable(of: MemberResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 프로젝트 추가하기
    func addProject(projectName: String, projectComment: String?, userIdx: Int, completion: @escaping (ProjectIdxResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/project"
        
        let parameters = Project(project_name: projectName, project_comment: projectComment, user_idx: user_idx, project_code: nil)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: ProjectIdxResponse.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (GET) 프로젝트 정보
    func fetchProjectInfo(projectIdx: Int, completion: @escaping (ProjectInfoResponse?) -> Void) {
        let url = baseURL + "/project/" + "\(projectIdx)"

        let request = AF.request(url)
        
        request.responseDecodable(of: ProjectInfoResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (GET) 프로젝트 참여자 목록
    func fetchProjectMember(projectIdx: Int, completion: @escaping (MemberResponse?) -> Void) {
        let url = baseURL + "/project/enter/" + "\(projectIdx)"
        
        print(url)
        
        let request = AF.request(url)
        
        request.responseDecodable(of: MemberResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (DELETE) 프로젝트 나가기
    func exitProject(projectIdx: Int, completion: @escaping (Response?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/project/" + "\(user_idx)/"  + "\(projectIdx)"
        
        let request = AF.request(url,
                    method: .delete
                    )
         
         request.responseDecodable(of: Response.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (GET) 라운드 카운트 정보 출력 - Host
    func fetchRoundCountInfo(projectIdx: Int, completion: @escaping (RoundCountResponse?) -> Void) {
        let url = baseURL + "/round/count/" + "\(projectIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: RoundCountResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 라운드 설정 - Host
    func setRound(projectIdx: Int, roundPurpose: String, roundTime: Int, completion: @escaping (RoundCountResponse?) -> Void) {
        
        let url = baseURL + "/round/setting"
        
        let parameters = Round(project_idx: projectIdx, round_purpose: roundPurpose, round_time: roundTime)

        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: RoundCountResponse.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (GET) 라운드 정보
    func fetchRoundInfo(projectIdx: Int, completion: @escaping (RoundResponse?) -> Void) {
        let url = baseURL + "/round/info/" + "\(projectIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: RoundResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 라운드 참여
    func enterRound(roundIdx: Int, completion: @escaping (RoundResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/round/enter"
        
        let parameters = RoundWithMemberIdx(user_idx: user_idx, round_idx: roundIdx)
        print(user_idx, roundIdx)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: RoundResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (DELETE) 라운드 나가기
    func exitRound(roundIdx: Int, completion: @escaping (RoundResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/round/leave"
        
        let parameters = RoundWithMemberIdx(user_idx: user_idx, round_idx: roundIdx)
        
        let request = AF.request(url,
                    method: .delete,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: RoundResponse.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (POST) 카드 추가하기
    func addCard(projectIdx: Int, roundIdx: Int, cardImg: UIImage?, cardTxt: String?,completion: @escaping () -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/card"
        
        var parameters: [String:Any] = [:]
        
        if cardTxt != nil {
            parameters = [
                "user_idx": user_idx,
                "project_idx": projectIdx,
                "round_idx": roundIdx,
                "card_txt": cardTxt!
            ]
        } else {
            parameters = [
                "user_idx": user_idx,
                "project_idx": projectIdx,
                "round_idx": roundIdx
            ]
        }

        let imageData = cardImg?.jpegData(compressionQuality: 0.8)
        
        AF.upload(multipartFormData: { multiPart in
        if imageData != nil {
              multiPart.append(imageData!, withName: "card_img",fileName: "image.png", mimeType: "image/png")
            }
                    
        for (key, value) in parameters {
                multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                }, to: url, method: .post) .uploadProgress(queue: .main, closure: { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                }).responseJSON(completionHandler: { data in
                }).response { (response) in
                    switch response.result {
                    case .success(_):
//                        print("upload success result: \(result)")
//                        print("code: \(response.response?.statusCode)")
                        completion()
                    case .failure(let err):
                        print("upload err: \(err)")
                    }
        }
    }
    
    // MARK:- (GET) 라운드 카드 리스트
    func fetchCardList(projectIdx: Int, roundIdx: Int, completion: @escaping (CardResponse?) -> Void) {
        let url = baseURL + "/round/cardList/" + "\(projectIdx)" + "/" + "\(roundIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: CardResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 카드 스크랩 및 취소 내부 로직
    
    // MARK:- (POST) 카드 메모 추가
    func addCardMemo(cardIdx: Int, memoContent: String, completion: @escaping (CardResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/card/memo"
        
        let parameters = CardWithMemo(user_idx: user_idx, card_idx: cardIdx, memo_content: memoContent)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: CardResponse.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (PUT) 카드 메모 수정
    func modifyCardMemo(cardIdx: Int, memoContent: String, completion: @escaping (CardResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/card/memo"
        
        let parameters = CardWithMemo(user_idx: user_idx, card_idx: cardIdx, memo_content: memoContent)
        
        let request = AF.request(url,
                    method: .put,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: CardResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (GET) 최종 프로젝트 정보
    func fetchFinalProjectInfo(projectIdx: Int, completion: @escaping (ProjectResponse?) -> Void) {
        let url = baseURL + "/project/finalInfo/" + "\(projectIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: ProjectResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (GET) 라운드 별 정보
    
    func fetchAllRoundInfo(projectIdx: Int, completion: @escaping (RoundFinalResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/round/roundFinalInfo/\(user_idx)/" + "\(projectIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: RoundFinalResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (GET) 스크랩 카드 조회
    
    func fetchAllScrapCard(projectIdx: Int, completion: @escaping (ScrappedCardResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/project/finalScarpList/\(user_idx)/" + "\(projectIdx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: ScrappedCardResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    
    // MARK:- (POST) 카드 스크랩
    
    func scrapCard(cardIdx: Int, completion: @escaping (Response?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/card/scrap"
        
        let parameters = CardWithMemo(user_idx: user_idx, card_idx: cardIdx, memo_content: nil)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
         
         request.responseDecodable(of: Response.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (Delete) 카드 스크랩 취소
    
    func cancelScrap(cardIdx: Int, completion: @escaping (Response?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/card/scrap/\(user_idx)/\(cardIdx)"
        
        let request = AF.request(url,
        method: .delete
        )
        
         request.responseDecodable(of: Response.self) { response in
            switch response.result {
            case let .success(result):
             completion(result)
            case let .failure(error):
             print("Error description is: \(error.localizedDescription)")
            }
         }
    }
    
    // MARK:- (POST) 회원 가입 // 햇당
    
    func signUp(userImg: UIImage?, userName: String, userEmail: String, userPwd: String, userImgFlag: Int, completion: @escaping (SignInResponse) -> Void) {
        let url = baseURL + "/user/signup"
        guard let user_img = userImg else {return}
        var parameters: [String:Any] = [:]
        
        parameters = [
            "user_img": user_img,
            "user_name": userName,
            "user_email": userEmail,
            "user_password": userPwd,
            "user_img_flag": userImgFlag
        ]
        
        let imageData = userImg?.jpegData(compressionQuality: 0.8)
        
        AF.upload(multipartFormData: { multiPart in
            if imageData != nil {
                multiPart.append(imageData!, withName: "user_img",fileName: "image.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to: url, method: .post) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
        }).responseDecodable(of: SignInResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 로그인 // 햇당
    
    func login(userEmail: String, userPwd: String, completion: @escaping (LogInResponse) -> Void) {
        let url = baseURL + "/user/signin"
        
        let parameters = Login(user_email: userEmail, user_password: userPwd)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: LogInResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 비밀번호 확인 // 햇음
    
    func confirmPassword(userPwd: String, completion: @escaping (ConfirmResponse) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/user/checkPassword"
        
        let parameters = ConfirmPwd(user_idx: user_idx, user_password: userPwd)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: ConfirmResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 회원 탈퇴
    
    func withDrawal(userPwd: String, userReason: String?, completion: @escaping (WithdrawalResponse) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        guard let reason = userReason else {return}
        let url = baseURL + "/user/withdrawal"

        let parameters = WithDrawal(user_idx: user_idx, user_password: userPwd, reason: reason)
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: WithdrawalResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (GET) 마이페이지 조회 // 햇당
    
    func fetchMyPageInfo(completion: @escaping (MyPageResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/user/mypage/" + "\(user_idx)"
        print(user_idx)
        
        let request = AF.request(url)
        
        request.responseDecodable(of: MyPageResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (PUT) 프로필 이미지 수정
    func modifyProfileImage(userImg: UIImage?, userImgFlag: Int, completion: @escaping () -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        guard let user_img = userImg else {return}
        let url = baseURL + "/user/mypage/img"
        
        var parameters: [String:Any] = [:]
        
        parameters = [
            "user_idx": user_idx,
            "user_img": user_img,
            "user_img_flag": userImgFlag
        ]
        
        let imageData = user_img.jpegData(compressionQuality: 0.8)
        
        AF.upload(multipartFormData: { multiPart in
            if imageData != nil {
                multiPart.append(imageData!, withName: "user_img",fileName: "image.png", mimeType: "image/png")
            }
            //multiPart.append("\(self.user_idx)".data(using: String.Encoding.utf8)!, withName: "user_idx")
            //multiPart.append("\(userImgFlag)".data(using: String.Encoding.utf8)!, withName: "user_img_flag")
            
            for (key, value) in parameters {
                multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
        }, to: url, method: .put) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
        }).response { (response) in
            switch response.result {
            case .success(_):
                print("upload success result: \(response.result)")
                print("code: \(response.response?.statusCode ?? 0)")
                completion()
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
    // MARK:- (PUT) 프로필 이름 수정
    func modifyProfileName(userName: String, completion: @escaping (ModifyResponse?) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/user/mypage/name"
        
        let parameters = UserName(user_idx: user_idx, user_name: userName)
        
        let request = AF.request(url,
                    method: .put,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: ModifyResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- (POST) 이메일 중복 확인
    
    func confirmEmail(userEmail: String, completion: @escaping (ConfirmResponse) -> Void) {
        user_idx = UserDefaults.standard.integer(forKey: "index")
        let url = baseURL + "/user/checkemail"
        
        let parameter: [String:String] = ["user_email": userEmail]
        
        let request = AF.request(url,
                    method: .post,
                    parameters: parameter,
                    encoder: JSONParameterEncoder.default,
                    headers: nil)
        
        request.responseDecodable(of: ConfirmResponse.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    
    
    
    
    
    
}

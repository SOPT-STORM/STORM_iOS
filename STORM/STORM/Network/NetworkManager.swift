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
    
    let user_idx = 1
    
    private init() {}
    
//    private let baseURL = "http://52.78.113.197:3000"
    
    private let baseURL = "http://6cc8b8f248dd.ngrok.io" // 임시 url
    
    // userImg - String 일지 File일지 아직 미정 (연동 끝나야 확인 가능)
    func signIn(userName: String, googleToken: String?, KakaoToken: String?, userImg: String, completion: @escaping (Response?) -> Void) {
    
        let url = baseURL + "/user"
        
        let parameters = User(user_name: userName, user_token_google: googleToken, user_token_kakao: KakaoToken, user_img: userImg, user_idx: nil)
        
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
    
    func fetchProjectList(completion: @escaping (Response?) -> Void) {

        let url = baseURL + "/project/" + "\(user_idx)"
        
        let request = AF.request(url)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
        
        // 가라 데이터
        let card1 = Card(card_idx: 12, card_img: nil, card_txt: "fwjleifjwaoeifjalkdfj")
        let card2 = Card(card_idx: 13, card_img: nil, card_txt: "인라ㅓ니아러니마어리ㅏㄴㅁ얼ㄴ")
        let card3 = Card(card_idx: 23, card_img: nil, card_txt: "fwjleifjwaㅇㄹㄴㅇㄹoeifjalkdfj")
        let card4 = Card(card_idx: 30, card_img: nil, card_txt: "인라ㅓㄴㅇㄹㄴㅁㅇㅏㄴㅁ얼ㄴ")
        
        let detail1 = ProjectWithDetail(project_idx: 1, project_name: "프로젝트1", card_list: [card1, card2, card3, card4])
        let detail2 = ProjectWithDetail(project_idx: 2, project_name: "프로젝트2", card_list: [card1, card2, card3, card4])
        let detail3 = ProjectWithDetail(project_idx: 3, project_name: "프로젝트3", card_list: [card1, card2, card3, card4])
        let response = Response(status: 200, success: true, message: "성공", data: [detail1, detail2, detail3])
        completion(response)
    }
    
    // MARK:- (POST) 프로젝트 참여하기
    func enterProject(projectCode: String, completion: @escaping (ProjectIdxResponse?) -> Void) {
        let url = baseURL + "/project/enter"
        
        let parameters = ProjectWithCode(user_idx: 1, project_code: projectCode)
         
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
        
//        // 가라 데이터 - 나중에 빼기
//        let project = ProjectWithIdx(project_idx: 57, project_code: "WEFAJE1209")
//        let result = ProjectIdxResponse(status: 200, success: true, message: "프로젝트 참여 등록 완료!", data: project)
//        completion(result)
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
        
        // 가라 데이터
//        let member1 = Member(user_name: "수지", user_img: "")
//        let member2 = Member(user_name: "종욱", user_img: "")
//        let member3 = Member(user_name: "은지", user_img: "")
//        let member4 = Member(user_name: "지윤", user_img: "")
//        let member5 = Member(user_name: "양희", user_img: "")
//        let result = MemberResponse(status: 200, success: true, message: "멤버 가져오기 성공!", data: [member1, member2, member3, member4, member5])
//        completion(result)
    }
    
    // MARK:- (POST) 프로젝트 추가하기
    func addProject(projectName: String, projectComment: String?, userIdx: Int, completion: @escaping (ProjectIdxResponse?) -> Void) {
        
        let url = baseURL + "/project"
        
        let parameters = Project(project_name: projectName, project_comment: projectComment, user_idx: userIdx, project_code: nil)
        
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
        
//        // 가라 데이터
//        let result = ProjectIdxResponse(status: 200, success: true, message: "완료!!", data: ProjectWithIdx(project_idx: 20, project_code: "WEFAE123"))
//        completion(result)
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
        let url = baseURL + "/round/enter"
        
        let parameters = RoundWithMemberIdx(user_idx: user_idx, round_idx: roundIdx)
        
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
        let url = baseURL + "/card"
        
        var parameters: [String:Any] = [:]
        
        if cardTxt != nil {
            parameters = [
                "user_idx": user_idx,
                "project_idx": projectIdx,
                "round_idx": roundIdx,
                "card_txt": cardTxt
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
        let url = baseURL + "/round/roundFinalInfo/" + "\(projectIdx)"
        
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
}

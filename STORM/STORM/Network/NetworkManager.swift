//
//  NetworkManager.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let user_idx = 32
    
    private init() {}
    
    private let baseURL = "http://52.78.113.197:3000"
    
//    private let baseURL = "http://8d3b8b3609dc.ngrok.io" // 임시 url
    
    // userImg - String 일지 File일지 아직 미정 (연동 끝나야 확인 가능)
    func signIn(userName: String, googleToken: String?, KakaoToken: String?, userImg: String, completion: @escaping (Response?) -> Void) {
    
        let url = baseURL + "/user"
        
        let param = User(user_name: userName, user_token_google: googleToken, user_token_kakao: KakaoToken, user_img: userImg, user_idx: nil)
        
        let request = AF.request(url,
                   method: .post,
                   parameters: param,
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
    }
    
    func enterProject(projectCode: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "/project/enter"
        
        let param = ProjectWithCode(user_idx: 32, project_code: projectCode)
         
         let request = AF.request(url,
                    method: .post,
                    parameters: param,
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
    
    // 로그인
//    func login(id: String, password: String, completion: @escaping (Response?) -> Void) {
//        let url = baseURL + "user/login"
//
//        let param = User(id: id, passwd: password, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
//
//        let request = AF.request(url,
//                   method: .post,
//                   parameters: param,
//                   encoder: JSONParameterEncoder.default,
//                   headers: nil)
//
//        request.responseDecodable(of: Response.self) { response in
//           switch response.result {
//           case let .success(result):
//
//            if let token = response.response?.allHeaderFields["token"] as? String {
//                UserDefaults.standard.set(token, forKey: "token")
//            }
//            completion(result)
//           case let .failure(error):
//            print("Error description is: \(error.localizedDescription)")
//           }
//        }
//    }
    
    
    
    
    
}

//
//  NetworkTestViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import SocketIO

class NetworkTestViewController: UIViewController {
    
    @IBAction func didPressConnect(_ sender: UIButton) {
        SocketIOManager.shared.openConnection()
    }
    
    @IBAction func didPressDisconnect(_ sender: UIButton) {
        SocketIOManager.shared.closeConnection()
    }
    
    @IBAction func didPressEmit(_ sender: UIButton) {
        SocketIOManager.shared.sendData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        NetworkManager.shared.fetchProjectList { (response) in
            print("fetchProjectList")
            print(response)
        }
        
        NetworkManager.shared.enterProject(projectCode: "d7bfp2gxpi") { (response) in
            print("프로젝트 참여하기")
            print(response)
        }

        NetworkManager.shared.fetchMemberList(roundIdx: 1) { (response) in
            print("라운드 참여자 목록")
            print(response)
        }

        
        NetworkManager.shared.addProject(projectName: "test", projectComment: "test", userIdx: 1) { (response) in
            print("프로젝트 추가하기")
            print(response)
        }

        NetworkManager.shared.fetchProjectInfo(projectIdx: 1) { (response) in
            print("프로젝트 정보")
            print(response)
        }
        
        
        NetworkManager.shared.fetchProjectMember(projectIdx: 1) { (response) in
            print("프로젝트 참여자 목록")
            print(response)
        }
        
        
        NetworkManager.shared.exitProject(projectIdx: 1) { (response) in
            print("프로젝트 나가기")
            print(response)
        }

        NetworkManager.shared.fetchRoundCountInfo(projectIdx: 1) { (response) in
            print("라운드 카운트 정보 출력 - Host")
            print(response)
        }

        NetworkManager.shared.setRound(projectIdx: 1, roundPurpose: "test", roundTime: 10) { (response) in
            print("라운드 설정 - Host")
            print(response)
        }

        NetworkManager.shared.fetchRoundInfo(projectIdx: 1) { (response) in
            print("라운드 정보")
            print(response)
        }

        NetworkManager.shared.enterRound(roundIdx: 1) { (response) in
            print("라운드 참여")
            print(response)
        }

        NetworkManager.shared.exitRound(roundIdx: 1) { (response) in
            print("라운드 나가기")
            print(response)
        }

        NetworkManager.shared.addCardMemo(cardIdx: 1, memoContent: "테스트 메모") { (response) in
            print("카드메모추가")
            print(response)
        }

//        NetworkManager.shared.addCard(projectIdx: 1, roundIdx: 1, cardImg: UIImage(named: "이탈리아"), cardTxt: nil)

        NetworkManager.shared.fetchCardList(projectIdx: 1, roundIdx: 1) { (response) in
            print("라운드카드리스트")
            print(response)
        }



        NetworkManager.shared.modifyCardMemo(cardIdx: 1, memoContent: "테스트 메모 수정") { (response) in
            print("카드메모수정")
            print(response)
        }
        
        NetworkManager.shared.fetchFinalProjectInfo(projectIdx: 1) { (response) in
            print("최종 프로젝트 정보")
            print(response)
        }

        NetworkManager.shared.fetchAllRoundInfo(projectIdx: 1) { (response) in
            print("라운드 별 정보")
            print(response)
        }
        */
    }
}

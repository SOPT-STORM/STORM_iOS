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
    
    var socket: SocketIOClient!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("실행")
        
        let manager = SocketManager(socketURL: URL(string: "http://156f31f9418d.ngrok.io")!, config: [.log(true), .compress])
        
        socket = manager.defaultSocket
//        NetworkManager.shared.signIn(userName: "이승환", googleToken: "테스트", KakaoToken: nil,
//                                     userImg: "test.jpg") { (response) in
//
//            print(response)
//
//        }
        
//        NetworkManager.shared.fetchProjectList { (result) in
//            print(result)
//        }
//
//        NetworkManager.shared.enterProject(projectCode: "") { (result) in
//            print(result)
//        }
        
        
        
//        NetworkManager.shared.
    

        // Do any additional setup after loading the view.
    
        
        socket.connect()
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        

        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }

            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                self.socket.emit("update", ["amount": cur + 2.50])
            }

            ack.with("Got your currentAmount", "dude")
        }
        
//        socket.emit("joinRoom", ["joinRoom" : "testtest"])
        
//        socket.emit("joinRoom", with: ["roomCode", "세영"])
//
//        socket.emit("joinRoom", ["roomCode", "세영"])
//
//        socket.on("test") { (dataArray, SocketAckEmitter) in
//            print("소켓 실행")
//            print("데이터 \(dataArray)")
//            print("소켓 \(SocketAckEmitter)")
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        socket.emit("joinRoom", with: ["roomCode", "세영"])
        
        socket.emit("joinRoom", ["roomCode", "세영"])
        
        socket.on("test") { (dataArray, SocketAckEmitter) in
            print("소켓 실행")
            print("데이터 \(dataArray)")
            print("소켓 \(SocketAckEmitter)")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

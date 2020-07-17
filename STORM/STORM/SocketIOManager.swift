//
//  SocketManager.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: "http://4cd4fd360e7c.ngrok.io")!, config: [.log(true), .compress])
    //  서버의 주소와 포트를 맞춰줘야 통신 가능
    var socket: SocketIOClient!
    
    override init() {
        super.init()
//        socket = self.manager.socket(forNamespace: "")
        
        socket = manager.defaultSocket

//        socket = self.manager.

        socket.on("roundcomplete") { (dataArray, SocketAckEmitter) in
            print("소켓 실행")
//            print("데이터 \(dataArray)")
//            print("소켓 \(SocketAckEmitter)")
            
            NetworkManager.shared.fetchMemberList(roundIdx: 1) { (result) in
                print("get통신")
                print(result)
            }
        } // 이름이 "test"인 emit 수신
    }
    
    
    func openConnection() {
        socket.connect() // 설정한 주소와 포트로 소켓 연결
    }
    
    func closeConnection() {
        socket.disconnect() // 소켓 연결 끊기
    }
    
    func sendData() {
//        socket.emit("roundSetting", with: "roomCode")
        
        socket.emit("joinRoom", ["roomCode", "승환"])
        socket.emit("roundSetting", "roomCode")
        
        // emit("이벤트 이름", 전송할 데이터)
        
//        socket.emit("roundSetting", ["roomCode": "testtest"])
        
//        socket.emit("event",  ["message" : "This is a test message"])
//        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
//        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
//        socket.emit
    }
        
    

}

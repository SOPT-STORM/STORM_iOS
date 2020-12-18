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
    
    var manager = SocketManager(socketURL: URL(string: "http://3.34.179.75:3000")!, config: [.log(true), .compress])
    
    //  서버의 주소와 포트를 맞춰줘야 통신 가능
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    func establishConnection() {
        socket.connect() // 설정한 주소와 포트로 소켓 연결
    }
    
    func closeConnection() {
        socket.disconnect() // 소켓 연결 끊기
    }
    
    func sendData(roomCode: String) {
        socket.emit("joinRoom", roomCode)
    }
}

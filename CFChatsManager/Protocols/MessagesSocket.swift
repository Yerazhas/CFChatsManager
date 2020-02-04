//
//  MessagesSocket.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/2/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation
import Starscream
import SocketIO

protocol MessagesSocket: class {
    var delegate: CFSocketClientDelegate? { get set }
    
    func connect()
    func disconnect()
    func sendMessage(message: String)
    func sendMessage(data: Data)
}

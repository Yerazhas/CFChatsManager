//
//  AppDelegate.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/2/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit
import SocketIO
import Starscream

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = BaseMessagesViewController<CFMessageImpl>(messagesSocket: MessagesWSManager(socket: WebSocket(url: URL(string: "randomURL")!)), parser: CFParserImpl())
        _ = BaseMessagesViewController<CFMessageImpl>(messagesSocket: MessagesSocketIOManager(urlString: "randomURL"), parser: CFParserImpl())
        
        return true
    }
}


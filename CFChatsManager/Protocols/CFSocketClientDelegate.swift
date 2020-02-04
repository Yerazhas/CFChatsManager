//
//  CFSocketClientDelegate.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

protocol CFSocketClientDelegate: class {
    func didReceiveMessage(message: String)
    func didReceiveError(error: Error)
    func didReceiveData(data: Data)
}

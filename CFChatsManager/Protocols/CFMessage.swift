//
//  CFMessage.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

protocol CFMessage: Decodable {
    var id: Int { get }
}

class CFMessageImpl: CFMessage {
    var id: Int
}

//
//  CFParser.swift
//  CFChatsManager
//
//  Created by Yerassyl Zhassuzakhov on 2/4/20.
//  Copyright © 2020 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

protocol CFParser {
    func parse<T: Decodable>(response: Data) -> Result<T, Error>
}

class CFParserImpl: CFParser {
    func parse<T>(response: Data) -> Result<T, Error> where T : Decodable {
        return .failure(MessageError.noData)
    }
}

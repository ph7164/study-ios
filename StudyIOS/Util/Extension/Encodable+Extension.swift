//
//  Encodable+Extension.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import Foundation

extension Encodable {
    
    var toDictionary : [String: Any] {
        guard let object = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String : Any] else { return [:] }
        return dictionary
    }
}

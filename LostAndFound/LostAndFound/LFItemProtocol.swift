//
//  LFItemProtocol.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import Foundation

protocol LFItemProtocol {
    var title:  String { get }
    var description: String { get }
}


class LFItem : LFItemProtocol {
    var title: String
    
    var description: String
    
    required init(title _title: String, desc: String) {
        title = _title
        description = desc
    }
    
}

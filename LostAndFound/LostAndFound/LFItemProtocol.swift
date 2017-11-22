//
//  LFItemProtocol.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import Foundation

import UIKit

enum LFItemType {
    case Lost
    case Found
}
protocol LFItemProtocol {
    var title:  String { get }
    var description: String { get }
    var image: UIImage? { get }
    var type: LFItemType { get }
    
}


class LFItem : LFItemProtocol {
    var title: String
    
    var description: String
    
    var image: UIImage?
    
    var type:LFItemType
    required init(title _title: String, desc: String, type _type: LFItemType) {
        title = _title
        description = desc
        type = _type
    }
    
}

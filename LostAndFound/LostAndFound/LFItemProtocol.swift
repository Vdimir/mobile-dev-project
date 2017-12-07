//
//  LFItemProtocol.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import Foundation

import UIKit

import FirebaseAuth

enum LFItemType {
    case Lost
    case Found
}
protocol LFItemProtocol {
    var title:  String { get }
    var description: String { get }
    var image: UIImage? { get }
    var type: LFItemType { get }
    
    var user: LFUser { get }
}


class LFItem : LFItemProtocol {
    var title: String
    
    var description: String
    
    var image: UIImage?
    
    var user: LFUser
    var type:LFItemType
    required init(title _title: String, desc: String, type _type: LFItemType, user _user: LFUser) {
        title = _title
        description = desc
        type = _type
        user = _user
    }
    
}



class LFUser {
    var FirstName :String
    var userPic: UIImage?
    var Contact: String
    var FireUser: User? // TODO make non optional
    
    func getName () -> String {
        return FirstName
    }
    
    
    init(firstName: String, contact: String){
        FirstName = firstName
        Contact = contact
    }
    
    init(firstName: String, contact: String, fire: User){
        FirstName = firstName
        Contact = contact
        FireUser = fire
        
    }
}

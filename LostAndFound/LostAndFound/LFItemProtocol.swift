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
    
    var longitude: Double? { get }
    var latitude: Double? { get }
    var user: LFUser { get }
}


class LFItem : LFItemProtocol {
    var title: String
    
    var longitude: Double?
    var latitude: Double?
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


class UidGen {
    static let genrator = UidGen()
    private static var lastUid:Int = 0
    
    func getUid() -> Int {
        
        UidGen.lastUid += 1
        return UidGen.lastUid
    }
    
    private init() {
    }
}
class LFUser {
    var FirstName :String
    var LastName : String?
    var userPic: UIImage?
    var Contact: String
    let UserId : String
    
    func getName () -> String {
        if let lastName = LastName {
            return FirstName + " " + lastName
        }
        return FirstName
    }
    
    init(firstName: String, contact: String){
        FirstName = firstName
        Contact = contact
        UserId = UIDevice.current.identifierForVendor!.uuidString
    }
    
    
    init(firstName: String, contact: String, id: String){
        FirstName = firstName
        Contact = contact
        UserId = id
    }
}

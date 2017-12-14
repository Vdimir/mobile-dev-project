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
import FirebaseDatabase

enum LFItemType: String, Codable {
    case Lost
    case Found
}


struct LFItem : Codable, FireDataRepresentable {
    
    var fireId: String!
    
    var user: LFUser
    
    static var path: String{
        return "items"
    }
    
    var title: String
    
    var description: String
    
    var imageUrl: String?
    
    var type: LFItemType
    
    
    init(title _title: String, desc: String, user _user: LFUser, type _type: LFItemType) {
        title = _title
        description = desc
        user = _user
        fireId = nil
        type = _type
    }
    
    init(title _title: String, desc: String, user _user: LFUser, type _type: LFItemType, fireId fid: String) {
        title = _title
        description = desc
        user = _user
        fireId = fid
        type = _type
    }
    
    static func decode(fromSnapshot snapshot: DataSnapshot) -> LFItem? {
        guard let values = snapshot.value as? [String:Any] else {return nil}
        
        let title = values[CodingKeys.title.stringValue] as! String
        let description = values[CodingKeys.description.stringValue] as! String
        let typeStr = values[CodingKeys.type.stringValue] as! String
//        let user = values[CodingKeys.user.stringValue] as! LFUser
//        let user = LFStorage.currentUser!
        let type:LFItemType = (typeStr == "Lost" ? .Lost : .Found)
        return LFItem(title: title, desc: description,
                      user: LFUser(firstName: "fd", contact: "fdsf", fire: "fds"), type: type, fireId: snapshot.key)
    }
    
    func encode(toChild child: DatabaseReference) {
        child.setValue([CodingKeys.title.stringValue : title,
                        CodingKeys.description.stringValue : description,
                        CodingKeys.user.stringValue : user.FireUid,
                        CodingKeys.type.stringValue : type.rawValue])
    }
    
}


//extension LFItem: UIViewRepresentable {
//    func setup(view: UIReusableType) {
//        if let cell = view as? UITableViewCell {
//            cell.detailTextLabel?.text = DateFormatter.defaultFormatter.string(for: self.date)
//            cell.textLabel?.text = self.title
//        }
//    }
//}


struct LFUser: Codable, FireDataRepresentable {
    static var path: String {
        return "users"
    }
    
    var fireId: String!
    
    var FirstName :String
    var userPic: String?
    
    var Contact: String
    var FireUid : String
    
    func getName () -> String {
        return FirstName
    }
    
    init(firstName: String, contact: String, fire: String){
        FirstName = firstName
        Contact = contact
        FireUid = fire
        
    }
    
    
    static func decode(fromSnapshot snapshot: DataSnapshot) -> LFUser? {
        guard let values = snapshot.value as? [String:Any] else {return nil}
        
        let fname = values[CodingKeys.FirstName.stringValue] as! String
        let contact = values[CodingKeys.userPic.stringValue] as! String
        let fire = values[CodingKeys.FireUid.stringValue] as! String
        
        return LFUser(firstName: fname, contact: contact, fire: fire)
    }
    
    func encode(toChild child: DatabaseReference) {
        child.setValue([CodingKeys.FirstName.stringValue : FirstName,
                        CodingKeys.userPic.stringValue : userPic ?? "",
                        CodingKeys.Contact.stringValue : Contact,
                        CodingKeys.FireUid.stringValue : FireUid])
    }
    
    
}

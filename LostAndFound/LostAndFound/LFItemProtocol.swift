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
    
    var image: UIImage? { get {
        if let s = imageUrl {
            
            let dataDecoded : Data = Data(base64Encoded: s, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage
            
        }
        return nil;
        }}
    
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
        
        let user = LFUser.decode(fromSnapshot: snapshot.childSnapshot(forPath: CodingKeys.user.stringValue))
        
        let _imageUrl = values[CodingKeys.imageUrl.stringValue] as! String?
//        print( user)
        let type:LFItemType = (typeStr == "Lost" ? .Lost : .Found)

//        FireWrapper.auth.currentUser?.displayName
        var res =  LFItem(title: title, desc: description,
                      user: user! , type: type, fireId: snapshot.key)
        
        
        res.imageUrl = _imageUrl
        return res
    }

    func encode(toChild child: DatabaseReference) {
        child.setValue([CodingKeys.title.stringValue : title,
                        CodingKeys.description.stringValue : description,
                        CodingKeys.type.stringValue : type.rawValue,
                        CodingKeys.imageUrl.stringValue: imageUrl
                        ])
        
        user.encode(toChild: child.child(CodingKeys.user.stringValue))
        
    }
    
}


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
        let contact = values[CodingKeys.Contact.stringValue] as! String
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

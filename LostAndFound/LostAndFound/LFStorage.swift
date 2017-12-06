//
//  LFStorage.swift
//  LostAndFound
//
//  Created by student on 06.12.2017.
//  Copyright © 2017 SYN. All rights reserved.
//

import Foundation


class LFStorage {
    
    static let instance = LFStorage()
    static let currentUser = LFUser(firstName: "Vladimir", contact: "@vdimir")
    
    var items: [LFItemProtocol]
    
    func add(_ elem: LFItemProtocol) {
        items.append(elem)
    }
    
    private init() {
        items = [LFItemProtocol]()
        
        items.append(LFItem(title: "LostItem1", desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", type: .Lost,
                            user: LFUser(firstName: "Foobar1", contact: "+79293367632", id: "fdsfsd")))
        
        items.append(LFItem(title: "LostItem2", desc: "Значимость этих проблем настолько очевидна, что сложившаяся структура организации влечет за собой процесс внедрения и модернизации позиций, занимаемых участниками в отношении поставленных задач. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности требуют определения и уточнения направлений прогрессивного развития.", type: .Lost,
                            user: LFUser(firstName: "Foobar Biz", contact: "+79293367632", id: "fdsf")))
        
        
        items.append(LFItem(title: "FloudItem0", desc: "Таким образом консультация с широким активом обеспечивает широкому кругу (специалистов) участие в формировании направлений прогрессивного развития. Не следует, однако забывать, что новая модель организационной деятельности способствует подготовки и реализации систем массового участия.", type: .Found,
                            user: LFUser(firstName: "Foo bar", contact: "+79293367632", id: "fdsf")))
    }
}



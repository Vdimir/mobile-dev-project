//
//  UserViewController.swift
//  LostAndFound
//
//  Created by student on 06.12.2017.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = user?.getName()
        if let pic = user?.userPic {
//            UserPicImageView.image = pic
        }
        
        ContactLabel.text = user?.Contact
        if LFStorage.currentUser?.FireUid != user?.FireUid {
            EditButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var EditButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var user: LFUser?

    @IBOutlet weak var UserPicImageView: UIImageView!
    @IBOutlet weak var ContactLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

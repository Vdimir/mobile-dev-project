//
//  LFDetailsViewController.swift
//  LostAndFound
//
//  Created by student on 25.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

class LFDetailsViewController: UIViewController {

    var item: LFItemProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = item.title
        descView.text = item.description
        if let img = item.image {
            imageView?.image = img
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    /**/

}

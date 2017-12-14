//
//  LFAddItemViewController.swift
//  LostAndFound
//
//  Created by student on 08.11.2017.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

class LFAddItemViewController: UIViewController
    , UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func loadImgBtnClick(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
//
        present(imagePicker, animated: true, completion: nil)
        
    }
    

    @IBOutlet weak var TypeToggle: UISegmentedControl!
    
    @IBAction func SaveBtnClick(_ sender: Any) {
        var type = LFItemType.Lost
        if TypeToggle.selectedSegmentIndex == 1 {
            type = .Found
        }
        var newItem = LFItem(title: TitleText.text!,
                             desc: DescriptionText.text,
                             user: LFStorage.currentUser!,
                             type: type)
        
        
//        newItem.image = imageView.image
        
        
        FireWrapper.data.setUserData(value: newItem, atPath: LFItem.path)
        _ = navigationController?.popViewController(animated: true)
        
//        if let sourceViewController = sender.source as? LFTableViewController {
//
//        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
       dismiss(animated:true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

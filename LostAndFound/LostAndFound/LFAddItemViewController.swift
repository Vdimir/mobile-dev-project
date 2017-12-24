//
//  LFAddItemViewController.swift
//  LostAndFound
//
//  Created by student on 08.11.2017.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit
import MapKit

class LFAddItemViewController: UIViewController
    , UIImagePickerControllerDelegate, UINavigationControllerDelegate
    , CLLocationManagerDelegate
{
    
    // 1
    let locationManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    var _image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        // 2
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // 3
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func loadImgBtnClick(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
//
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    var itemLocation:CLLocationCoordinate2D?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        itemLocation = userLocation.coordinate
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
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
                             type: type
                             )
        
        if let loc = itemLocation {
            newItem.latitude = loc.latitude
            newItem.longitude = loc.longitude
        }
      
        if let img = imageView.image {
            
            let img_rep = UIImagePNGRepresentation(img)
            
            let base64String = img_rep?.base64EncodedString()//(.allZeros)
//            let img_str = img_rep?.base64EncodedData()
//            let img_s = img_str?.base64EncodedString(options: .lineLength64Characters)
            newItem.imageUrl = base64String
        }
        imageView.image = newItem.image
        
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
        

        imageView.image = resizeImage(image: chosenImage, newWidth: 400)
        dismiss(animated:true, completion: nil)
    }
    

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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

//
//  WriteReviewTableViewController.swift
//  MatZyp
//
//  Created by archane on 2016. 11. 25..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import UIKit

class WriteReviewTableViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var userReview: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    var closureUpdateUI:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userReview.textContainer.maximumNumberOfLines = 3
        userReview.textContainer.lineBreakMode = .byWordWrapping
        userReview.layer.borderWidth = 1.0
        userReview.layer.borderColor = UIColor.gray.cgColor
        userReview.layer.cornerRadius = 8
        
        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
        let emptyButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(WriteReviewTableViewController.doneClick))
        
        keyboardDoneButtonView.items = [emptyButton, doneButton]
        userReview.inputAccessoryView = keyboardDoneButtonView
        userReview.delegate = self
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide keyboard
    func doneClick() {
        userReview.resignFirstResponder()
    }
    
    @IBAction func TapImage(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        userReview.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }

    func makeReview() -> Review? {
        let review = Review()

        if userReview.text.isEmpty {
            print("empty")
            return nil
        } else {
            
            let translator = ROGoogleTranslate()
            translator.apiKey = "AIzaSyCRpM66a1peA71dzX6xdcFF2M-bgGb16_Q"
            var params1 = ROGoogleTranslateParams()
            var params2 = ROGoogleTranslateParams()
            var params3 = ROGoogleTranslateParams()
            
            userReview.text = userReview.text.replacingOccurrences(of: "\n", with: ".")
        
            params1.target = "ko"
            params1.text = userReview.text
            translator.translate(params: params1) { result in
                let temp: String = result
                let getStr = temp.components(separatedBy: ".")
                var res: String = ""
                for string in getStr {
                    if (string == "") {
                        continue
                    }
                    res = res + string + "\n"
                }
                review.text[.korean] = res
                print(res)
            }
            
            
            params2.target = "en"
            params2.text = userReview.text
            translator.translate(params: params2) { result in
                let temp: String = result
                let getStr = temp.components(separatedBy: ".")
                var res: String = ""
                for string in getStr {
                    if (string == "") {
                        continue
                    }
                    res = res + string + "\n"
                }
                review.text[.english] = res
                print(res)
                if let updateUI = self.closureUpdateUI{
                    //print ("hi"+res)
                    OperationQueue.main.addOperation({
                        updateUI()
                    })
                }

            }
            
            params3.target = "zh"
            params3.text = userReview.text
            translator.translate(params: params3) { result in
                let temp: String = result
                let getStr = temp.components(separatedBy: ".")
                var res: String = ""
                for string in getStr {
                    if (string == "") {
                        continue
                    }
                    res = res + string + "\n"
                }
                review.text[.chinese] = res
                print(res)
            }
        }

        if let temp = userImage.image {
            review.image = temp
        }
        
        review.id = (dataCenter.user?.id)!
        review.name = (dataCenter.user?.name)!
        review.rate = rating.rating
        
        return review
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveClick(_ sender: Any) {
        
        guard let review = self.makeReview() else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.closureUpdateUI = {[unowned self] () -> () in
            
            switch self.presentingViewController {
            case let tabBarC as UITabBarController:
                if let navigationC = tabBarC.selectedViewController as? UINavigationController, let segviewC = navigationC.topViewController as? SegViewController, let reviewC = segviewC.currentViewController as? ReviewTableViewController {
                    reviewC.addNewReview(review: review)
                }
            case let navigationC as UINavigationController:
                if let segviewC = navigationC.topViewController as? SegViewController, let reviewC = segviewC.currentViewController as? ReviewTableViewController {
                    reviewC.addNewReview(review: review)
                }
            case let reviewC as ReviewTableViewController:
                reviewC.addNewReview(review: review)
            default:
                break
            }
            
            self.dismiss(animated: true, completion: nil)

        }
        
        
            
        
        
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  imgshow.swift
//  Seazoned
//
//  Created by Tanay Bhattacharjee on 30/05/19.
//  Copyright © 2019 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Kingfisher
class imgshow: UIViewController,UIImagePickerControllerDelegate,ImageCropViewControllerDelegate,UINavigationControllerDelegate {
    var str_img: String = ""
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let str = self.str_img
        //+ "," + (self.alldata["country"] as? String)!
        if str==""
        {
            self.img.image=UIImage (named: "user (1).png")
        }
        else
        {
            let url1 = URL(string: str)
            self.img.kf.setImage(with: url1)
        }

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func back(_ sender: Any) {
        let s = self.storyboard?.instantiateViewController(withIdentifier: "pr") as!  Profile
        self.navigationController?.pushViewController(s, animated: false)
        
    }
    var image : UIImage!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true)
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        //  image = editingInfo[UIImagePickerControllerOriginalImage] as! UIImage
        
     //   self.img.contentMode = UIView.ContentMode.center
        
        
        
        
        
        
        let  comtroller = ImageCropViewController()
        
        
        comtroller.image = selectedImage
        
        comtroller.delegate = self
        
        comtroller.blurredBackground = true
        
        self.navigationController?.pushViewController(comtroller, animated: true)
        
        //        imageView.image = image
        
        
        
    }
    
    func setProfileImage(imageToResize: UIImage, onImageView: UIImageView) -> UIImage
    {
        let width = imageToResize.size.width
        let height = imageToResize.size.height
        
        var scaleFactor: CGFloat
        
        if(width > height)
        {
            scaleFactor = onImageView.frame.size.height / height;
        }
        else
        {
            scaleFactor = onImageView.frame.size.width / width;
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        imageToResize.draw(in: CGRect(x:0,y:0,width:width * scaleFactor,height:height * scaleFactor))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!;
    }
    
    func imageCropViewControllerSuccess(_ controller: UIViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        
        // imageView.image = croppedImage
        let myimg = rotateImage(image: croppedImage)
        self.img.image = setProfileImage(imageToResize: myimg, onImageView:  self.img)
        // imageView.image = myimg
        self.img.contentMode = UIView.ContentMode.scaleToFill
        
        
        
        
        self.navigationController?.popViewController(animated: true)
        
        
        self.updatedata()
        
        
    }
    
    var image1 : UIImage!
    func updatedata()
    {
        
        SVProgressHUD.show()
        
        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        
        
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        //    Parameter.dob: dob!,
        let parameters: Parameters = ["user_id":user_id,
                                      "source":"android"
        ]
        
        print(parameters)
        
        
        
        // Alamofire.request(Webservice.register, method: .
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                
                var imageData : Data!
                
                //       DispatchQueue.main.async {
                if let image = self.img.image {
                    if let imageRepresentation = UIImageJPEGRepresentation(image, 0.2) {
                        
                        imageData = imageRepresentation
                        
                        print(imageData)
                        
                        if let data = imageData{
                            multipartFormData.append(data, withName: "drivers_license", fileName: "ios", mimeType: "image/jpg")
                        }
                        
                    }
                }
                // }
                
                //    print(imageData)
                
                
                
                
        },
            to: Webservice.change_landscaper_driver_image,
            headers: nil,
            
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON
                        { response in
                            //   debugPrint(response)
                            
                            
                            
                            let result =   response.result
                            
                            
                            
                            
                            print(result)
                            
                            
                            let json = result.value as! NSDictionary
                            let succ = json["success"] as! Int
                            let msg = json["msg"] as! String
                            
                            if succ == 1
                            {
                             
                                
                                
                                
                                
                                let s = self.storyboard?.instantiateViewController(withIdentifier: "pr") as!  Profile
                                self.navigationController?.pushViewController(s, animated: false)
                                
                                SVProgressHUD.dismiss()
                                
                                
                            }
                                
                                
                            else
                            {
                                
                                AppManager().AlertUser("", message: msg, vc: self)
                                
                                
                                SVProgressHUD.dismiss()
                            }
                            
                            
                            
                        }
                        .uploadProgress { progress in // main queue by default
                            
                            
                            print("Upload Progress: \(progress.fractionCompleted)")
                            
                            
                            
                            
                    }
                    return
                case .failure(let encodingError):
                    
                    debugPrint(encodingError)
                    
                    SVProgressHUD.dismiss()
                    
                    
                }
                
        })
    }
    func rotateImage(image:UIImage) -> UIImage
    {
        var rotatedImage = UIImage()
        switch image.imageOrientation
        {
        case .right:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .down)
            
        case .down:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .left)
            
        case .left:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
            
        default:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
        }
        
        return rotatedImage
    }
    
    
    func imageCropViewControllerDidCancel(_ controller: UIViewController!) {
        
       self.navigationController?.popViewController(animated: true)
        
      
        
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = sourceType
        
        present(picker, animated: true)
        
    }
    
    @IBAction func uploadimg(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            
            presentPhotoPicker(sourceType: .photoLibrary)
            
            return
            
        }
        
        
        
        let photoSourcePicker = UIAlertController()
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            
            self.presentPhotoPicker(sourceType: .camera)
            
        }
        
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            
            self.presentPhotoPicker(sourceType: .photoLibrary)
            
        }
        
        
        
        photoSourcePicker.addAction(takePhoto)
        
        photoSourcePicker.addAction(choosePhoto)
        
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(photoSourcePicker, animated: true)
        
        
    }
    
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

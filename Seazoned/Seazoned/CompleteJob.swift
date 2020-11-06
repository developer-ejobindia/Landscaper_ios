//
//  CompleteJob.swift
//  Seazoned
//
//  Created by Apple on 28/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CompleteJob: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cross(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: false)
    }
    
    
    
    @IBOutlet weak var imgvw: UIImageView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var submit_view: UIView!
    @IBOutlet weak var popup_view: UIView!
    var order_id:String!
    
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let des_obj = Design()
        des_obj.button_round(my_view: submit_view)
        
        des_obj.green_gradient(my_view: submit_view)
        
        showAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        // Do any additional setup after loading the view.
        
        imgvw.image = nil
        
        gradient()
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // self.navigationController?.navigationBar.isTranslucent = true
//        if UserDefaults.standard.object(forKey: "ar_value") != nil
//
//        {
//
//            //   cell.backgroundColor = UIColor.red
//
//
//
//
//
//            var ary = NSArray()
//
//
//
//
//
//            ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
//
//
//
//
//
//
//
//            let a = "\(ary)"
//
//
//
//            if ary.count == 0
//
//            {
//
//                red_msg.isHidden = true
//
//
//
//
//
//            }
//
//            else
//
//
//
//            {
//
//                //  AppManager().AlertUser("", message: a, vc: self)
//
//
//
//                red_msg.isHidden = false
//
//            }
//
//        }
//
//
//
//        else
//
//        {
//
//
//
//            red_msg.isHidden = true
//
//
//
//
//
//        }
        self.navigationController?.isNavigationBarHidden =  true
    }
    func gradient()
    {
        gradientLayer.frame = self.imgvw.bounds
        
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.clear.cgColor, UIColor.black.cgColor]
        
        self.imgvw.layer.addSublayer(gradientLayer)
    }

    @IBAction func upload(_ sender: Any) {
        // Show options for the source picker only if the camera is available.
        
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
    
    func presentPhotoPicker(sourceType: UIImagePickerControllerSourceType) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = sourceType
        
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        picker.dismiss(animated: true)
        
        
        
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to supply the original image.
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgvw.contentMode = UIViewContentMode.scaleAspectFit
        
        gradientLayer.removeFromSuperlayer()
        
        imgvw.image = image
        
        gradient()
        
        // ary.adding(image)
        
        // print(ary)
        
        //  updateClassifications(for: image)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        
        if imgvw.image == nil
        {
            AppManager().AlertUser("", message: "Please Select an image to submit", vc: self)
        }
        else
        {
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lu") as! LandUpload
            
            popOverVC.bookserid = order_id
            
            //popOverVC.uploadby=uploadby
            
            popOverVC.img = self.imgvw.image
            
            //popOverVC.msg=msg
            
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            //removeAnimate()
        }
        
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
//        UIView.animate(withDuration: 0.25, animations: {
//            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            self.view.alpha = 0.0;
//        }, completion:{(finished : Bool)  in
//            if (finished)
//            {
//                self.view.removeFromSuperview()
//            }
//        });
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: false)
        
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

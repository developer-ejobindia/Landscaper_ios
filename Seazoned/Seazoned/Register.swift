//
//  Register.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
protocol TermsAndConditionsDelegate {
    func updateCheckProperty()
}

class Register: UIViewController,UITextFieldDelegate,trasfardata, TermsAndConditionsDelegate,UIImagePickerControllerDelegate,ImageCropViewControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate  {
     @IBOutlet weak var termsAndConditionsView: TermsAndConditionsView!
    var isChecked: Bool = false
    
    func updateCheckProperty() {
        self.isChecked = termsAndConditionsView.isChecked
    }
    @IBOutlet weak var ssn: UITextField!
    
    @IBOutlet var logo_view: UIView!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var f_name: UITextField!
    
    @IBOutlet var l_name: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var phone: UITextField!
    
    //@IBOutlet var dob: UITextField!
    
    @IBOutlet var street: UITextField!
    
    @IBOutlet var city: UITextField!
    
    @IBOutlet var state: UITextField!
    
    @IBOutlet var coutry: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var con_pass: UITextField!
    
    @IBOutlet var signup_view: UIView!
    
    var pick: UIPickerView!
    
    var con_ary:NSArray!
    
    var con_id:Int!
    
    @IBOutlet var eye_img: UIImageView!
    
    @IBOutlet var btn_click: UIButton!
    
    
    
    
    @IBAction func chooseImage(_ sender: Any) {
    }
    
    
    @IBOutlet weak var img1: UIImageView!
    var datePicker :UIDatePicker!
    
    
    
//    func pickUpDate(_ textField : UITextField){
//
//        // DatePicker
//        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
//        self.datePicker.backgroundColor = UIColor.white
//        self.datePicker.datePickerMode = UIDatePickerMode.date
//        textField.inputView = self.datePicker
//
//        // ToolBar
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
//        toolBar.sizeToFit()
//
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Register.doneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Register.cancelClick))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//
//    }
//
//    func doneClick() {
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateFormat="MM/dd/YYYY"
//        dob.text = dateFormatter1.string(from: datePicker.date)
//        dob.resignFirstResponder()
//    }
//    func cancelClick() {
//        dob.resignFirstResponder()
//    }
    
    
    
    

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Register.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        phone.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        phone.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard2() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Register.doneButtonAction2))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        coutry.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction2() {
        coutry.resignFirstResponder()
    }
    
    @IBAction func btn(_ sender: Any) {
        
        let s = UIStoryboard.init(name: "Main", bundle: nil)
        
        let obj = s.instantiateViewController(withIdentifier: "ga") as! google_auto
        //self.present(obj, animated: true, completion: nil)
        obj.delegate=self
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    var str_c_img : String = "0"
    func addresssend(add: String, city: String, country: String, zipcode: String, state: String) {
        street.text=add
        self.city.text=city
        coutry.text=country
        //str_zip=zipcode
        self.state.text=state
        
        //        SVProgressHUD.show()
        //        loaddata()
        
    }
    
    @IBAction func sign_up(_ sender: Any) {
        
        if f_name.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter First Name", vc: self)
            print("enter email")
            
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
//            self.navigationController?.pushViewController(obj, animated: true)
            
        }

        else if l_name.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Last Name", vc: self)
            //print("enter email")
        }
        else if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {

            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email", vc: self)

        }
        else if phone.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Phone Number", vc: self)
            //print("enter email")
        }
            
        else if ssn.text?.count != 9
        {
            AppManager().AlertUser("WARNING", message: "Please Enter 9 Digits Social Security Number", vc: self)
            //print("enter email")
        }
            
        else if  self.str_c_img == "0"
        {
            AppManager().AlertUser("WARNING", message: "Choose driving license image", vc: self)
            //print("enter email")
        }
            
        else if street.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Address", vc: self)
            //print("enter email")
        }
//        else if city.text == ""
//        {
//            AppManager().AlertUser("WARNING", message: "Please Enter City", vc: self)
//            //print("enter email")
//        }
//        else if state.text == ""
//        {
//            AppManager().AlertUser("WARNING", message: "Please Enter State", vc: self)
//            //print("enter email")
//        }
//        else if coutry.text == ""
//        {
//            AppManager().AlertUser("WARNING", message: "Please Enter Zipcode", vc: self)
//            //print("enter email")
//        }
        else if password.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Password", vc: self)
            //print("enter email")
        }
        else if !(password.text == con_pass.text)
        {
            AppManager().AlertUser("WARNING", message: "Password Not Matched", vc: self)
        }

        else  if self.termsAndConditionsView.isChecked {
            print("Yay")
            
            
            print("Reg")
            SVProgressHUD.show()
            updatedata()
           // login_data()
        }
            
        else
        {
            
            AppManager().AlertUser("WARNING", message: "Please click checkbox", vc: self)
            
            
            
        }
        
        
//         let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
//          self.navigationController?.pushViewController(obj, animated: true)
        
        
        
    }
    
    func login_data()  {
        
        let strEmail = self.email.text
        
        let strPassword = self.password.text
        
        let first_name = self.f_name.text
        let last_name = self.l_name.text
        let tel = self.phone.text
        //let dob = self.dob.text
        let street = self.street.text
        
        let city = self.city.text
        let state = self.state.text
        let country = self.coutry.text
        //let street = self.pass.text
        
        
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
      //    Parameter.dob: dob!,
        let parameters: Parameters = [Parameter.email: strEmail!,
                                      Parameter.password: strPassword!,
                                      Parameter.first_name: first_name!,
                                      Parameter.last_name: last_name!,
                                      Parameter.tel: tel!,
                                    
                                      Parameter.street: street!,
                                      Parameter.city: city!,
                                      Parameter.state: state!,
                                      Parameter.latitude: lat1!,
                                      Parameter.longitude: long1!]
        
        
        
        
        Alamofire.request(Webservice.register, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let str_userid = "\(dict1["user_id"]!)"
                        
                        UserDefaults.standard.set(str_userid, forKey: "user_id")
                        
                        UserDefaults.standard.set("", forKey: "token1")
                        
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                        
                        obj.f_name=self.f_name.text!
                        obj.l_name=self.l_name.text!
                        
                        obj.complete_flag="0"
                        obj.lat1=self.lat1!
                        obj.long1=self.long1!
                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+300)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+10)
    }
    
    var lat1:String!
    var long1:String!
    
    func fetchlatlong(lat: String, long: String) {
        lat1 = lat
        long1 = long
    }
    
    @IBAction func login(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTapOutside()
        // Do any additional setup after loading the view.
        self.termsAndConditionsView.superViewContorller = self

        let des_obj = Design()
        
        des_obj.button_round(my_view: signup_view)
        des_obj.red_gradient(my_view: signup_view)
        des_obj.round_corner(my_view: logo_view,value: 12)
        
        
        scroll.layer.cornerRadius=6
        
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+10)
        
        //pickUpDate(dob)
        addDoneButtonOnKeyboard()
        addDoneButtonOnKeyboard2()
        
        des_obj.dropShadow(myview: logo_view)
        
        //loadcountries()
        
        //picker(coutry)
        
        phone.placeholder="Enter Phone Number"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
   
    func loadcountries()
    {
    
        let str = "\(Urls.get_countries)"
        
        let urlwithPercentEscapes = str.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if let url = NSURL(string:urlwithPercentEscapes!){
            
            
            
            if let data = try? Data(contentsOf:url as URL ){
                do{
                    let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    
                    
                    print("----------\(dict)")
                    
                    con_ary = dict["data"] as! NSArray
                    
                    
                }
                catch let error as NSError{
                    print("detail of json parsing error\n\(error)")
                }
            }
            
        }
        
        
    }
    
    var secure_flag=0
    
    @IBAction func eye(_ sender: Any) {
        if secure_flag==0 {
            password.isSecureTextEntry=false
            con_pass.isSecureTextEntry=false
            eye_img.image=UIImage (named: "view.png")
            secure_flag=1
        }
            
        else
        {
            password.isSecureTextEntry=true
            con_pass.isSecureTextEntry=true
            eye_img.image=UIImage (named: "hide.png")
            secure_flag=0
        }
    }
    
    
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//
//        return 1
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return con_ary.count
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//
//        let dict = con_ary[row] as! NSDictionary
//
//        let str_name = dict["country_name"] as! String
//
//        return str_name
//
//
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        let dict = con_ary[row] as! NSDictionary
//
//        let str_name = dict["country_name"] as! String
//
//        con_id = dict["id"] as! Int
//
//        coutry.text = str_name
//    }
//    func picker(_ textField : UITextField){
//
//        // DatePicker
//        self.pick = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
//        self.pick.backgroundColor = UIColor.white
//        textField.inputView = self.pick
//
//        pick.dataSource = self
//        pick.delegate = self
//
//        // ToolBar
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
//        toolBar.sizeToFit()
//
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Register.doneClick1))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Register.cancelClick1))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//
//    }
//
//    func doneClick1() {
//
//        coutry.resignFirstResponder()
//
//        print(con_id)
//
//    }
//
//    func cancelClick1() {
//        coutry.resignFirstResponder()
//    }
    
    
    var image : UIImage!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true)
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        //  image = editingInfo[UIImagePickerControllerOriginalImage] as! UIImage
        
      //  self.img1.contentMode = UIView.ContentMode.center
        
        
        
        
        
        
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
        self.str_c_img  = "1"
        // imageView.image = croppedImage
        let myimg = rotateImage(image: croppedImage)
        self.img1.image = setProfileImage(imageToResize: myimg, onImageView:  self.img1)
        // imageView.image = myimg
        self.img1.contentMode = UIView.ContentMode.scaleToFill
        
        
        
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    var image1 : UIImage!
    func updatedata()
    {
        
        
        
        
        
      // let token =  UserDefaults.standard.object(forKey: "token")
        
        //   let user_id =  UserDefaults.standard.object(forKey: "user_id") as! String
        
        
//        let headers: HTTPHeaders = [
//            "token": token as! String,
//            "Content-Type": "application/x-www-form-urlencoded",
//            "accept": "application/json"
//
//        ]
        
        
        
        let strEmail = self.email.text
        
        let strPassword = self.password.text
        
        let first_name = self.f_name.text
        let last_name = self.l_name.text
        let tel = self.phone.text
        //let dob = self.dob.text
        let street = self.street.text
        
        let city = self.city.text
        let state = self.state.text
        let country = self.coutry.text
        //let street = self.pass.text
        
        
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        //    Parameter.dob: dob!,
        let parameters: Parameters = [Parameter.email: strEmail!,
                                      Parameter.password: strPassword!,
                                      Parameter.first_name: first_name!,
                                      Parameter.last_name: last_name!,
                                      Parameter.tel: tel!,
                                      
                                      Parameter.street: street!,
                                      Parameter.city: city!,
                                      Parameter.state: state!,
                                      Parameter.latitude: lat1!,
                                      Parameter.longitude: long1!,
                                      "ssn_no":self.ssn.text!,
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
                if let image = self.img1.image {
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
            to: Webservice.register,
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
                                let dict1 = json["data"] as! NSDictionary
                                
                                let str_userid = "\(dict1["user_id"]!)"
                                
                                UserDefaults.standard.set(str_userid, forKey: "user_id")
                                
                                UserDefaults.standard.set("", forKey: "token1")
                                
                                let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                                
                                obj.f_name=self.f_name.text!
                                obj.l_name=self.l_name.text!
                                
                                obj.complete_flag="0"
                                obj.lat1=self.lat1!
                                obj.long1=self.long1!
                                self.navigationController?.pushViewController(obj, animated: true)
                                
                                
                                
                                
                                
                                
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
        self.str_c_img  = "0"
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = sourceType
        
        present(picker, animated: true)
        
    }
    
    @IBAction func upload_img(_ sender: Any) {
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
    
    
}

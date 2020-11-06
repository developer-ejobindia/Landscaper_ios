//
//  Login.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import GGLCore
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreLocation
import Firebase

class Login: UIViewController,UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate,CLLocationManagerDelegate {
  var locationManager = CLLocationManager()
    
    @IBOutlet var logo_view: UIView!
    
    @IBOutlet var login_view: UIView!
     @IBOutlet var lbl_sign: UILabel!
    
    @IBOutlet var email: UITextField!
    
    
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var signin_view: UIView!
    
    @IBOutlet var facebook_view: UIView!
    
    
    @IBOutlet var googleplus_view: UIView!
    
    @IBOutlet var eye_img: UIImageView!
    
    @IBOutlet var signin_lbl: UIButton!
    
    var fb_email:String!
    var fb_id:String!
    var fb_fname:String!
    var fb_lname:String!
    var fb_picurl:String!
    
    var secure_flag = 0
    
    var lat1:String!
    var long1:String!
    
    @IBAction func eye(_ sender: Any) {
        if secure_flag==0 {
            pass.isSecureTextEntry=false
            eye_img.image=UIImage (named: "view.png")
            secure_flag=1
        }
            
        else
        {
            pass.isSecureTextEntry=true
            eye_img.image=UIImage (named: "hide.png")
            secure_flag=0
        }
    }
    
    @IBAction func signin(_ sender: Any) {
        
        if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email Id", vc: self)
            
        }
        else if pass.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Password", vc: self)
            //print("enter email")
        }
        else
        {
            
            
            print("Log")
            
            //            SVProgressHUD.show()
            //
            //
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            //                self.logindata()
            //            }
            
            
            SVProgressHUD.show(withStatus: "Logging In...")
            login_data()
            
            
            
            
            
            
            
            //    let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
            //  self.navigationController?.pushViewController(obj, animated: true)
            
            
        }
        
        
        
    }
    
    
    func login_data()  {
        
        let strEmail = self.email.text
        
        let strPassword = self.pass.text
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.username: strEmail!,
                                      Parameter.password: strPassword!,
                                      Parameter.profile_id: "3",
                                      ]
        
        
        Alamofire.request(Webservice.login, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        UserDefaults.standard.set("\(dict["token"]!)", forKey: "token1")
                        
                        UserDefaults.standard.set("normal", forKey: "logintype")
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let str_userid = "\(dict1["user_id"]!)"
                        
                        UserDefaults.standard.set(str_userid, forKey: "user_id")
                        
                        let str_servicecount = "\(dict1["service_count"]!)"
                        
                        let str_provider_status = "\(dict1["provider_status"]!)"
                        
                        if str_servicecount=="0" || str_provider_status=="0"
                        {
                            UserDefaults.standard.set("0", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                            
                            obj.f_name="\(dict1["first_name"]!)"
                            obj.l_name="\(dict1["last_name"]!)"
                            
                            
                            let geocoder = CLGeocoder()
                            geocoder.geocodeAddressString("\(dict1["address"]!)") {
                                placemarks, error in
                                let placemark = placemarks?.first
                                let lat = placemark?.location?.coordinate.latitude
                                let lon = placemark?.location?.coordinate.longitude
                                print("Lat: \(lat), Lon: \(lon)")
                                
                                obj.lat1="\(lat!)"
                                obj.long1="\(lon!)"
                                
                            }
                            
                            
                            
                        //    obj.lat1="\(dict1["latitude"]!)"
                          //  obj.long1="\(dict1["longitude"]!)"
                            obj.complete_flag="1"
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        else
                        {
                            UserDefaults.standard.set("1", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
                
        }
        
        
    }
    @IBAction func fb(_ sender: Any) {
        let fbLoginManger : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManger.loginBehavior = FBSDKLoginBehavior.web
        
        fbLoginManger.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error == nil {
                
                
                
                let fbLoginResult : FBSDKLoginManagerLoginResult = result!
                
                
                
                if (result?.isCancelled)! {
                    
                    return
                    
                }
                
                if fbLoginResult.grantedPermissions.contains("email"){
                    
                    self.getFBUserDate()
                    
                }
                
            }
            
        }
    }
    func getFBUserDate() {
        
        
        
        print(" facebook Token id is:  \(FBSDKAccessToken.current().tokenString)")
        
        
        
        //self.view.isUserInteractionEnabled = false
        
        
        
        if FBSDKAccessToken.current() != nil {
            
            
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large),email"]).start(completionHandler: { (connection, result, error) in
                
                
                
                if error == nil {
                    
                    print(result!)
                    
                    
                    
                    
                    
                    let returnResult : [String: Any] = result as! [String : Any]
                    
                    print(returnResult["email"] as! String)
                    print("---------\(returnResult)")
                    
                    
                    User.email          =   returnResult["email"] as! String
                    
                    User.socialToken    =   FBSDKAccessToken.current().tokenString
                    
                    print("Facebook authentication Tocken \(FBSDKAccessToken.current().tokenString)")
                    
                    User.regThrough     =   RegThrough.facebook
                    
                    
                    self.fb_email = returnResult["email"] as! String
                    
                    self.fb_fname = returnResult["first_name"] as! String
                    
                    self.fb_lname = returnResult["last_name"] as! String
                    
                    self.fb_id = returnResult["id"] as! String
                    
                    let dic1 = returnResult["picture"] as! NSDictionary
                    
                    let dic2 = dic1["data"] as! NSDictionary
                    
                    self.fb_picurl = dic2["url"] as! String
                    
                                                        SVProgressHUD.show(withStatus: "Logging In")
//                 //   SVProgressHUD.show(withStatus: "Logging In...")
//                  //  self.fblogin_data()
//
//                   self.perform(#selector(self.callfbdata), with: self, afterDelay: 4.0)
//
//                  //  self.fblogin_data(fb_email: self.fb_email, fb_fname: self.fb_fname, fb_lname: self.fb_lname, fb_id: self.fb_id)
                    
                    
                    let parameters: Parameters = [Parameter.email: self.fb_email,
                                                  Parameter.first_name: self.fb_fname,
                                                  Parameter.last_name: self.fb_lname,
                                                  Parameter.facebook_id: self.fb_id]
                   
                    print(parameters)
                    
                    var request = URLRequest(url: NSURL.init(string: Webservice.landscaper_fb_login)! as URL)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.timeoutInterval = 10 // 10 secs
                    let postString = "email=\(self.fb_email)&first_name=\(self.fb_fname)&last_name=\(self.fb_lname)&facebook_id=\(self.fb_id)"
                    request.httpBody = postString.data(using: .utf8)
                        
                         Alamofire.request(request).responseJSON
                  //  Alamofire.request(Webservice.landscaper_fb_login, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
                        { response in
                            if let json = response.result.value {
                                print("JSON: \(json)")
                            }
                            debugPrint(response)
                            switch(response.result){
                            case .success(_):
                                let result = response.result
                                
                                let dict = result.value as! NSDictionary
                                
                                print("----------\(dict)")
                                
                                let succ = dict["success"] as! Int
                                
                                let msg = dict["msg"] as! String
                                
                                if succ==1
                                {
                                    UserDefaults.standard.set("\(dict["token"]!)", forKey: "token1")
                                    
                                    
                                    UserDefaults.standard.set("fb", forKey: "logintype")
                                    
                                    let dict1 = dict["data"] as! NSDictionary
                                    
                                    let str_userid = "\(dict1["user_id"]!)"
                                    
                                    UserDefaults.standard.set(str_userid, forKey: "user_id")
                                    
                                    let str_servicecount = "\(dict1["service_count"]!)"
                                    
                                    let str_provider_status = "\(dict1["provider_status"]!)"
                                    
                                    if str_servicecount=="0" || str_provider_status=="0"
                                    {
                                        UserDefaults.standard.set("0", forKey: "session")
                                        
                                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                                        
                                        obj.f_name="\(dict1["first_name"]!)"
                                        obj.l_name="\(dict1["last_name"]!)"
                                        
                                        obj.complete_flag="1"
                                        self.navigationController?.pushViewController(obj, animated: true)
                                    }
                                    else
                                    {
                                        UserDefaults.standard.set("1", forKey: "session")
                                        
                                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                                        self.navigationController?.pushViewController(obj, animated: true)
                                    }
                                    SVProgressHUD.dismiss()
                                    
                                }
                                else
                                {
                                    AppManager().AlertUser("", message: msg, vc: self)
                                    SVProgressHUD.dismiss()
                                }
                                
                                break
                                
                            case .failure(_):
                                //  print(response.error)
                                
                                SVProgressHUD.dismiss()
                                break
                                
                            }
                            
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
            })
            
        }
        
    }
    
    
    func  callfbdata()
    {
        SVProgressHUD.show(withStatus: "Logging In...")

          self.fblogin_data(fb_email: self.fb_email, fb_fname: self.fb_fname, fb_lname: self.fb_lname, fb_id: self.fb_id)
        
      
    }
    
    func fblogin_data(fb_email:String,fb_fname:String,fb_lname:String,fb_id:String)  {
        
        let parameters: Parameters = [Parameter.email: fb_email,
                                      Parameter.first_name: fb_fname,
                                      Parameter.last_name: fb_lname,
                                      Parameter.facebook_id: fb_id]
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(Webservice.landscaper_fb_login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        UserDefaults.standard.set("\(dict["token"]!)", forKey: "token1")
                        
                        
                        UserDefaults.standard.set("fb", forKey: "logintype")
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let str_userid = "\(dict1["user_id"]!)"
                        
                        UserDefaults.standard.set(str_userid, forKey: "user_id")
                        
                        let str_servicecount = "\(dict1["service_count"]!)"
                        
                        let str_provider_status = "\(dict1["provider_status"]!)"
                        
                        if str_servicecount=="0" || str_provider_status=="0"
                        {
                            UserDefaults.standard.set("0", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                            
                            obj.f_name="\(dict1["first_name"]!)"
                            obj.l_name="\(dict1["last_name"]!)"
                            
                            obj.lat1=self.lat1!
                            obj.long1=self.long1!
                            
                            obj.complete_flag="1"
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        else
                        {
                            UserDefaults.standard.set("1", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                  //  print(response.error)
                    
                    SVProgressHUD.dismiss()
                    break
                    
                }
                
        }
        
    }
    
    
    
    
    func checkfbgmail()
    {
        
        
        let DB_BASE = FIRDatabase.database().reference()
        
        
        let u_id  = UserDefaults.standard.value(forKey: "user_id")
        
        
        
        
        DB_BASE.child("notification_125470").observe(FIRDataEventType.value, with: { (snapshot) in
            //   print(snapshot)
            //if the reference have some values
            // let status = snapshot.childrenCount  + 1
            
            
            
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                
                let value = snapshot.value as? NSDictionary
                //  let value1 = value?.object(forKey: "date")
                
                let status = value?.value(forKey: "flag") as! String
                
                
                
                
                print("fggfgf\(value!)")
                
                
                
                
                
                
                
                
                if  status == "1"
                {
                    
                   // self.red_msg.isHidden = false
                    print("ok")
                    
                    self.googleplus_view.isHidden = false
                    
                      self.facebook_view.isHidden = false
                    self.lbl_sign.isHidden = false
                    
                }
                    
                    
                else
                    
                {
                   // self.red_msg.isHidden = true
                    self.googleplus_view.isHidden = true
                     self.facebook_view.isHidden = true
                    self.lbl_sign.isHidden = true
                    


                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
    }
    
    @IBAction func googleplus(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        
        if error == nil {
            
            
            
            // ***
            
            User.firstName      =   user.profile.givenName
            
            User.lastName       =   user.profile.familyName
            
            User.email          =   user.profile.email
            
            User.socialId       =   user.userID
            
            User.password    =   user.authentication.idToken
            
            print(" access token is : \(user.authentication.idToken)")
            
            User.regThrough     = RegThrough.gmail
            
            // var idToken  = GIDGoogleUser.getauto
            
            print("Acess token is:  \(user.authentication.accessToken)")
            
            print(" User Id:  \(user.userID)")
            
            print("--------------------------------------\(User.firstName)--\(User.lastName)--\(User.email)")
            
            // performLogin(email: User.email, password: User.password, regThrough: User.regThrough)
            
            //let str = User.firstName + " " + User.lastName
            
            
            //SVProgressHUD.show()
            
            //googlelogin(user_id: user.userID!, name: str, email: User.email)
            SVProgressHUD.show(withStatus: "Logging In...")
            googlelogin_data(user_id: user.userID, f_name: User.firstName, l_name: User.lastName, email_id: User.email)
            
            
            
            
        } else{
            
            print(error.localizedDescription)
            
        }
        
    }
    func googlelogin_data(user_id:String,f_name:String,l_name:String,email_id:String)  {
        
        //        let strEmail = self.email.text
        //
        //        let strPassword = self.pass.text
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.first_name: f_name,
                                      Parameter.last_name: l_name,
                                      Parameter.email: email_id,
                                      Parameter.google_id: user_id]
        
        
        Alamofire.request(Webservice.landscaper_google_login, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        UserDefaults.standard.set("\(dict["token"]!)", forKey: "token1")
                        
                        
                        UserDefaults.standard.set("google", forKey: "logintype")
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let str_userid = "\(dict1["user_id"]!)"
                        
                        UserDefaults.standard.set(str_userid, forKey: "user_id")
                        
                        let str_servicecount = "\(dict1["service_count"]!)"
                        
                        let str_provider_status = "\(dict1["provider_status"]!)"
                        
                        if str_servicecount=="0" || str_provider_status=="0"
                        {
                            UserDefaults.standard.set("0", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "rg2") as! RegStep2
                            
                            obj.f_name="\(dict1["first_name"]!)"
                            obj.l_name="\(dict1["last_name"]!)"
                            obj.lat1=self.lat1!
                            obj.long1=self.long1!
                            
                            obj.complete_flag="1"
                            
                        self.navigationController?.pushViewController(obj, animated: true)
                        }
                        else
                        {
                            UserDefaults.standard.set("1", forKey: "session")
                            
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
                
        }
        
        
    }
    @IBAction func reg(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
//      email.text = "deb.mlindia@gmail.com"
//      pass.text = "deb@123"
        self.navigationController?.isNavigationBarHidden =  true

        email.text = ""
        pass.text = ""
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ChatViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        //  addViewOnTop()
        view.endEditing(true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
        checkfbgmail()
        // Do any additional setup after loading the view.
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let des_obj = Design()
        
        des_obj.button_round(my_view: signin_view)
        des_obj.button_round(my_view: facebook_view)
        des_obj.button_round(my_view: googleplus_view)
        
        des_obj.round_corner(my_view: logo_view,value: 12)
        des_obj.round_corner(my_view: login_view,value: 6)
        
        des_obj.red_gradient(my_view: signin_view)
        
        //        signin_lbl.frame=CGRect (x: signin_lbl.frame.origin.x, y: signin_lbl.frame.origin.y, width: signin_lbl.frame.size.width, height: signin_lbl.frame.size.height)
        //
        //        signin_view.addSubview(signin_lbl)
        
        
        des_obj.dropShadow(myview: logo_view)
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        lat1 = "\(locValue.latitude)"
        long1 = "\(locValue.longitude)"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
     //   animateTextField1(textview: textField, up: true)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
      //  animateTextField1(textview: textField, up: false)
        
        
    }
    
    
    func animateTextField1(textview:UITextField,up:Bool)
    {
        let movementDistance = -100 // tweak as needed
        let movementDuration = 0.3 // tweak as needed
        
        let movement = (up ? movementDistance : -movementDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
        
        
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

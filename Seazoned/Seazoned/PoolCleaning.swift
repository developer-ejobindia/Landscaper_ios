//
//  PoolCleaning.swift
//  Seazoned
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class PoolCleaning: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var chlorine_price: UITextField!
    @IBOutlet weak var saline_price: UITextField!
    @IBOutlet weak var spa_price: UITextField!
    @IBOutlet weak var inground_price: UITextField!
    @IBOutlet weak var above_price: UITextField!
    @IBOutlet weak var clear_price: UITextField!
    @IBOutlet weak var cloudy_price: UITextField!
    @IBOutlet weak var present_price: UITextField!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var save_view: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    var ser_id:Int!
    
    var edit_flag:String!
    var added_serid:Int!
    
    @IBOutlet weak var rec_view: UIView!
    
    @IBOutlet weak var days7: UITextField!
    
    @IBOutlet weak var days10: UITextField!
    
    @IBOutlet weak var days14: UITextField!
    
    @IBOutlet weak var SWT: UISwitch!
    
    var rec : Bool!
    
    @IBAction func VAL_CHNED(_ sender: Any) {
        
        rec = !rec
        
        if self.SWT.isOn
        {
            rec_view.isUserInteractionEnabled = true
            rec_view.alpha = 1.0
        }
        else
        {
            rec_view.isUserInteractionEnabled = true
            rec_view.alpha = 0.5
            days7.text = ""
            days10.text = ""
            days14.text = ""
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if clear_price.text=="" ||  present_price.text=="" || cloudy_price.text=="" || inground_price.text=="" || above_price.text=="" || spa_price.text=="" || chlorine_price.text=="" || saline_price.text==""{
            
            AppManager().AlertUser("", message: "Pleasae fill all the fields", vc: self)
            
        }
        else
        {
            calculation()
        }
        
    }
    
    var ruc_ary=NSMutableArray()
    var str_rucservices:String!
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true

        ruc_ary=NSMutableArray()
        let ruc_dict=NSMutableDictionary()
        ruc_dict.setValue("0", forKey: "rs")
        for _ in 0...2 {
            ruc_ary.add(ruc_dict)
        }
    }
    
    func calculation()
    {
        
        var ruc_dict=NSMutableDictionary()
        //ruc_ary=NSMutableArray()
        
        if days7.text==""
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue("0", forKey: "rs")
            ruc_ary.replaceObject(at: 0, with: ruc_dict)
        }
        else
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue(String(days7.text!), forKey: "rs")
            ruc_ary.replaceObject(at: 0, with: ruc_dict)
        }
        if days10.text==""
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue("0", forKey: "rs")
            ruc_ary.replaceObject(at: 1, with: ruc_dict)
        }
        else
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue(String(days10.text!), forKey: "rs")
            ruc_ary.replaceObject(at: 1, with: ruc_dict)
        }
        if days14.text==""
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue("0", forKey: "rs")
            ruc_ary.replaceObject(at: 2, with: ruc_dict)
        }
        else
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue(String(days14.text!), forKey: "rs")
            ruc_ary.replaceObject(at: 2, with: ruc_dict)
        }
        
        
        print("ruc ary---\(ruc_ary)")
        str_rucservices = json(from: ruc_ary)
        
        
        if edit_flag=="0"
        {
            
            SVProgressHUD.show()
            loaddata()
            
        }
        else
        {
            SVProgressHUD.show()
            loadedit()
        }
        
        
    }
    
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
    func loaddata() {
        
        let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        let params: Parameters = [Parameter.user_id: user_id,
                                  Parameter.service_id: "6",
                                  Parameter.pool_clear: clear_price.text!,
                                  Parameter.pool_heavy: present_price.text!,
            Parameter.pool_cloudy: cloudy_price.text!,
            Parameter.pool_saline: saline_price.text!,
            Parameter.pool_chlorine: chlorine_price.text!,
            Parameter.pool_inground: inground_price.text!,
            Parameter.pool_spa_hot_tub: spa_price.text!,
            Parameter.pool_above_ground: above_price.text!,
            "recurring_services":str_rucservices!]
        
        Alamofire.request(Webservice.add_lanscaper_details, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                        
                                                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                                                        alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: {alert in self.pushback()}))
                                                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                    }
                    SVProgressHUD.dismiss()
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
//        SVProgressHUD.dismiss()
        
    }
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        scroll.contentSize=CGSize (width: 0, height: rec_view.frame.origin.y+rec_view.frame.size.height+300)
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        scroll.contentSize=CGSize (width: 0, height: rec_view.frame.origin.y+rec_view.frame.size.height+65)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SWT.setOn(true, animated: true)
        self.rec = false
        self.rec_view.isUserInteractionEnabled = true
        self.rec_view.alpha = 1.0

        // Do any additional setup after loading the view.
        addDoneButtonOnKeyboard(textfield: days7)
        addDoneButtonOnKeyboard(textfield: days10)
        addDoneButtonOnKeyboard(textfield: days14)
        addDoneButtonOnKeyboard(textfield: chlorine_price)
        addDoneButtonOnKeyboard(textfield: saline_price)
        addDoneButtonOnKeyboard(textfield: spa_price)
        addDoneButtonOnKeyboard(textfield: inground_price)
        addDoneButtonOnKeyboard(textfield: above_price)
        addDoneButtonOnKeyboard(textfield: clear_price)
        addDoneButtonOnKeyboard(textfield: cloudy_price)
        addDoneButtonOnKeyboard(textfield: present_price)
        
        
        scroll.contentSize=CGSize (width: 0, height: rec_view.frame.origin.y+rec_view.frame.size.height+65)
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: save_view)
        des_obj.red_gradient(my_view: save_view)
        
        if edit_flag=="0" {
            //self.createtable()
        }
        else
        {
            SVProgressHUD.show()
            loadfetchingdata()
        }
    }

    
    func addDoneButtonOnKeyboard(textfield:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(PoolCleaning.doneButtonAction(textfield123:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(textfield123:UITextField) {
        days7.resignFirstResponder()
        days10.resignFirstResponder()
        days14.resignFirstResponder()
        chlorine_price.resignFirstResponder()
        saline_price.resignFirstResponder()
        spa_price.resignFirstResponder()
        inground_price.resignFirstResponder()
        above_price.resignFirstResponder()
        clear_price.resignFirstResponder()
        cloudy_price.resignFirstResponder()
        present_price.resignFirstResponder()
    }
    
    func loadfetchingdata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        
        
        let params: Parameters = [Parameter.added_service_id: added_serid!,
                                  Parameter.service_id: "6"]
        
        
        
        
        Alamofire.request(Webservice.view_service, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
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

                        var ary:NSArray!

                        ary = dict1["pool_water_type"] as! NSArray!

                        let grass_ary = dict1["pool_spa"] as! NSArray!

                        let grass_ary2 = dict1["pool_type"] as! NSArray!
                        let grass_ary3 = dict1["pool_state"] as! NSArray!

                        self.calculateeditdata(water_ary: ary, hot_ary: grass_ary!, pool_ary: grass_ary2!, state_ary: grass_ary3!)
                        let service_prices = dict1["service_prices"] as! NSArray!
                        if service_prices?.count == 0
                        {
                            self.SWT.setOn(false, animated: true)
                            self.rec = false
                            self.rec_view.isUserInteractionEnabled = false
                            self.rec_view.alpha = 0.5
                        }
                        else
                        {
                            self.SWT.setOn(true, animated: true)
                            self.rec = true
                            self.rec_view.isUserInteractionEnabled = true
                            self.rec_view.alpha = 1.0
                            let service_prices = dict1["service_prices"] as! NSArray!
                            
                            for i in 0...(service_prices?.count)!-1
                            {
                                let servdict = service_prices![i] as! NSDictionary
                                let service_frequency = "\(servdict["service_frequency"]!)"
                                switch service_frequency
                                {
                                case "Every 7 days":
                                    let discount_price = "\(servdict["discount_price"]!)"
                                    self.days7.text = discount_price
                                case "Every 14 days":
                                    let discount_price = "\(servdict["discount_price"]!)"
                                    self.days14.text = discount_price
                                case "Every 10 days":
                                    let discount_price = "\(servdict["discount_price"]!)"
                                    self.days10.text = discount_price
                                default:
                                    break
                                }
                                
                            }
                            if self.days7.text == "0.00" && self.days10.text == "0.00" && self.days14.text == "0.00"
                            {
                                self.SWT.setOn(false, animated: true)
                                self.rec = false
                                self.rec_view.isUserInteractionEnabled = true
                                self.rec_view.alpha = 0.5
                            }
                            else
                            {
                                self.SWT.setOn(true, animated: true)
                                self.rec = true
                                self.rec_view.isUserInteractionEnabled = true
                                self.rec_view.alpha = 1.0
                                
                            }
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
        
        //self.createtable()
        
    }
    
    func calculateeditdata(water_ary:NSArray,hot_ary:NSArray,pool_ary:NSArray,state_ary:NSArray)
    {
        
        let dict11=water_ary[0] as! NSDictionary
        let dict22=water_ary[1] as! NSDictionary
        
        
        let dict111=hot_ary[0] as! NSDictionary
        
        let dict1111=pool_ary[0] as! NSDictionary
        let dict2222=pool_ary[1] as! NSDictionary
        
        let dict11111=state_ary[0] as! NSDictionary
        let dict22222=state_ary[1] as! NSDictionary
        let dict33333=state_ary[2] as! NSDictionary
        
        chlorine_price.text="\(dict11["service_field_price"]!)"
        saline_price.text="\(dict22["service_field_price"]!)"
        
        spa_price.text="\(dict111["service_field_price"]!)"
        
        inground_price.text="\(dict1111["service_field_price"]!)"
        above_price.text="\(dict2222["service_field_price"]!)"
        
        clear_price.text="\(dict11111["service_field_price"]!)"
        cloudy_price.text="\(dict22222["service_field_price"]!)"
        present_price.text="\(dict33333["service_field_price"]!)"
        
    }
    
    @IBAction func b1(_ sender: Any) {
        if clear_price.text=="" ||  present_price.text=="" || cloudy_price.text=="" || inground_price.text=="" || above_price.text=="" || spa_price.text=="" || chlorine_price.text=="" || saline_price.text==""{
            
            AppManager().AlertUser("", message: "Pleasae fill all the fields", vc: self)
            
        }
        else
        {
        let popvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "another_view") as! second
        
        if (chlorine_price.text?.isEmpty)!
        {
            popvc.chlorine = 0
        }
        else
        {
            popvc.chlorine = Float(chlorine_price.text!)
        }
        if (saline_price.text?.isEmpty)!
        {
            popvc.Saline = 0
        }
        else
        {
            popvc.Saline = Float(saline_price.text!)
        }
        if (spa_price.text?.isEmpty)!
        {
            popvc.spa2 = 0
        }
        else
        {
            popvc.spa2 = Float(spa_price.text!)
        }
        if (inground_price.text?.isEmpty)!
        {
            popvc.Inground = 0
        }
        else
        {
            popvc.Inground = Float(inground_price.text!)
        }
        if (above_price.text?.isEmpty)!
        {
            popvc.aboveground = 0
        }
        else
        {
            popvc.aboveground = Float(above_price.text!)
        }
        if (clear_price.text?.isEmpty)!
        {
            popvc.clear = 0
        }
        else
        {
            popvc.clear = Float(clear_price.text!)
        }
        if (cloudy_price.text?.isEmpty)!
        {
            popvc.cloudy = 0
        }
        else
        {
            popvc.cloudy = Float(cloudy_price.text!)
        }
        if (present_price.text?.isEmpty)!
        {
            popvc.Algae = 0
        }
        else
        {
            popvc.Algae = Float(present_price.text!)
        }
        self.addChildViewController(popvc)
        
        popvc.view.frame = self.view.frame
        
        self.view.addSubview(popvc.view)
        
        popvc.didMove(toParentViewController: self)
        }
    }
    
    func loadedit() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.service_id: "6",
                                  Parameter.pool_clear: clear_price.text!,
                                  Parameter.pool_heavy: present_price.text!,
                                  Parameter.pool_cloudy: cloudy_price.text!,
                                  Parameter.pool_saline: saline_price.text!,
                                  Parameter.pool_chlorine: chlorine_price.text!,
                                  Parameter.pool_inground: inground_price.text!,
                                  Parameter.pool_spa_hot_tub: spa_price.text!,
                                  Parameter.pool_above_ground: above_price.text!,
                                  Parameter.added_service_id: added_serid!,
                                  "recurring_services":str_rucservices!]
        
        
        Alamofire.request(Webservice.edit_service, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                        
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: {alert in self.pushback()}))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        AppManager().AlertUser("", message: msg, vc: self)
                    }
                    SVProgressHUD.dismiss()
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                    
                }
        }
        
        //SVProgressHUD.dismiss()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scroll.contentSize=CGSize (width: 0, height: rec_view.frame.origin.y+rec_view.frame.size.height+300)
        if textField == days7
            
        {
            
            animateTextField1(textview: textField, up: true)
        }
        
        if textField == days10
            
        {
            
            animateTextField1(textview: textField, up: true)
        }
        if textField == days14
            
        {
            
            animateTextField1(textview: textField, up: true)
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        scroll.contentSize=CGSize (width: 0, height: rec_view.frame.origin.y+rec_view.frame.size.height+65)
        
        if textField == days7
            
        {
            
            animateTextField1(textview: textField, up: false)
        }
        
        if textField == days10
            
        {
            
            animateTextField1(textview: textField, up: false)
        }
        if textField == days14
            
        {
            
            animateTextField1(textview: textField, up: false)
        }
        //  animateTextField1(textview: textField, up: false)
        
        
    }
    
    
    func animateTextField1(textview:UITextField,up:Bool)
    {
        let movementDistance = -130 // tweak as needed
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

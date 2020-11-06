//
//  PopUpViewController.swift
//  PopUp
//
//  Created by Andrew Seeley on 6/06/2016.
//  Copyright © 2016 Seemu. All rights reserved.
//

import UIKit

class AddService: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet var popup_view: UIView!
    @IBOutlet weak var txt_ser: UITextField!
    @IBOutlet weak var cancel_view: UIView!
    @IBOutlet weak var ok_view: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    var ser_dict : NSDictionary!
    
    var con_ary:NSArray!
    
    var con_id:Int!
    
    var pick: UIPickerView!
    
    var pre_ary:NSArray!
    
    var org_ary = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
        
        popup_view.clipsToBounds=true
        popup_view.layer.cornerRadius=3
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: cancel_view)
    
        des_obj.button_round(my_view: ok_view)
        
        des_obj.green_gradient(my_view: ok_view)
        
        loadservices()
        picker(txt_ser)
        
    }
    
    @IBAction func ok(_ sender: Any) {
        
        removeAnimate()
        
        
        print(con_id)
        
        if   txt_ser.text == " Mowing And Edging"
        {
            con_id = 1
        }
     else   if   txt_ser.text == "Leaf Removal"
        {
            con_id = 2

        }
        
    else    if   txt_ser.text == "Lawn Treatment"
        {
            con_id = 3

        }
   else if   txt_ser.text == "Aeration"
        {
            con_id = 4

        }
       else if   txt_ser.text == "Sprinkler Winterizing"
        {
            con_id = 5

        }
    else     if   txt_ser.text == "Pool Cleaning & Upkeep"
        {
            con_id = 6

        }
       
        
        
        
        
        
        
        
        
        switch con_id {
            
            
        case 6:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "plclng") as! PoolCleaning
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 4:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "arnlwn") as! AerationOrLawn
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 3:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "arnlwn") as! AerationOrLawn
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 1:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "mwn") as! Mowing
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 5:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "spr") as! Sprikler
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 2:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lfrmvl") as! LeafRemoval
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        case 7:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "snw") as! SnowRemoval
            obj.ser_id=con_id
            obj.edit_flag="0"
            obj.added_serid=0
            self.navigationController?.pushViewController(obj, animated: true)
        default:
            break
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cancel(_ sender: AnyObject) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
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
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func loadservices()
    {
        
        let str = "\(Urls.service_list)"
        
        let urlwithPercentEscapes = str.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if let url = NSURL(string:urlwithPercentEscapes!){
            
            
            
            if let data = try? Data(contentsOf:url as URL ){
                do{
                    let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    
                    
                    print("----------\(dict)")
                    
                    con_ary = dict["data"] as! NSArray
                    
                    if pre_ary.count != 0
                    {
                        
                        let ser_idary = NSMutableArray()
                        for i in 0...pre_ary.count-1
                        {
                            let dict123 = pre_ary[i] as! NSDictionary
                          //  let str123 = dict123["service_id"] as! Int
                            
                            let ser_id_str = "\(dict123["service_id"]!)"
                            
                            // con_id = con_id_str  String
                            let str123 =  (ser_id_str as NSString).integerValue
                           // con_id = (con_id_str as NSString).integerValue
                            
                            
                            ser_idary.add(str123)
                            
                        }
                        
                        
                        for i in 0...con_ary.count-1
                        {
                            let dict123 = con_ary[i] as! NSDictionary
                          //  let str123 = dict123["id"] as! Int
                            
                            let ser_id_str1 = "\(dict123["id"]!)"
                            
                            // con_id = con_id_str  String
                            let str123  =  (ser_id_str1 as NSString).integerValue
                            
                            if ser_idary.contains(str123)
                            {
                                
                            }
                            else
                            {
                                org_ary.add(con_ary[i] as! NSDictionary)
                            }
                            
                        }
                        
                        
                        print("---orgary\(org_ary)")
                        
                        
                        
                        let dict1 = org_ary[0] as! NSDictionary
                        
                        let str_name = dict1["service_name"] as! String
                        
                       // con_id = dict1["id"] as! Int
                        
                        
                        
                        
                        txt_ser.text = str_name
                        
                    }
                    else
                    {
                        for i in 0...con_ary.count-1
                        {
                            
                                org_ary.add(con_ary[i] as! NSDictionary)
                            
                            
                        }
                        
                        let dict1 = org_ary[0] as! NSDictionary
                        
                        let str_name = dict1["service_name"] as! String
                        
                      //  con_id = dict1["id"] as! Int
                        
                        let con_id_str = "\(dict1["id"]!)"
                        
                       // con_id = con_id_str  String
                        
                        con_id = (con_id_str as NSString).integerValue
                        
                        
                        print("data-------->\(con_id)")
                        
                        //con_id  =  "\(String(describing: dict1["id"]))" as! Int
                        
                        txt_ser.text = str_name
                    }
                    
                    
                }
                catch let error as NSError{
                    print("detail of json parsing error\n\(error)")
                }
            }
            
        }
        
        
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
            return 1
    
        }
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
            return org_ary.count
    
        }
    
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    
            let dict = org_ary[row] as! NSDictionary
    
            let str_name = dict["service_name"] as! String
    
            return str_name
    
    
    
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
            let dict = org_ary[row] as! NSDictionary
    
            let str_name = dict["service_name"] as! String
    
           let  con_id_r = "\(dict["id"]!) " //as? Int
            
            
            con_id = (con_id_r as NSString).integerValue

    
            txt_ser.text = str_name
            
            ser_dict = dict
            
        }
        func picker(_ textField : UITextField){
    
            // DatePicker
            self.pick = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            self.pick.backgroundColor = UIColor.white
            textField.inputView = self.pick
    
            pick.dataSource = self
            pick.delegate = self
    
            // ToolBar
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            toolBar.sizeToFit()
    
            // Adding Button ToolBar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddService.doneClick1))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddService.cancelClick1))
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            textField.inputAccessoryView = toolBar
    
        }
    
    @objc func doneClick1() {
    
            txt_ser.resignFirstResponder()
    
            print(con_id)
    
        }
    
    @objc func cancelClick1() {
            txt_ser.resignFirstResponder()
        }

}


//
//  RegStep2.swift
//  Seazoned
//
//  Created by Apple on 15/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

import Firebase
class ServiceSettings: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate {
   
    var global_textField:UITextField!
    
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var imgvw: UIImageView!
    @IBOutlet weak var finish_view: UIView!
    
    @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var day_view: UIView!
    
    @IBOutlet weak var mon_view: UIView!
    
    @IBOutlet weak var mon_start: UITextField!
    @IBOutlet weak var mon_end: UITextField!
    
    @IBOutlet weak var tues_view: UIView!
    
    @IBOutlet weak var tues_start: UITextField!
    @IBOutlet weak var tues_end: UITextField!
    
    @IBOutlet weak var wed_view: UIView!
    
    @IBOutlet weak var wed_start: UITextField!
    @IBOutlet weak var wed_end: UITextField!
    
    @IBOutlet weak var thurs_view: UIView!
    
    @IBOutlet weak var thurs_start: UITextField!
    
    @IBOutlet weak var thurs_end: UITextField!
    
    @IBOutlet weak var fri_view: UIView!
    
    @IBOutlet weak var fri_start: UITextField!
    @IBOutlet weak var fri_end: UITextField!
    
    @IBOutlet weak var sat_view: UIView!
    
    @IBOutlet weak var sat_start: UITextField!
    @IBOutlet weak var sat_end: UITextField!
    
    @IBOutlet weak var sun_view: UIView!
    
    @IBOutlet weak var sun_start: UITextField!
    @IBOutlet weak var sun_end: UITextField!
    
    @IBOutlet weak var last_view: UIView!
    
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var v2: UIView!
    
    @IBOutlet weak var v3: UIView!
    
    
    @IBOutlet weak var v4: UIView!
    
    
    @IBOutlet weak var v5: UIView!
    
    
    @IBOutlet weak var v6: UIView!
    
    
    @IBOutlet weak var v7: UIView!
    
    @IBOutlet weak var i1: UIImageView!
    
    @IBOutlet weak var i2: UIImageView!
    
    @IBOutlet weak var i3: UIImageView!
    
    @IBOutlet weak var i4: UIImageView!
    
    @IBOutlet weak var i5: UIImageView!
    
    @IBOutlet weak var i6: UIImageView!
    
    @IBOutlet weak var i7: UIImageView!
    
    var onoff1:Int!
    var onoff2:Int!
    var onoff3:Int!
    var onoff4:Int!
    var onoff5:Int!
    var onoff6:Int!
    var onoff7:Int!
    
    @IBOutlet weak var rec_view: UIView!
    
    @IBOutlet weak var days7: UITextField!
    
    @IBOutlet weak var days10: UITextField!
    
    @IBOutlet weak var days14: UITextField!
    
    @IBOutlet weak var justonce: UITextField!
    
    @IBOutlet weak var descrip_view: UIView!
    
    @IBOutlet weak var des: UITextView!
    
    @IBOutlet weak var prov_view: UIView!
    
    @IBOutlet weak var add_btn: UIButton!
    @IBOutlet weak var add_new: UILabel!
    @IBOutlet weak var max_ser: UILabel!
    @IBOutlet weak var prov_name: UITextField!
    
    @IBOutlet weak var name: UILabel!
    
//    var f_name:String!
//    var l_name:String!
    
    var ser_ary:NSArray!
    
    var ruc_ary=NSMutableArray()
    var day_ary=NSMutableArray()
    var start_ary=NSMutableArray()
    var end_ary=NSMutableArray()
    
    var str_rucservices:String!
    var str_days:String!
    var str_starts:String!
    var str_ends:String!
    
    var datePicker1 :UIDatePicker!
    var datePicker2 :UIDatePicker!
    var datePicker3 :UIDatePicker!
    var datePicker4 :UIDatePicker!
    var datePicker5 :UIDatePicker!
    var datePicker6 :UIDatePicker!
    var datePicker7 :UIDatePicker!
    var datePicker8 :UIDatePicker!
    var datePicker9 :UIDatePicker!
    var datePicker10 :UIDatePicker!
    var datePicker11 :UIDatePicker!
    var datePicker12 :UIDatePicker!
    var datePicker13 :UIDatePicker!
    var datePicker14 :UIDatePicker!
    @IBOutlet weak var SWT: UISwitch!
    
    
    @IBOutlet weak var lbl_just_once: UILabel!
    @IBOutlet weak var lbl_14: UILabel!
    @IBOutlet weak var lbl_10: UILabel!
    @IBOutlet weak var LBL_e7: UILabel!
    
    @IBAction func VAL_CHNED(_ sender: Any) {
        
        if self.SWT.isOn
        {
            lbl_just_once.alpha = 1.0
            lbl_14.alpha = 1.0
            lbl_10.alpha = 1.0
            // lbl_w.alpha = 1.0
            LBL_e7.alpha = 1.0
            days7.isEnabled = true
            days10.isEnabled = true
            days14.isEnabled = true
            justonce.isEnabled = true
            
           
            
        }
        else
        {
            
           // lbl_just_once.alpha = 0.2
            lbl_14.alpha = 0.2
            lbl_10.alpha = 0.2
            LBL_e7.alpha = 0.2
            
            days7.isEnabled = false
            days10.isEnabled = false
            days14.isEnabled = false
           // justonce.isEnabled = false
            
            days7.text = ""
            days10.text = ""
            days14.text = ""
          //  justonce.text = ""
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addDoneButtonOnKeyboard(textfield: days7)
        addDoneButtonOnKeyboard(textfield: days10)
        addDoneButtonOnKeyboard(textfield: days14)
        addDoneButtonOnKeyboard(textfield: justonce)
        addDoneButtonOnKeyboard(textfield: distance)
        pickUpDate1(mon_start)
        pickUpDate2(mon_end)
        pickUpDate3(tues_start)
        pickUpDate4(tues_end)
        pickUpDate5(wed_start)
        pickUpDate6(wed_end)
        pickUpDate7(thurs_start)
        pickUpDate8(thurs_end)
        pickUpDate9(fri_start)
        pickUpDate10(fri_end)
        pickUpDate11(sat_start)
        pickUpDate12(sat_end)
        pickUpDate13(sun_start)
        pickUpDate14(sun_end)
        
        //name.text="\(f_name!)" + " " + "\(l_name!)"
      //  print("monstar-----\(mon_start.text!)")
        
       // self.datePicker1.setDate(from: mon_start.text! , format: "HH:mm:ss")
        

        distance.delegate = self
        
        
        scroll.layer.cornerRadius=6
        
        imgvw.clipsToBounds=true
        imgvw.layer.cornerRadius=imgvw.frame.size.width/2
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: finish_view)
        des_obj.red_gradient(my_view: finish_view)
        
        onoff1=0
        onoff2=0
        onoff3=0
        onoff4=0
        onoff5=0
        onoff6=0
        onoff7=0
        
        des.clipsToBounds=true
        des.layer.cornerRadius=3
        des.layer.borderWidth=2
        des.layer.borderColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        
        distance.placeholder="Distance you are willing to travel"
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
        if UserDefaults.standard.object(forKey: "ar_value") != nil
            
        {
            
            //   cell.backgroundColor = UIColor.red
            
            
            
            
            
            var ary = NSArray()
            
            
            
            
            
            ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
            
            
            
            
            
            
            
            let a = "\(ary)"
            
            
            
            if ary.count == 0
                
            {
                
                red_msg.isHidden = true
                
                
                
                
                
            }
                
            else
                
                
                
            {
                
                //  AppManager().AlertUser("", message: a, vc: self)
                
                
                
                red_msg.isHidden = false
                
            }
            
        }
            
            
            
        else
            
        {
            
            
            
            red_msg.isHidden = true
            
            
            
            
            
        }
        let DB_BASE = FIRDatabase.database().reference()
        
        
        let u_id  = UserDefaults.standard.value(forKey: "user_id")
        
        DB_BASE.child("notification_\(u_id!)").observe(FIRDataEventType.value, with: { (snapshot) in
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
                    
                    self.red_msg.isHidden = false
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    self.red_msg.isHidden = true
                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
        
        
        ruc_ary=NSMutableArray()
        let ruc_dict=NSMutableDictionary()
        ruc_dict.setValue("0", forKey: "rs")
        for _ in 0...3 {
            ruc_ary.add(ruc_dict)
        }
        
//        day_ary=NSMutableArray()
//        var day_dict=NSMutableDictionary()
//        day_dict.setValue("Monday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Tuesday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Wednesday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Thursday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Friday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Saturday", forKey: "day")
//        day_ary.add(day_dict)
//        day_dict=NSMutableDictionary()
//        day_dict.setValue("Sunday", forKey: "day")
//        day_ary.add(day_dict)
        
        //print("day ary---\(day_ary)")
        
        
        tbl.dataSource=nil
        SVProgressHUD.show()
        loaddata()
        SVProgressHUD.show()
        loadhours()
        
        
        
       

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: picker1
    
    func pickUpDate1(_ textField : UITextField){
        
        // DatePicker
        self.datePicker1 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker1.backgroundColor = UIColor.white
        self.datePicker1.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker1
        
        
      

        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick1() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        mon_start.text = AppManager().timeformatter(str_date: dateFormatter1.string(from: datePicker1.date))
        
        mon_start.resignFirstResponder()
        
    }
    
    
    //MARK: picker2
    
    func pickUpDate2(_ textField : UITextField){
        
        // DatePicker
        self.datePicker2 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker2.backgroundColor = UIColor.white
        self.datePicker2.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker2
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick2() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        mon_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker2.date))
        
        
        mon_end.resignFirstResponder()
        
    }
    
    
    
    //MARK: picker3
    
    func pickUpDate3(_ textField : UITextField){
        
        // DatePicker
        self.datePicker3 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker3.backgroundColor = UIColor.white
        self.datePicker3.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker3
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick3))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick3() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        tues_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker3.date))
        
        
        
        tues_start.resignFirstResponder()
        
    }
    
    
    
    //MARK: picker4
    
    func pickUpDate4(_ textField : UITextField){
        
        // DatePicker
        self.datePicker4 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker4.backgroundColor = UIColor.white
        self.datePicker4.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker4
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick4))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick4() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        tues_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker4.date))
        
        
        
        tues_end.resignFirstResponder()
        
    }
    
    
    
    //MARK: picker5
    
    func pickUpDate5(_ textField : UITextField){
        
        // DatePicker
        self.datePicker5 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker5.backgroundColor = UIColor.white
        self.datePicker5.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker5
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick5))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick5() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        wed_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker5.date))
        
        
       
        wed_start.resignFirstResponder()
        
    }
    
    
    //MARK: picker6
    
    func pickUpDate6(_ textField : UITextField){
        
        // DatePicker
        self.datePicker6 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker6.backgroundColor = UIColor.white
        self.datePicker6.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker6
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick6))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick6() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        wed_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker6.date))
        
        
       
        wed_end.resignFirstResponder()
        
    }
    
    
    
    //MARK: picker7
    
    func pickUpDate7(_ textField : UITextField){
        
        // DatePicker
        self.datePicker7 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker7.backgroundColor = UIColor.white
        self.datePicker7.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker7
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick7))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick7() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        thurs_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker7.date))
        
        
        
        thurs_start.resignFirstResponder()
        
    }
    
    
    
    //MARK: picker8
    
    func pickUpDate8(_ textField : UITextField){
        
        // DatePicker
        self.datePicker8 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker8.backgroundColor = UIColor.white
        self.datePicker8.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker8
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick8))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick8() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        thurs_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker8.date))
        
        
        
        thurs_end.resignFirstResponder()
        
    }
    
    
    //MARK: picker9
    
    func pickUpDate9(_ textField : UITextField){
        
        // DatePicker
        self.datePicker9 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker9.backgroundColor = UIColor.white
        self.datePicker9.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker9
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick9))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick9() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        fri_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker9.date))
        
        
        
        fri_start.resignFirstResponder()
        
    }
    
    //MARK: picker10
    
    func pickUpDate10(_ textField : UITextField){
        
        // DatePicker
        self.datePicker10 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker10.backgroundColor = UIColor.white
        self.datePicker10.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker10
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick10))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick10() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        fri_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker10.date))
        
        
        
        fri_end.resignFirstResponder()
        
    }
    
    //MARK: picker11
    
    func pickUpDate11(_ textField : UITextField){
        
        // DatePicker
        self.datePicker11 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker11.backgroundColor = UIColor.white
        self.datePicker11.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker11
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick11))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick11() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        sat_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker11.date))
        
        
        
        sat_start.resignFirstResponder()
        
    }
    
    //MARK: picker12
    
    func pickUpDate12(_ textField : UITextField){
        
        // DatePicker
        self.datePicker12 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker12.backgroundColor = UIColor.white
        self.datePicker12.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker12
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick12))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick12() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        sat_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker12.date))
        
        
        
        sat_end.resignFirstResponder()
        
    }
    
    //MARK: picker13
    
    func pickUpDate13(_ textField : UITextField){
        
        // DatePicker
        self.datePicker13 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker13.backgroundColor = UIColor.white
        self.datePicker13.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker13
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick13))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick13() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        sun_start.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker13.date))
        
        
        
        sun_start.resignFirstResponder()
        
    }
    
    //MARK: picker14
    
    func pickUpDate14(_ textField : UITextField){
        
        // DatePicker
        self.datePicker14 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker14.backgroundColor = UIColor.white
        self.datePicker14.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker14
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegStep2.doneClick14))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegStep2.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneClick14() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="HH:mm:ss"
        
        sun_end.text = AppManager().timeformatter(str_date:dateFormatter1.string(from: datePicker14.date))
        
        
        
        sun_end.resignFirstResponder()
    }
    
    
    func cancelClick() {
        mon_start.resignFirstResponder()
        mon_end.resignFirstResponder()
        tues_start.resignFirstResponder()
        tues_end.resignFirstResponder()
        wed_start.resignFirstResponder()
        wed_end.resignFirstResponder()
        thurs_start.resignFirstResponder()
        thurs_end.resignFirstResponder()
        fri_start.resignFirstResponder()
        fri_end.resignFirstResponder()
        sat_start.resignFirstResponder()
        sat_end.resignFirstResponder()
        sun_start.resignFirstResponder()
        sun_end.resignFirstResponder()
    }
    
    @IBAction func check(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if onoff1==0
            {
                v1.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i1.image=UIImage (named: "tick.png")
                mon_view.isHidden=false
                onoff1=1
                doneClick1()
                doneClick2()
            }
            else
            {
                v1.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i1.image=UIImage (named: "")
                mon_view.isHidden=true
                onoff1=0
                mon_start.text=""
                mon_end.text=""
            }
            break
        case 2:
            if onoff2==0
            {
                v2.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i2.image=UIImage (named: "tick.png")
                tues_view.isHidden=false
                onoff2=1
                doneClick3()
                doneClick4()
            }
            else
            {
                v2.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i2.image=UIImage (named: "")
                tues_view.isHidden=true
                onoff2=0
                tues_start.text=""
                tues_end.text=""
            }
            break
        case 3:
            if onoff3==0
            {
                v3.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i3.image=UIImage (named: "tick.png")
                wed_view.isHidden=false
                onoff3=1
                doneClick5()
                doneClick6()
            }
            else
            {
                v3.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i3.image=UIImage (named: "")
                wed_view.isHidden=true
                onoff3=0
                wed_start.text=""
                wed_end.text=""
            }
            break
        case 4:
            if onoff4==0
            {
                v4.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i4.image=UIImage (named: "tick.png")
                thurs_view.isHidden=false
                onoff4=1
                doneClick7()
                doneClick8()
            }
            else
            {
                v4.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i4.image=UIImage (named: "")
                thurs_view.isHidden=true
                onoff4=0
                thurs_start.text=""
                thurs_end.text=""
            }
            break
        case 5:
            if onoff5==0
            {
                v5.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i5.image=UIImage (named: "tick.png")
                fri_view.isHidden=false
                onoff5=1
                doneClick9()
                doneClick10()
            }
            else
            {
                v5.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i5.image=UIImage (named: "")
                fri_view.isHidden=true
                onoff5=0
                fri_start.text=""
                fri_end.text=""
            }
            break
        case 6:
            if onoff6==0
            {
                v6.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i6.image=UIImage (named: "tick.png")
                sat_view.isHidden=false
                onoff6=1
                doneClick11()
                doneClick12()
            }
            else
            {
                v6.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i6.image=UIImage (named: "")
                sat_view.isHidden=true
                onoff6=0
                sat_start.text=""
                sat_end.text=""
            }
            break
        case 7:
            if onoff7==0
            {
                v7.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i7.image=UIImage (named: "tick.png")
                sun_view.isHidden=false
                onoff7=1
                doneClick13()
                doneClick14()
            }
            else
            {
                v7.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i7.image=UIImage (named: "")
                sun_view.isHidden=true
                onoff7=0
                sun_start.text=""
                sun_end.text=""
            }
            break
        default:
            break
        }
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
        
        // print(token)
        
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        
        
        let params: Parameters = [Parameter.user_id: user_id]
        
        
        Alamofire.request(Webservice.view_added_services, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            
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
                        
                        self.ser_ary = dict1["servies"] as! NSArray
                        
                        self.tbl.dataSource=self
                        self.tbl.reloadData()
                        self.createtable()
                        
                        if self.ser_ary.count==7
                        {
                            self.add_btn.isEnabled=false
                            self.add_new.alpha=0.3
                            self.max_ser.isHidden=false
                        }
                        else
                        {
                            self.add_btn.isEnabled=true
                            self.add_new.alpha=1
                            self.max_ser.isHidden=true
                        }
                        
                    }
                    else
                    {
                        self.tbl.dataSource=nil
                        self.add_btn.isEnabled=true
                        self.add_new.alpha=1
                        self.max_ser.isHidden=true
                        self.ser_ary = []
                        self.createtable()
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    func createtable()  {
        
        tbl.frame = CGRect (x: 0, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: 60*CGFloat(ser_ary.count))
        prov_view.frame = CGRect (x: 0, y: tbl.frame.origin.y+tbl.frame.size.height, width: prov_view.frame.size.width, height: prov_view.frame.size.height)
        day_view.frame = CGRect (x: 0, y: prov_view.frame.origin.y+prov_view.frame.size.height, width: day_view.frame.size.width, height: day_view.frame.size.height)
//        rec_view.frame = CGRect (x: 0, y: day_view.frame.origin.y+day_view.frame.size.height, width: rec_view.frame.size.width, height: rec_view.frame.size.height)
        descrip_view.frame = CGRect (x: 0, y: day_view.frame.origin.y+day_view.frame.size.height, width: descrip_view.frame.size.width, height: descrip_view.frame.size.height)
        last_view.frame = CGRect (x: 0, y: descrip_view.frame.origin.y+descrip_view.frame.size.height, width: last_view.frame.size.width, height: last_view.frame.size.height)
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height+10)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ser_ary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sercell") as! ServiceCell
        let dict = ser_ary[indexPath.row] as! NSDictionary
        cell.ser_name.text=dict["service_name"] as? String
        cell.btn.tag=indexPath.row
        cell.btn.addTarget(self, action: #selector(alertpopup(sender:)), for: .touchUpInside)
       // let str_serid = dict["service_id"] as! Int
        
        let str_serid1 = "\(dict["service_id"]!)"
        
        
        let str_serid = (str_serid1 as NSString).integerValue

        imageadding(ser_id: str_serid, cellimg: cell.imgvw)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    @IBAction func alertpopup(sender:UIButton)
    {
        let dict = ser_ary[sender.tag] as! NSDictionary
       // let ser_id = dict["added_service_id"] as! Int
        
        let ser_id1 = "\(dict["added_service_id"]!)"
        
        
        let ser_id = (ser_id1 as NSString).integerValue
        let alert = UIAlertController (title: "", message: "What Do You Want To Perform", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction (title: "Edit Service", style: .default, handler: {alert in self.editservice(dict: dict)}))
        alert.addAction(UIAlertAction (title: "Delete Service", style: .destructive, handler: {alert in self.deleteservice(dict: dict)}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteservice(dict:NSDictionary)
    {
        //let dict = ser_ary[sender.tag] as! NSDictionary
        //let ser_id = dict["added_service_id"] as! Int
        
        
        
        let ser_id1 = "\(dict["added_service_id"]!)"
        
        
        let ser_id = (ser_id1 as NSString).integerValue
        let alert = UIAlertController (title: "Message", message: "Do You Want to Delete This Service?", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction (title: "Delete", style: .destructive, handler: {alert in
            SVProgressHUD.show(withStatus: "Deleting Added Service...")
            self.loaddelete(str_id: String(ser_id))}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func loaddelete(str_id:String)
    {
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        
        
        let params: Parameters = [Parameter.added_service_id: str_id]
        
        
        Alamofire.request(Webservice.delete_added_services, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            
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
                        
                        
                        //                        let dict1 = dict["data"] as! NSDictionary
                        //
                        //                        self.ser_ary = dict1["servies"] as! NSArray
                        //
                        //                        self.tbl.dataSource=self
                        //                        self.tbl.reloadData()
                        //                        self.createtable()
                        
                        SVProgressHUD.show()
                        self.loaddata()
                        
                    }
                    else
                    {
                        //self.tbl.dataSource=nil
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                    }
                    
                    AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
    }
    
    @IBAction func editservice(dict:NSDictionary)
    {
        
        let con_id:Int!
        
      //  con_id=dict["service_id"] as! Int
        
        
        let ser_id12 = "\(dict["service_id"]!)"
        
        
        con_id = (ser_id12 as NSString).integerValue
        
      //  let added_serid=dict["added_service_id"] as! Int
        
        let added_serid1 = "\(dict["added_service_id"]!)"
        
        
         let added_serid = (added_serid1 as NSString).integerValue
        
        
        switch con_id {
        case 6:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "plclng") as! PoolCleaning
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 4:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "arnlwn") as! AerationOrLawn
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 3:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "arnlwn") as! AerationOrLawn
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 1:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "mwn") as! Mowing
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 5:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "spr") as! Sprikler
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 2:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lfrmvl") as! LeafRemoval
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        case 7:
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "snw") as! SnowRemoval
            obj.ser_id=con_id
            obj.edit_flag="1"
            obj.added_serid=added_serid
            self.navigationController?.pushViewController(obj, animated: true)
        default:
            break
        }
    }
    
    func imageadding(ser_id:Int,cellimg:UIImageView)
    {
        switch ser_id {
        case 1:
            
            cellimg.image = UIImage (named: "person-mowing-the-grass.png")
            
            break
            
        case 2:
            
            cellimg.image = UIImage (named: "herbal-spa-treatment-leaves.png")
            
            break
            
        case 3:
            
            cellimg.image = UIImage (named: "seeds.png")
            
            break
            
        case 4:
            
            cellimg.image = UIImage (named: "aeration.png")
            
            break
            
        case 5:
            
            cellimg.image = UIImage (named: "sprinkler.png")
            
            break
            
        case 6:
            
            cellimg.image = UIImage (named: "swimming-pool-ladder.png")
            
            break
            
        case 7:
            
            cellimg.image = UIImage (named: "worker-with-shovel.png")
            
            break
            
        default:
            break
        }
    }
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBAction func finish(_ sender: Any) {
        
        let distance1 = Int(distance.text!)
        
        if prov_name.text=="" {
            AppManager().AlertUser("Warning", message: "Please Add Provider Name", vc: self)
        }
        else if onoff1==0 && onoff2==0 && onoff3==0 && onoff4==0 && onoff5==0 && onoff6==0 && onoff7==0
        {
            AppManager().AlertUser("Warning", message: "Please Select Service Hours", vc: self)
        }
//        else if days7.text=="" || days10.text=="" || days14.text==""
//            || justonce.text==""
//        {
//            AppManager().AlertUser("Warning", message: "Please Fill All The Recurring Service Prices", vc: self)
//        }
            
//        else if
//            justonce.text==""
//        {
//            AppManager().AlertUser("Warning", message: "Please Fill justonce Recurring Service Price", vc: self)
//        }
        else if distance.text==""
        {
            AppManager().AlertUser("Warning", message: "Please Enter Distance", vc: self)
        }
        else if distance1! < 1 || distance1! > 50
        {
            AppManager().AlertUser("Warning", message: "Please Enter Distance Between 1 - 50 miles", vc: self)
        }
        else
        {
            
            calculation()
            
        }
        
        
    }
    
    func loadhours() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
        
        // print(token)
        
                let headers: HTTPHeaders = [
                    "token": token as! String,
        
                    ]
        
        
        //let params: Parameters = [Parameter.user_id: user_id]
        
        
        Alamofire.request(Webservice.view_service_hours_and_others, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
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
                        self.prov_name.text = "\(dict1["provider_name"]!)"
                        self.des.text = "\(dict1["description"]!)"
                        let distance_provided = "\(dict1["distance_provided"]!)"
                        self.distance.text =  "\(distance_provided)"
                        self.hourscalculation(dict: dict1)
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
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
    
    func hourscalculation(dict:NSDictionary)
    {
        let price_ary = dict["service_prices"] as! NSArray
        
        
        if price_ary.count != 0
        {
            
            
            SWT.setOn(true, animated: true)
        
        let dict1 = price_ary[0] as! NSDictionary
        let dict2 = price_ary[1] as! NSDictionary
        let dict3 = price_ary[2] as! NSDictionary
        let dict4 = price_ary[3] as! NSDictionary
        
        days7.text="\(dict1["discount_price"]!)"
        days10.text="\(dict2["discount_price"]!)"
        days14.text="\(dict3["discount_price"]!)"
        justonce.text="\(dict4["discount_price"]!)"
        
        if days7.text == "0.00" &&  days10.text == "0.00" &&  days14.text == "0.00"
        {
            
            
            SWT.setOn(false, animated: true)
            
        
            
            
     
            
            // lbl_just_once.alpha = 0.2
            lbl_14.alpha = 0.2
            lbl_10.alpha = 0.2
            LBL_e7.alpha = 0.2
            
            days7.isEnabled = false
            days10.isEnabled = false
            days14.isEnabled = false
            // justonce.isEnabled = false
            
            days7.text = ""
            days10.text = ""
            days14.text = ""
            //  justonce.text = ""
            
            
            
            
            
            
            
            
            
            
            
        }
        else
        
        {
            
            SWT.setOn(true, animated: true)

            lbl_just_once.alpha = 1.0
            lbl_14.alpha = 1.0
            lbl_10.alpha = 1.0
            // lbl_w.alpha = 1.0
            LBL_e7.alpha = 1.0
            days7.isEnabled = true
            days10.isEnabled = true
            days14.isEnabled = true
            justonce.isEnabled = true
            
        }
            
            
        }
        else
        {
            
            SWT.setOn(false, animated: true)
            
            lbl_14.alpha = 0.2
            lbl_10.alpha = 0.2
            LBL_e7.alpha = 0.2
            
            days7.isEnabled = false
            days10.isEnabled = false
            days14.isEnabled = false
            // justonce.isEnabled = false
            
            days7.text = ""
            days10.text = ""
            days14.text = ""
            //  justonce.text = ""

            
        }
        let hours_ary = dict["service_hours"] as! NSArray
        
        
        
        var hrs_ary = NSMutableArray()
        
        if hours_ary.count > 0 {
            
            for i in 0...hours_ary.count-1 {
                let hrs_dict=hours_ary[i] as! NSDictionary
                let str = "\(hrs_dict["service_day"]!)"
                hrs_ary.add(str)
                
                if str=="Monday"
                {
                    mon_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    mon_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    
                    
                    print("ggggggg\( mon_start.text!)")
                    
                    datePicker1.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker2.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")

                }
                else if str=="Tuesday"
                {
                    tues_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    tues_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    
                    datePicker3.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker4.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else if str=="Wednesday"
                {
                    wed_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    wed_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    
                    datePicker5.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker6.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else if str=="Thursday"
                {
                    thurs_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    thurs_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    datePicker7.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker8.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else if str=="Friday"
                {
                    fri_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    fri_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    datePicker9.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker10.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else if str=="Saturday"
                {
                    sat_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    sat_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    datePicker11.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker12.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else if str=="Sunday"
                {
                    sun_start.text=AppManager().timeformatter(str_date: "\(hrs_dict["start_time"]!)")
                    sun_end.text=AppManager().timeformatter(str_date: "\(hrs_dict["end_time"]!)")
                    datePicker13.setDate(from: "\(hrs_dict["start_time"]!)", format: "HH:mm:ss")
                    datePicker14.setDate(from: "\(hrs_dict["end_time"]!)", format: "HH:mm:ss")
                }
                else
                {
                    
                }
                
                
                
                
     
                
            }
            
            print("hrsary---\(hrs_ary)")
            
            //var new_ary = NSMutableArray()
            
            if hrs_ary.contains("Monday")
            {
                v1.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i1.image=UIImage (named: "tick.png")
                mon_view.isHidden=false
                onoff1=1
                
            }
            else
            {
                v1.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i1.image=UIImage (named: "")
                mon_view.isHidden=true
                onoff1=0
            }
            if hrs_ary.contains("Tuesday")
            {
                v2.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i2.image=UIImage (named: "tick.png")
                tues_view.isHidden=false
                onoff2=1
            }
            else
            {
                v2.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i2.image=UIImage (named: "")
                tues_view.isHidden=true
                onoff2=0
            }
            if hrs_ary.contains("Wednesday")
            {
                v3.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i3.image=UIImage (named: "tick.png")
                wed_view.isHidden=false
                onoff3=1
            }
            else
            {
                v3.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i3.image=UIImage (named: "")
                wed_view.isHidden=true
                onoff3=0
            }
            if hrs_ary.contains("Thursday")
            {
                v4.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i4.image=UIImage (named: "tick.png")
                thurs_view.isHidden=false
                onoff4=1
            }
            else
            {
                v4.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i4.image=UIImage (named: "")
                thurs_view.isHidden=true
                onoff4=0
            }
            if hrs_ary.contains("Friday")
            {
                v5.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i5.image=UIImage (named: "tick.png")
                fri_view.isHidden=false
                onoff5=1
            }
            else
            {
                v5.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i5.image=UIImage (named: "")
                fri_view.isHidden=true
                onoff5=0
            }
            if hrs_ary.contains("Saturday")
            {
                v6.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i6.image=UIImage (named: "tick.png")
                sat_view.isHidden=false
                onoff6=1
            }
            else
            {
                v6.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i6.image=UIImage (named: "")
                sat_view.isHidden=true
                onoff6=0
            }
            if hrs_ary.contains("Sunday")
            {
                v7.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                i7.image=UIImage (named: "tick.png")
                sun_view.isHidden=false
                onoff7=1
            }
            else
            {
                v7.backgroundColor=UIColor (red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                i7.image=UIImage (named: "")
                sun_view.isHidden=true
                onoff7=0
            }
            
            
            
            
        }
        else
        {
            
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
        if justonce.text==""
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue("0", forKey: "rs")
            ruc_ary.replaceObject(at: 3, with: ruc_dict)
        }
        else
        {
            ruc_dict=NSMutableDictionary()
            ruc_dict.setValue(String(justonce.text!), forKey: "rs")
            ruc_ary.replaceObject(at: 3, with: ruc_dict)
        }
        
        print("ruc ary---\(ruc_ary)")
        
        day_ary=NSMutableArray()
        var day_dict=NSMutableDictionary()
        start_ary=NSMutableArray()
        var start_dict=NSMutableDictionary()
        end_ary=NSMutableArray()
        var end_dict=NSMutableDictionary()
        if onoff1==0 {
            //day_ary.removeObject(at: 0)
        }
        else
        {
            day_dict=NSMutableDictionary()
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date: mon_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:mon_end.text!), forKey: "e")
            day_dict.setValue("Monday", forKey: "day")
            //day_ary.replaceObject(at: 0, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff2==0 {
            //day_ary.removeObject(at: 1)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Tuesday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:tues_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:tues_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 1, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff3==0 {
            //day_ary.removeObject(at: 2)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Wednesday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:wed_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:wed_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 2, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff4==0 {
            //day_ary.removeObject(at: 3)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Thursday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:thurs_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:thurs_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 3, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff5==0 {
            //day_ary.removeObject(at: 4)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Friday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:fri_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:fri_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 4, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff6==0 {
            //day_ary.removeObject(at: 5)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Saturday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:sat_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:sat_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 5, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        if onoff7==0 {
            //day_ary.removeObject(at: 6)
        }
        else
        {
            day_dict=NSMutableDictionary()
            day_dict.setValue("Sunday", forKey: "day")
            start_dict=NSMutableDictionary()
            end_dict=NSMutableDictionary()
            start_dict.setValue(AppManager().timeformatterreverse(str_date:sun_start.text!), forKey: "s")
            end_dict.setValue(AppManager().timeformatterreverse(str_date:sun_end.text!), forKey: "e")
            //day_ary.replaceObject(at: 6, with: day_dict)
            day_ary.add(day_dict)
            start_ary.add(start_dict)
            end_ary.add(end_dict)
        }
        
        print("day ary---\(day_ary)")
        print("start ary---\(start_ary)")
        print("end ary---\(end_ary)")
        
        str_rucservices = json(from: ruc_ary)
        str_days = json(from: day_ary)
        str_starts = json(from: start_ary)
        str_ends = json(from: end_ary)
        
        //print("---------\(str_days!)")
        
        SVProgressHUD.show(withStatus: "Updating Your Profile...")
        loadfinish()
        
    }
    
    //MARK: Jsonreprestation
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func loadfinish() {
        
        let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,

            ]
        
        let params: Parameters = [Parameter.provider_name: prov_name.text!,
                                  Parameter.description: des.text!,
                                  Parameter.days: str_days!,
                                  Parameter.start: str_starts!,"distance_provided" : "\(distance.text!)",
                                  Parameter.end: str_ends!,
                                  ]
        
        Alamofire.request(Webservice.edit_service_hours_and_others, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
    
    @IBAction func back(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pushback()
    {
//        let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
//        self.navigationController?.pushViewController(obj, animated: false)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBOutlet weak var tbl: UITableView!
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height+300)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height+10)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height+300)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height+10)
    }
    @IBAction func add(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adsrvc") as! AddService
        popOverVC.pre_ary=ser_ary
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    func addDoneButtonOnKeyboard(textfield:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegStep2.doneButtonAction(textfield123:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
    }
    func doneButtonAction(textfield123:UITextField) {
        days7.resignFirstResponder()
        days10.resignFirstResponder()
        days14.resignFirstResponder()
        justonce.resignFirstResponder()
        distance.resignFirstResponder()
    }
    
    //MARK: Tabbar
    
    @IBAction func tabbar(_ sender: UIButton) {
        
        //Help
        if sender.tag==0 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "faq") as! faq
            self.navigationController?.pushViewController(obj, animated: false)
            
        }
            //Message
        else if sender.tag==1 {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "clst") as! Chatlist
            self.navigationController?.pushViewController(obj, animated: false)
        }
            //Home
        else if sender.tag==2 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
            self.navigationController?.pushViewController(obj, animated: false)
            
        }
            //Contact Us
        else if sender.tag==3 {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "contuct") as! contuct
            self.navigationController?.pushViewController(obj, animated: false)
        }
            //Profile
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
            self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
        
        
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
extension UIDatePicker {
    
    func setDate(from string: String, format: String, animated: Bool = true) {
        
        let formater = DateFormatter()
        
        formater.dateFormat = format
        
        let date = formater.date(from: string) ?? Date()
        
        setDate(date, animated: animated)
    }
}

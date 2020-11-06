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

class SnowRemoval: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var frstcar: UITextField!
    @IBOutlet weak var nxtcar: UITextField!
    @IBOutlet weak var uppr: UITextField!
    
    @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var strght: UITextField!
    
    @IBOutlet weak var crclr: UITextField!
    @IBOutlet weak var save_view: UIView!
    @IBOutlet weak var incln: UITextField!
    
    @IBOutlet weak var front: UITextField!
    
    @IBOutlet weak var strairs: UITextField!
    @IBOutlet weak var side: UITextField!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    
    
    var ser_id:Int!
    
    var edit_flag:String!
    var added_serid:Int!
    
    var first : Float!
    var next2 : Float!
    var limit : Float!
    var Straight : Float!
    var Circular: Float!
    var Incline : Float!
    var Front : Float!
    var Stairs : Float!
    var Slide : Float!
    var price=[Int]()
    var car=[Int]()
    var x : Float!
    var a : Float!
    var b : Float!
    var c : Float!
    var d : Float!
    var drive=[String]()
    var Service=[String]()
    
    @IBOutlet weak var price_view: UIView!
    
    @IBOutlet weak var tbl: UITableView!
    
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
            rec_view.isUserInteractionEnabled = false
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
        
        let value = Int(uppr.text!)

        if frstcar.text=="" ||  nxtcar.text=="" || uppr.text=="" || strght.text=="" || crclr.text=="" || incln.text=="" || front.text=="" || strairs.text=="" || side.text==""{
            
            AppManager().AlertUser("", message: "Pleasae fill all the fields", vc: self)
            
        }
        else if value!%2 != 0{
//            AppManager().AlertUser("", message: "Upper Limit must be Multiple of 2", vc: self)
            
               AppManager().AlertUser("", message: "Maximum number must be Multiple of 2", vc: self)
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
                                  Parameter.service_id: "7",
                                  Parameter.first_car: frstcar.text!,
                                  Parameter.next_car: nxtcar.text!,
                                  Parameter.car_limit: uppr.text!,
                                  Parameter.straight: strght.text!,
                                  Parameter.circular: crclr.text!,
                                  Parameter.incline: incln.text!,
                                  Parameter.front_door: front.text!,
                                  Parameter.stairs: strairs.text!,
                                  Parameter.side_door: side.text!,
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
        
        //SVProgressHUD.dismiss()
        
    }
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: side.frame.origin.y+side.frame.size.height+300)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //scroll.contentSize=CGSize (width: 0, height: side.frame.origin.y+side.frame.size.height+10)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SWT.setOn(false, animated: true)
        self.rec = false
        self.rec_view.isUserInteractionEnabled = false
        self.rec_view.alpha = 0.5

        // Do any additional setup after loading the view.
        
        addDoneButtonOnKeyboard(textfield: days7)
        addDoneButtonOnKeyboard(textfield: days10)
        addDoneButtonOnKeyboard(textfield: days14)
        addDoneButtonOnKeyboard(textfield: frstcar)
        addDoneButtonOnKeyboard(textfield: nxtcar)
        addDoneButtonOnKeyboard(textfield: uppr)
        addDoneButtonOnKeyboard(textfield: strght)
        addDoneButtonOnKeyboard(textfield: crclr)
        addDoneButtonOnKeyboard(textfield: incln)
        addDoneButtonOnKeyboard(textfield: front)
        addDoneButtonOnKeyboard(textfield: strairs)
        addDoneButtonOnKeyboard(textfield: side)
        scroll.contentSize=CGSize (width: 0, height: side.frame.origin.y+side.frame.size.height+50)
        
//        if ser_id==4
//        {
//            headline.text="Aeration"
//        }
//        else
//        {
//            headline.text="Lawn Treatment"
//        }
        
        price_view.isHidden=true
        
        if edit_flag=="0" {
            self.createtable()
        }
        else
        {
            SVProgressHUD.show()
            loadfetchingdata()
        }
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: save_view)
        des_obj.red_gradient(my_view: save_view)
        
        tbl.dataSource=nil
        
        
    }
    
    func loadfetchingdata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        
        
        let params: Parameters = [Parameter.added_service_id: added_serid!,
                                  Parameter.service_id: "7"]
        
        
        
        
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

                        ary = dict1["snow_car"] as! NSArray!

                        let grass_ary = dict1["snow_driveway_type"] as! NSArray!
                        
                        let grass_ary2 = dict1["snow_service_type"] as! NSArray!

                      self.calculateeditdata(car_ary: ary, drive_ary: grass_ary!, service_ary: grass_ary2!)
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
                                self.rec_view.isUserInteractionEnabled = false
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
        
        self.createtable()
        
    }
    
    func calculateeditdata(car_ary:NSArray,drive_ary:NSArray,service_ary:NSArray)
    {
        
        
        let dict1=car_ary[0] as! NSDictionary
      //  let dict2=car_ary[1] as! NSDictionary
        
        
        print(car_ary)
      //  print(dict2)
        
        frstcar.text="\(dict1["service_field_price"]!)"
        
        let f1 = "\(dict1["service_field_price"]!)"
//        let f2 = "\(dict2["service_field_price"]!)"
//
       let f11 = Float(f1)
//        let f22 = Float(f2)
//
//        let f111 = f22! - f11!
//
//        nxtcar.text="\(f111)"
        
         nxtcar.text="\(f11!)"
        
        let dictn=car_ary[car_ary.count-1] as! NSDictionary
        
        uppr.text="\(dictn["service_field_value"]!)"
        
        let dict11=drive_ary[0] as! NSDictionary
        let dict22=drive_ary[1] as! NSDictionary
        let dict33=drive_ary[2] as! NSDictionary
        
        let dict111=service_ary[0] as! NSDictionary
        let dict222=service_ary[1] as! NSDictionary
        let dict333=service_ary[2] as! NSDictionary
        
        
        strght.text="\(dict11["service_field_price"]!)"
        crclr.text="\(dict22["service_field_price"]!)"
        incln.text="\(dict33["service_field_price"]!)"
        
        front.text="\(dict111["service_field_price"]!)"
        strairs.text="\(dict222["service_field_price"]!)"
        side.text="\(dict333["service_field_price"]!)"
        
    }
    
    func loadedit() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.service_id: "7",
                                  Parameter.first_car: frstcar.text!,
                                  Parameter.next_car: nxtcar.text!,
                                  Parameter.car_limit: uppr.text!,
                                  Parameter.straight: strght.text!,
                                  Parameter.circular: crclr.text!,
                                  Parameter.incline: incln.text!,
                                  Parameter.front_door: front.text!,
                                  Parameter.stairs: strairs.text!,
                                  Parameter.side_door: side.text!,
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
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDoneButtonOnKeyboard(textfield:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SnowRemoval.doneButtonAction(textfield123:)))
        
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
        frstcar.resignFirstResponder()
        nxtcar.resignFirstResponder()
        uppr.resignFirstResponder()
        strght.resignFirstResponder()
        crclr.resignFirstResponder()
        incln.resignFirstResponder()
        front.resignFirstResponder()
        strairs.resignFirstResponder()
        side.resignFirstResponder()
    }
    
    @IBAction func b1(_ sender: Any) {
          let value = Int(uppr.text!)
        if frstcar.text=="" ||  nxtcar.text=="" || uppr.text=="" || strght.text=="" || crclr.text=="" || incln.text=="" || front.text=="" || strairs.text=="" || side.text==""{
            
            AppManager().AlertUser("", message: "Pleasae fill all the fields", vc: self)
            
        }
//        else if value!%2 != 0{
//            //            AppManager().AlertUser("", message: "Upper Limit must be Multiple of 2", vc: self)
//
//            AppManager().AlertUser("", message: "Maximum number must be Multiple of 2", vc: self)
//        }
        
        else
        {
        
        
        if (frstcar.text?.isEmpty)!
        {
            first = 0
        }
        else
        {
            first = Float(frstcar.text!)
        }
        if (nxtcar.text?.isEmpty)!
        {
            next2 = 0
        }
        else
        {
            next2 = Float(nxtcar.text!)
        }
        if (uppr.text?.isEmpty)!
        {
            limit = 0
        }
        else
        {
            limit = Float(uppr.text!)
        }
        if (strght.text?.isEmpty)!
        {
            Straight = 0
        }
        else
        {
            Straight = Float(strght.text!)
        }
        if (crclr.text?.isEmpty)!
        {
            Circular = 0
        }
        else
        {
            Circular = Float(crclr.text!)
        }
        if (incln.text?.isEmpty)!
        {
            Incline = 0
        }
        else
        {
            Incline = Float(incln.text!)
        }
        if (front.text?.isEmpty)!
        {
            Front = 0
        }
        else
        {
            Front = Float(front.text!)
        }
        if (strairs.text?.isEmpty)!
        {
            Stairs = 0
        }
        else
        {
            Stairs = Float(strairs.text!)
        }
        if (side.text?.isEmpty)!
        {
            Slide = 0
        }
        else
        {
            Slide = Float(side.text!)
        }
        
        price=[Int]()
        car=[Int]()
        drive=[String]()
        Service=[String]()
        x = 2
        c = 0
        repeat
        {   b = x
            d = first + next2 * c
            a = d + Straight + Front!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Straight + Stairs!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Straight + Slide!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Circular + Front!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Circular + Stairs!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Circular + Slide!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Incline + Front!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Incline + Stairs!
            price.append(Int(a))
            car.append(Int(b))
            a = d + Incline + Slide!
            price.append(Int(a))
            car.append(Int(b))
            type()
            c = c+1
            x = x + 2
        }while x<=limit
        
        
        tbl.dataSource = self
        tbl.reloadData()
        createtable()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return price.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "pc3") as! PriceCell
            cell.price.text = String(price[indexPath.row])
            cell.grass_size.text = drive[indexPath.row]
            cell.service_type.text = Service[indexPath.row]
            cell.points.text = String(car[indexPath.row])
            return cell
       
        
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 37.0
    }
    
    func createtable()  {
        
        //let a = price.count
        
        tbl.frame = CGRect (x: 0, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(37*price.count))
        
        scroll.contentSize=CGSize (width: 0, height: tbl.frame.origin.y+tbl.frame.size.height+50)
        
    }
    
    func type ()
    {
        for i in 1...3
        {
            drive.append("Straight")
        }
        for i in 1...3
        {
            drive.append("Circular")
        }
        for i in 1...3
        {
            drive.append("Incline")
        }
        for i in 1...3
        {
            Service.append("Front Door Walk Way")
            Service.append("Stairs and Front Landing")
            Service.append("Side Door Walk Way")
        }
        
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

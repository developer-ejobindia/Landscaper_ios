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

class AerationOrLawn: UIViewController,UITextFieldDelegate , UITableViewDataSource,UITableViewDelegate {
 @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var frst_price: UITextField!
    @IBOutlet weak var nxt_price: UITextField!
    @IBOutlet weak var uppr: UITextField!
    
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
    
    @IBOutlet weak var save_view: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    var ser_id:Int!
    
    @IBOutlet weak var price_view: UIView!
    
    @IBOutlet weak var tbl: UITableView!
    
    
    
    
    //Pricing Variables
    
    var flag : Int!
    var value : Float!
    var increase : Float!
    var limit : Float!
    var price = [Float]()
    var start = [Float]()
    var end = [Float]()
    var x : Float!
    var y : Float!
    var z : Float!
    
    
    var edit_flag:String!
    var added_serid:Int!
    
    
    
    
    
    @IBAction func preview(_ sender: Any) {
        
        if frst_price.text=="" ||  nxt_price.text=="" || uppr.text=="" {
            
            AppManager().AlertUser("", message: "Pleasae fill all the fields", vc: self)
            
        }
        else
        {
        price=[Float]()
        start=[Float]()
        end=[Float]()
        tbl.isHidden = false
        flag = 1
        price_view.isHidden=false
        value = Float(frst_price.text!)
        increase = Float(nxt_price.text!)
        limit = Float(uppr.text!)
        x = 0.00
        repeat
        {
            price.append(value)
            value = value + increase
            x = x + 0.25
        } while x < limit
        x = 0.00
        y = 0.00
        repeat
        {
            start.append(y)
            y = y + 0.25
            x = x + 0.25
        } while x < limit
        x = 0.00
        z = 0.25
        repeat
        {
            end.append(z)
            z = z + 0.25
            x = x + 0.25
        } while x < limit
        
        tbl.reloadData()
        createtable()
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if frst_price.text=="" ||  nxt_price.text=="" || uppr.text=="" {
            
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
    
    //MARK: Jsonreprestation
    
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
        
        var params: Parameters = [:]
        
        if ser_id==4 {
            params = [Parameter.user_id: user_id,
                      Parameter.service_id: "4",
                      Parameter.area_first_acre: frst_price.text!,
                      Parameter.area_next_acre: nxt_price.text!,
                      Parameter.area_acre_limit: uppr.text!,
                      "recurring_services":str_rucservices!]
        }
        
        else
        {
            params = [Parameter.user_id: user_id,
                      Parameter.service_id: "3",
                      Parameter.lawntreat_first_acre: frst_price.text!,
                      Parameter.lawntreat_next_acre: nxt_price.text!,
                      Parameter.lawntreat_acre_limit: uppr.text!,
                "recurring_services":str_rucservices!]
        }
        
        
        
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
        
        
        
    }
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SWT.setOn(false, animated: false)
        rec = false
        rec_view.isUserInteractionEnabled = false
        rec_view.alpha = 0.5

        // Do any additional setup after loading the view.
        
        
        addDoneButtonOnKeyboard(textfield: days7)
        addDoneButtonOnKeyboard(textfield: days10)
        addDoneButtonOnKeyboard(textfield: days14)
        
        addDoneButtonOnKeyboard(textfield: frst_price)
        addDoneButtonOnKeyboard(textfield: nxt_price)
        addDoneButtonOnKeyboard(textfield: uppr)
        
        //scroll.contentSize=CGSize (width: 0, height: present_price.frame.origin.y+present_price.frame.size.height+10)
        
        flag = 0
        
        price_view.isHidden=true
        
        if ser_id==4
        {
            headline.text="Aeration"
        }
        else
        {
            headline.text="Lawn Treatment"
        }
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: save_view)
        des_obj.red_gradient(my_view: save_view)
        
        
        if edit_flag=="0" {
            
        }
        else
        {
            SVProgressHUD.show()
            loadfetchingdata()
        }
        
        
    }
    
    func loadfetchingdata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
//        let headers: HTTPHeaders = [
//            "token": token as! String,
//
//            ]
        
        var params: Parameters = [:]
        
        if ser_id==4 {
            params = [Parameter.added_service_id: added_serid!,
                      Parameter.service_id: "4"]
        }
            
        else
        {
            params = [Parameter.added_service_id: added_serid!,
                      Parameter.service_id: "3"]
        }
        
        
        
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
                        
                        if self.ser_id==4 {
                            
                            ary = dict1["aeration_acre"] as! NSArray!
                            
                        }
                        else
                        {
                            
                            ary = dict1["lawn_acre"] as! NSArray!
                            
                        }
                        
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
                            
                        }
                        
                        self.calculateeditdata(ary: ary!)
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

    func calculateeditdata(ary:NSArray)
    {
        
        uppr.text="\(Float(Float(ary.count)/4))"
        
        let dict1=ary[0] as! NSDictionary
        let dict2=ary[1] as! NSDictionary
        frst_price.text="\(dict1["service_field_price"]!)"
       
        let f1 = "\(dict1["service_field_price"]!)"
        let f2 = "\(dict2["service_field_price"]!)"
    
        let f11 = Float(f1)
        let f22 = Float(f2)
        
        let f3 = f22! - f11!
        nxt_price.text="\(f3)"

    }
    
    func loadedit() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        var params: Parameters = [:]
        
        if ser_id==4 {
            params = [Parameter.service_id: "4",
                      Parameter.area_first_acre: frst_price.text!,
                      Parameter.area_next_acre: nxt_price.text!,
                      Parameter.area_acre_limit: uppr.text!,
                      Parameter.added_service_id: added_serid!,
                      "recurring_services":str_rucservices!]
        }
            
        else
        {
            params = [Parameter.service_id: "3",
                      Parameter.lawntreat_first_acre: frst_price.text!,
                      Parameter.lawntreat_next_acre: nxt_price.text!,
                      Parameter.lawntreat_acre_limit: uppr.text!,
                      Parameter.added_service_id: added_serid!,
                      "recurring_services":str_rucservices!]
        }
        
        
        
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
        
        
        
    }
    
    func addDoneButtonOnKeyboard(textfield:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
     //   let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AerationOrLawn.doneButtonAction(textfield123:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
    //    items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction(textfield123:UITextField) {
        days7.resignFirstResponder()
        days10.resignFirstResponder()
        days14.resignFirstResponder()
        frst_price.resignFirstResponder()
        nxt_price.resignFirstResponder()
        uppr.resignFirstResponder()
    }
    
    func createtable()  {
        
        //let a = price.count
        
        tbl.frame = CGRect (x: 0, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(37*price.count))
        
        scroll.contentSize=CGSize (width: 0, height: tbl.frame.origin.y+tbl.frame.size.height+10)
        
    }
    
    
    
    //Pricing
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (flag == 1)
//        {
            return price.count
//        }
//        else
//        {
//            return 1
//        }
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (flag == 1)
//        {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "pc1") as! PriceCell
            
            cell.points.text = String(start[indexPath.row]) + " - " + String(end[indexPath.row]) + " arce"
            
            cell.price.text = "$ " + String(price[indexPath.row])
            
//            tabcell?.xl3.text = String(price[indexPath.row])
//            tabcell?.xl1.text = String(start[indexPath.row])
//            tabcell?.xl2.text = String(end[indexPath.row])
            return cell
//        }
//        else
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "pc1") as! PriceCell
//
//            return cell
//        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 37.0
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

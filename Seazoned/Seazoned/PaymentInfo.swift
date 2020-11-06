//
//  PaymentInfo.swift
//  Seazoned
//
//  Created by Apple on 24/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class PaymentInfo: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var paypal_signature: UITextField!
    
    @IBOutlet weak var paypal_pwd: UITextField!
    @IBOutlet weak var paypal_username: UITextField!
     @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var name_txt: UITextField!
    
    @IBOutlet weak var accid_txt: UITextField!
    
    @IBOutlet weak var submit_view: UIView!
    
    @IBOutlet weak var add_view: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var acc: UILabel!
    @IBOutlet weak var remove_view: UIView!
    
    @IBOutlet weak var account_view: UIView!
    
    @IBOutlet weak var trans_view: UIView!
    
    @IBOutlet weak var underline_view: UIView!
    
    @IBOutlet weak var lbl_acco: UILabel!
    
    @IBOutlet weak var lbl_trans: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var nodata: UILabel!
    
    var strpaypay_id:String!
    
    var hidden_flag:String!
    
    var ary:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let des_obj = Design()
        des_obj.button_round(my_view: submit_view)
        
        des_obj.green_gradient(my_view: submit_view)
        
        des_obj.button_round(my_view: remove_view)
        
        des_obj.green_gradient(my_view: remove_view)
        
        des_obj.green_gradient(my_view: createview)
        
        des_obj.button_round(my_view: createview)
        add_view.isHidden=true
        view2.isHidden=true
        
        hidden_flag="0"
        
        SVProgressHUD.show()
        loaddata()
        
        tbl.dataSource=nil
        tbl.isHidden=true
        nodata.isHidden=true
        
        SVProgressHUD.show()
        loadtransation()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        SVProgressHUD.show()
//        loaddata()
//    }
    
    @IBOutlet weak var cview: UIView!
    @IBOutlet weak var createview: UIView!
    @IBAction func create(_ sender: UIButton) {
        
        let paypal = "https://www.paypal.com"
        if let url = URL(string: paypal) {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.view_paypal_account,method: .get, headers: headers)
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
                        self.view2.isHidden=false
                        self.add_view.isHidden=true
                        self.cview.isHidden = true
                        let acc_data = dict1["payment_accounts"] as! NSArray
                        let dict3 = acc_data[0] as! NSDictionary
                        self.name.text="\(dict3["name"]!)"
                        //self.acc.text="\(dict3["account_details"]!)"
                        self.acc.text="\(dict3["account_email"]!)"
                        self.strpaypay_id="\(dict3["id"]!)"
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        self.add_view.isHidden=false
                        self.cview.isHidden=false
                        self.view2.isHidden=true
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        //SVProgressHUD.dismiss()
        
    }
    func showAnimate()
    {
        self.add_view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.add_view.alpha = 0.0;
        UIView.animate(withDuration: 0.50, animations: {
            self.add_view.alpha = 1.0
            self.add_view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
//    func removeAnimate()
//    {
//        UIView.animate(withDuration: 0.50, animations: {
//            self.add_view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            self.add_view.alpha = 0.0;
//        }, completion:{(finished : Bool)  in
//            if (finished)
//            {
//                self.add_view.removeFromSuperview()
//            }
//        });
//    }
    func showAnimate2()
    {
        self.view2.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.view2.alpha = 0.0;
        UIView.animate(withDuration: 0.50, animations: {
            self.view2.alpha = 1.0
            self.view2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
//    func removeAnimate2()
//    {
//        UIView.animate(withDuration: 0.50, animations: {
//            self.view2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            self.view2.alpha = 0.0;
//        }, completion:{(finished : Bool)  in
//            if (finished)
//            {
//                self.view2.removeFromSuperview()
//            }
//        });
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func animateTextField1(textview:UITextField,up:Bool)
    {
        let movementDistance = -115// tweak as needed
        let movementDuration = 0.3 // tweak as needed
        
        let movement = (up ? movementDistance : -movementDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextField1(textview: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateTextField1(textview: textField, up: false)
    }
    
    @IBAction func tarns(_ sender: Any) {
        UIView.animate(withDuration: 0.30, animations: {
            
            self.account_view.frame=CGRect (x: -self.view.frame.width, y: self.account_view.frame.origin.y, width: self.account_view.frame.size.width, height: self.account_view.frame.size.height)
            
            self.trans_view.frame=CGRect (x: 0, y: self.trans_view.frame.origin.y, width: self.trans_view.frame.size.width, height: self.trans_view.frame.size.height)
            
            self.underline_view.frame=CGRect (x: self.view.frame.width/2, y: self.underline_view.frame.origin.y, width: self.underline_view.frame.size.width, height: self.underline_view.frame.size.height)
            
            
        });
        
        lbl_trans.textColor =  UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        lbl_acco.textColor =  UIColor (red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
        
        hidden_flag="1"
        
        self.name_txt.resignFirstResponder()
        self.accid_txt.resignFirstResponder()
        
    }
    @IBAction func account(_ sender: Any) {
        
        self.account_view.isHidden=false
        
        UIView.animate(withDuration: 0.30, animations: {
            
            self.account_view.frame=CGRect (x: 0, y: self.account_view.frame.origin.y, width: self.account_view.frame.size.width, height: self.account_view.frame.size.height)
            
            self.trans_view.frame=CGRect (x: self.view.frame.width, y: self.trans_view.frame.origin.y, width: self.trans_view.frame.size.width, height: self.trans_view.frame.size.height)
            
            self.underline_view.frame=CGRect (x: 0, y: self.underline_view.frame.origin.y, width: self.underline_view.frame.size.width, height: self.underline_view.frame.size.height)
            
        });
        
        lbl_acco.textColor =  UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        lbl_trans.textColor =  UIColor (red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
        
        hidden_flag="0"
        
    }
    @IBAction func back(_ sender: Any) {
        
        if hidden_flag=="1" {
            account_view.isHidden=true
        }
        else
        {
            account_view.isHidden=false
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submit(_ sender: Any) {
        
        if name_txt.text=="" {
            AppManager().AlertUser("Warning", message: "Please Add Paypal Account Holder Name", vc: self)
        }
        else if accid_txt.text==""
        {
            AppManager().AlertUser("Warning", message: "Please Add Paypal Account ID", vc: self)
        }
        else if !AppManager().isValidEmail(testStr: accid_txt.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Paypal Id", vc: self)
            
        }
            
        else if paypal_username.text=="" {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Paypal Username", vc: self)
            
        }
            
        else if paypal_pwd.text=="" {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Paypal Password", vc: self)
            
        }
            
        else if paypal_signature.text=="" {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Paypal Signature", vc: self)
            
        }
        else
        {
            SVProgressHUD.show(withStatus: "Adding Account...")
            loadadd()
//            self.add_view.isHidden=true
//            self.view2.isHidden=false
//            self.showAnimate2()
        }
    }
    
    func loadadd() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        //"paypal_account_email"
        let params: Parameters = [Parameter.paypal_name: name_txt.text!,
                                  Parameter.paypal_api_username: paypal_username.text!,
                                  "paypal_account_email": accid_txt.text!
                                  ,
                                  Parameter.paypal_api_password: paypal_pwd.text!,
                                  Parameter.paypal_api_signature: paypal_signature.text!]
        
        
        
        print("param ------ \(params)")
        
        
        Alamofire.request(Webservice.add_paypal_account, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.add_view.isHidden=true
                        self.view2.isHidden=false
                        self.name_txt.resignFirstResponder()
                        self.accid_txt.resignFirstResponder()
                        self.showAnimate2()
                        self.loaddata()
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
        
        //SVProgressHUD.dismiss()
        
    }
    @IBAction func remove(_ sender: Any) {
        
        let alert = UIAlertController (title: "Message", message: "Do You Want to Delete This Paypal Account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction (title: "Delete", style: .destructive, handler: {alert in
            SVProgressHUD.show(withStatus: "Deleting Paypal Account...")
            self.loaddelete()
            
//            self.view2.isHidden=true
//            self.add_view.isHidden=false
//            self.showAnimate()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func loaddelete() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.paypal_id: strpaypay_id!]
        
        
        Alamofire.request(Webservice.delete_paypal_account, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.name_txt.text=""
                        self.accid_txt.text=""
                        self.paypal_username.text=""
                        self.paypal_pwd.text=""
                        self.paypal_signature.text=""

                        self.view2.isHidden=true
                        self.add_view.isHidden=false
                        self.showAnimate()
                        
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
        
        //SVProgressHUD.dismiss()
        
    }
    
    func loadtransation() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.view_transaction_history,method: .get, headers: headers)
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
                        self.ary = dict1["transaction_list"] as! NSArray
                        
                        
                        
                   // let myDouble = "$ \(dict1["total_amount"]!)"
                        //   let myDouble = "145"
                        let myDouble = "\(dict1["total_amount"]!)"

                      
                        let  rate_value =  Float(myDouble)
                        let doubleStr = String(format: "%.2f", rate_value!) // "3.14"
                        
                        self.total.text = doubleStr

                        self.tbl.dataSource=self
                        self.tbl.isHidden=false
                        self.nodata.isHidden=true
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        self.tbl.dataSource=nil
                        self.tbl.isHidden=true
                        self.nodata.isHidden=false
                        self.nodata.text=msg
                     
                        self.total.text="$0"
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        //SVProgressHUD.dismiss()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tc") as! TransCell
        let dict = ary[indexPath.row] as! NSDictionary
        cell.name.text="\(dict["full_name"]!) "
        let str_ordrno="\(dict["order_no"]!)"
        //22 Jun 2018, 14:21
        
        let str_date="\(dict["payment_date"]!)"
        
        if str_date=="" || str_date=="<null>" {
            cell.ser_date.text=""
        }
        else
        {
            let format1 = DateFormatter()
            format1.dateFormat="dd MMM yyyy, HH:mm"
            let date1 = format1.date(from: str_date)
            let format2 = DateFormatter()
            format2.dateFormat="MMMM-dd-yyyy, HH:mm a"
            let str_result = format2.string(from: date1!)
            cell.ser_date.text=str_result
        }
        
        //cell.ser_date.text="\(dict["payment_date"]!)"
        cell.price.text="$ \(dict["landscaper_payment"]!)"
        //cell.status.text="\(dict["status_name"]!)"
        
        let trans_id = "\(dict["transaction_id"]!)"

        if trans_id=="" {
            cell.status.backgroundColor =  UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            cell.status.text = "Processing"
        }
//        else if cell.status.text=="Processing"
//        {
//            cell.status.backgroundColor =  UIColor (   red: 255.0/255.0, green: 214.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        }
        else
        {
             cell.status.backgroundColor =  UIColor (red: 255.0/255.0, green: 214.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            
            cell.status.text = "Success"
        }
        let str_img="\(dict["profile_image"]!)"
        if str_img==""
        {
            //let url = URL(string: str_img)
            cell.imgvw.image=UIImage (named: "user (1).png")
        }
        else
        {
            let url = URL(string: str_img)
            cell.imgvw.kf.setImage(with: url)
        }
        let underlineAttribute = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: str_ordrno, attributes: underlineAttribute)
        cell.order_no.attributedText = underlineAttributedString
        cell.btn.tag=indexPath.row
        cell.btn.addTarget(self, action: #selector(vieworder(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // self.navigationController?.navigationBar.isTranslucent = true
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
        
        self.navigationController?.isNavigationBarHidden =  true
    }
    @IBAction func vieworder(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
        let str_orderid="\(dict["order_id"]!)"
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
        obj.order_id=str_orderid
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

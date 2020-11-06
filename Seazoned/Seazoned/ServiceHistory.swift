//
//  ServiceHistory.swift
//  Seazoned
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class ServiceHistory: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var nodata: UILabel!
    @IBOutlet weak var tbl: UITableView!
    
    var ary : NSArray!
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "bkcll") as! BookCell
        let cell = Bundle.main.loadNibNamed("BookCell", owner: self, options: nil)?.first as! BookCell
        let dict = ary[indexPath.row] as! NSDictionary
        cell.named.text="\(dict["user_name"]!)"
        cell.ser_name.text="\(dict["service_name"]!)"
        cell.book_id.text="\(dict["order_no"]!)"
        let str_img="\(dict["profile_image"]!)"
       // booking_time
        cell.time.text="\(dict["booking_time"]!)"
        
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
        calculate(dict: dict, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
        
        let status="\(dict["status"]!)"
        //let status_name="\(dict["status_name"]!)"
        
        if status=="-1" {
        }
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
            obj.order_id="\(dict["order_id"]!)"
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func calculate(dict:NSDictionary,cell:BookCell)
    {
        let status="\(dict["status"]!)"
        
          let is_completed="\(dict["is_completed"]!)"
        let status_name="\(dict["status_name"]!)"
        let trans_id="\(dict["transaction_id"]!)"
        
        if status=="1"   && is_completed == "0"{
            cell.payment.text="Payment Pending"
           // cell.imginfo.isHidden=true
            cell.imginfo.isHidden=false

            //cell.work.text=status_name
            cell.work.text = "Service Request Accepted"

        }
        else if status=="-1" {
            cell.imginfo.isHidden=true
            cell.payment.text=""
            cell.work.textColor = .red
            cell.work_view.backgroundColor=UIColor.red
            
            cell.work.text=status_name
            
            cell.contentView.alpha=0.5
            cell.selectionStyle = .none
            
        }
        else if status=="0" {
            cell.payment.text=""
            cell.imginfo.isHidden=true
            
            cell.work.text=status_name
        }
        else if status=="2"  && is_completed == "1"
        {
            if trans_id == "<null>" || trans_id == ""
            {
            
            cell.imginfo.isHidden=false
            cell.payment.text="Payment Pending"
            
            cell.work.text="Work In Progress"
              //cell.payment.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
          //  cell.work.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
          //  cell.work_view.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                
            }
            else
            {
                cell.imginfo.isHidden=false
                cell.payment.text="Escrow release request has been sent"
                cell.payment.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
                cell.imginfo.image=UIImage (named: "check-mark-button.png")
                
                
                cell.work.text="Work In Progress"
               // cell.work.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
             //   cell.work_view.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            }
        }
        else if status=="3"   && is_completed == "1"
        {
    
            cell.imginfo.isHidden=false
            cell.payment.text="Escrow release request has been sent"
            cell.payment.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            cell.imginfo.image=UIImage (named: "check-mark-button.png")
            
            
            cell.work.text="Job Complete"
            cell.work.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            cell.work_view.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
        }
            
        else if status=="3"   && is_completed == "2"
        {
            
            cell.imginfo.isHidden=false
            cell.payment.text="Escrow release request has been sent"
            cell.payment.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            cell.imginfo.image=UIImage (named: "check-mark-button.png")
            
            
            cell.work.text="Payment Success"
            cell.work.textColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            cell.work_view.backgroundColor=UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
        }
        else
        {
            
        }
        
        //cell.work.text=status_name
    }
    override func viewWillAppear(_ animated: Bool) {
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
        
        tbl.dataSource=nil
        tbl.isHidden=true
        nodata.isHidden=true
        self.navigationController?.isNavigationBarHidden =  true

        SVProgressHUD.show()
        loaddata()
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.landscaper_booking_history,method: .get, headers: headers)
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
                        
                        //let dict1 = dict["data"] as! NSDictionary
                        self.ary = dict["data"] as! NSArray
                        self.tbl.dataSource=self
                        self.tbl.isHidden=false
                        self.nodata.isHidden=true
                        self.tbl.reloadData()
                        self.tbl.tableFooterView=UIView()
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        self.tbl.dataSource=nil
                        self.tbl.isHidden=true
                        self.nodata.isHidden=false
                        self.nodata.text=msg
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
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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


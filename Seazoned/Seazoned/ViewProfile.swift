//
//  ViewProfile.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class ViewProfile: UIViewController {

     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet var view_img: UIView!
    
    @IBOutlet var imgvw: UIImageView!
    
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet weak var lbl_imgname: UILabel!
    
    @IBOutlet var dob: UILabel!
    
    @IBOutlet var phn: UILabel!
    
    @IBOutlet var mail: UILabel!
    @IBAction func clcik(_ sender: Any) {
        
        
        let s = self.storyboard?.instantiateViewController(withIdentifier: "imgshow" ) as! imgshow
        
        s.str_img  =  self.str_img
        
        self.navigationController?.pushViewController(s, animated: true)
    }
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet var view_edit: UIView!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet var edit_prof: UIButton!
    
    var alldata:NSDictionary!
    
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
    
    @IBAction func change(_ sender: Any) {
        
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "up") as! UpdatePhoto123
        popOverVC.str_checkl = "1"
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

        
    }
    var str_img : String = ""
    @IBOutlet weak var banner: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let des_obj = Design()
        
        
        des_obj.view_round(my_view: view_img)
        
        des_obj.button_round(my_view: view_edit)
        
        des_obj.green_gradient(my_view: view_edit)
        
        view_img.layer.borderWidth=2
        view_img.layer.borderColor=UIColor (red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0).cgColor
        
        scroll.contentSize=CGSize (width: 0, height: view_edit.frame.origin.y+view_edit.frame.size.height+50)
        
        name.text = (self.alldata["first_name"] as? String)! + " " + (self.alldata["last_name"] as? String)!
        
        mail.text = self.alldata["email"] as? String
        
        phn.text = AppManager().nullToNil(value: self.alldata["phone_number"] as? String as AnyObject)
        
      //  dob.text = AppManager().dateformatter(str_date: self.alldata["date_of_birth"] as! String)
        
        //dob.text = (self.alldata["address"] as? String)! + "," + (self.alldata["city"] as? String)! + ","  + (self.alldata["state"] as? String)!
        
        dob.text = AppManager().nullToNil(value: self.alldata["address"] as? String as AnyObject)
        imgvw.contentMode = .scaleToFill
        banner.contentMode = .scaleToFill
        
        
        self.str_img =  "\(self.alldata["drivers_license"]!)"
        let mySubstring =  self.str_img.substring(from: 44)
        
        self.lbl_imgname.text = "\(mySubstring)"
        
           let str = self.alldata["profile_image"] as? String
            //+ "," + (self.alldata["country"] as? String)!
        if str==""
        {
            self.imgvw.image=UIImage (named: "user (1).png")
        }
        else
        {
            let url1 = URL(string: str!)
            self.imgvw.kf.setImage(with: url1)
        }
        
        let str1 = self.alldata["featured_image"] as? String
        //+ "," + (self.alldata["country"] as? String)!
        if str1==""
        {
            self.banner.image=UIImage (named: "def.jpg")
        }
        else
        {
            let url1 = URL(string: str1!)
            self.banner.kf.setImage(with: url1)
        }
        
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
        
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func edit(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ep") as! EditProfile
        
        obj.alldata=self.alldata
    
        self.navigationController?.pushViewController(obj, animated: true)
        
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

}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

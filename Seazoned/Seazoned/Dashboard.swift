//
//  Dashboard.swift
//  Seazoned
//
//  Created by Student on 02/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SVProgressHUD
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import Firebase
class Dashboard: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var mylat:String!
    var mylong:String!
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    @IBOutlet weak var mtble: UITableView!
    
    var ary_data : NSArray!
    var ary_data2 : NSArray!
    
    @IBOutlet weak var service_request: UILabel!
    @IBOutlet var bell_view: UIView!
    
    @IBOutlet var lower_view: UIView!
    
    @IBOutlet var v1: UIView!
    
    @IBOutlet weak var lbl_count: UILabel!
    @IBOutlet var v2: UIView!
    
    @IBOutlet var v3: UIView!
    
    @IBOutlet var v4: UIView!
    
    @IBOutlet var v5: UIView!
    
    @IBOutlet var v6: UIView!
    
    @IBOutlet var v7: UIView!
    
    @IBOutlet var col: UICollectionView!
    
    var weather_ary:NSArray!
    
    @IBOutlet weak var p_jobs: UILabel!
    @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var lbl_condition: UILabel!
    
    
    @IBOutlet weak var lbl_location: UILabel!
    
    
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_degree: UILabel!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var d: UILabel!
    
    @IBOutlet weak var c: UILabel!
    
    @IBOutlet weak var view_p_jobs: UIView!
    @IBOutlet weak var view_s_q: UIView!
    @IBOutlet weak var p_req_count: UILabel!
    @IBOutlet weak var ser_req_count: UILabel!
    @IBOutlet weak var view_pr_count: UIView!
    @IBOutlet weak var view_sq_count: UIView!
    
    
    @IBAction func menu(_ sender: Any) {
    }
    
    @IBAction func notification(_ sender: Any) {
    }
    
    
    @IBOutlet weak var no_datalbl: UILabel!
    func loaddiscount()  {
        
        
        
        
        Alamofire.request(Webservice.serviceList, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("---discount-------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let rate = "\(dict["tax_rate"]!)"
                    
                    
                    
                    UserDefaults.standard.set(rate, forKey: "rate")
                    
                    
                    print("rate-------\(rate)")
                    
                    
                    // let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        
                        //                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                        //                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        
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
    
    
    
    func check_paytm() {
        
        
        SVProgressHUD.show()
        
        
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
                        
                      //  let dict1 = dict["data"] as! NSDictionary
                       
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        
                       // PaymentInfo
                        
                        let s = UIStoryboard(name: "Main", bundle: nil)
                        
                        let obj = s.instantiateViewController(withIdentifier: "pay") as! PaymentInfo
                        
                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        
                        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func service_req(_ sender: UIButton) {
        
        if  sender.tag == 0 {
            
             self.mtble.isHidden = true
            self.loaddata()
            
            view_s_q.isHidden = false
            service_request.textColor = UIColor.init(red: 19.0/255 , green: 192.0/255, blue: 155.0/255, alpha: 1.0)
            view_s_q.backgroundColor = UIColor.init(red: 19.0/255 , green: 192.0/255, blue: 155.0/255, alpha: 1.0)
            
            p_jobs.textColor = UIColor.black
            view_p_jobs.isHidden = true
            view_p_jobs.backgroundColor = UIColor.gray
            
        
            
            
            
        }
            
            
        else
            
        {
            self.mtble.isHidden = true

            self.pending_data()
            
            
            view_s_q.isHidden = true
            view_p_jobs.isHidden = false
            service_request.textColor = UIColor.black
            view_s_q.backgroundColor = UIColor.gray
            
            p_jobs.textColor = UIColor.init(red: 19.0/255 , green: 192.0/255, blue: 155.0/255, alpha: 1.0)
            view_p_jobs.backgroundColor = UIColor.init(red: 19.0/255, green: 192.0/255, blue: 155.0/255, alpha: 1.0)
            
        }
        
        
    }
    
    
    func noti_count()
        
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        
        
        
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        //  http://192.168.1.2:8080/dev/ondemandcrapp/public/api/subscribe?
        
        // firebase_token=khbistr98w-0ghd0tjklhxvgc.....,
        
        //  &device_type=android
        
        // print(token)
        
      //  let token = UserDefaults.standard.object(forKey: "token1")

        
        let headers: HTTPHeaders = [
            
            "token": token as! String,
            
            
            
            ]
        
        
        
        //  let token1 = FIRInstanceID.instanceID().token()
        
        //        let avl = token1 as! String
        
        //        if  avl != nil
        
        //        {
        
        //
        
        //            print("-----------------------------------\(token1)")
        
        //            //   let params: Parameters  [Parameter.device_token: token1!
        
        //            //   ]
        
        
        
        
        
        Alamofire.request(Webservice.notification, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            
            
            .responseJSON { response in
                
                //debugPrint(response.data)
                
                
                
                switch(response.result){
                    
                case .success(_):
                    
                    let result = response.result
                    
                    
                    
                    let dict = result.value as! NSDictionary
                    
                    
                    
                    print("-----kkkkkkkk-----\(dict)")
                    
                    
                    
                    let succ = dict["success"] as! Int
                    
                    
                    
                    let msg = dict["msg"] as! String
                    
                    
                    
                    if succ==1
                        
                    {
                        
                        let notification_count1 = "\(dict["notification_count"]!)"
                        
                        
                        
                        // self.lbl_count.text = notification_count1
                        
                        self.bell_view.isHidden = false
                        
                        
                        
                        
                        
                        UserDefaults.standard.set("1", forKey: "noti")
                        
                        SVProgressHUD.dismiss()
                        
                        
                        
                    }
                        
                    else
                        
                    {
                        
                        self.bell_view.isHidden = true
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        SVProgressHUD.dismiss()
                        
                        
                        
                    }
                    
                    
                    
                    self.lbl_count.isHidden = true
                    
                    
                    
                    break
                    
                    
                    
                case .failure(_):
                    
                    print("Network Error")
                    
                    SVProgressHUD.dismiss()
                    
                    break
                    
                    
                    
                }
                
        }
        
        
        
        // }
        
        
        
        
        
        
        
        //SVProgressHUD.dismiss()
        
    }
    //MARK: Services
    
    @IBAction func service_btn(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 0: break
        case 1: break
        case 2: break
        case 3: break
        case 4: break
        case 5: break
        case 6: break
            
        default: break
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_count.isHidden = true

       // noti_count()
        mtble.dataSource = nil
        view_p_jobs.isHidden = true
        //   view_s_q.isHidden = true
        SVProgressHUD.show()
        loaddata()
        
        loaddiscount()
        
        
        
       check_paytm()
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        des_obj.round_corner(my_view: view_pr_count,value: 3)
        
        des_obj.round_corner(my_view: view_sq_count,value: 3)
        
        
        //        des_obj.view_round(my_view: v1)
        //        des_obj.view_round(my_view: v2)
        //        des_obj.view_round(my_view: v3)
        //        des_obj.view_round(my_view: v4)
        //        des_obj.view_round(my_view: v5)
        //        des_obj.view_round(my_view: v6)
        //        des_obj.view_round(my_view: v7)
        //
        //        scroll.contentSize=CGSize (width: 0, height: v7.frame.origin.y+v7.frame.size.height+60)
        
        //col.dataSource=nil
        //Timer .scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(loadweather), userInfo: nil, repeats: false)
        
      //  loadweather()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        col.dataSource=nil
        
        mtble.tableFooterView=UIView()
        
       SVProgressHUD.show()
        subscription()
        
    }
    
    func subscription()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        let token = UserDefaults.standard.object(forKey: "token1")
        //  http://192.168.1.2:8080/dev/ondemandcrapp/public/api/subscribe?
        // firebase_token=khbistr98w-0ghd0tjklhxvgc.....,
        //  &device_type=android
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        let token1 = FIRInstanceID.instanceID().token()
        
       // AppManager().AlertUser("", message: "\(token1?.description)!", vc: self)
         if token1 != nil
      //  if  avl != nil
        {
            
            print("-----------------------------------\(token1)")
            let params: Parameters = [Parameter.device_token: token1!,
                                      Parameter.device_type: "iphone",
                                      Parameter.user_type: "landscaper"]
            
            
            Alamofire.request(Webservice.subscribe, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                
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
                            
                            SVProgressHUD.dismiss()
                            
                        }
                        else
                        {
                            
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
            
        else
        {
            // SVProgressHUD.dismiss()
        }
        
        //SVProgressHUD.dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         //loadweather()
         noti_count()
        self.navigationController?.isNavigationBarHidden = true
        
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
                
               // AppManager().AlertUser("", message: a, vc: self)
                
                
                
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
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wc", for: indexPath) as! WeatherCell
        
        let dict = weather_ary[indexPath.row+1] as! NSDictionary
        
        cell.day.text = (dict["day"] as? String)?.uppercased()
        
        cell.high.text = "\(dict["high"]!)"
        
        cell.low.text = "\(dict["low"]!)"
        
        let str_img = "\(dict["code"]!)"
        
        
        print("img----\(str_img)")
        let concat_string = (str_img + ".png")
        
        cell.imgvw.image = UIImage (named:concat_string)
        
        cell.day.clipsToBounds=true
        cell.day.layer.cornerRadius=3
        
        return cell
    }
    
    //var locationManager = CLLocationManager()
    
    
    
    func loadweather()
    {
        
        
        
//
//            let s1 = "\""
//            let s2 = ")"
//
//
//
//            //let str1 = "(SELECT woeid FROM geo.places WHERE text= "\(s1) \(mylat),\(mylong)\(s2)")&format=json"
//
//
//            let kkk = "(\(mylat!)" + "," + "\(mylong!))"
//
//            let str111 = "(" + "SELECT woeid FROM geo.places WHERE text=" + s1 + kkk + s1 + ")"
//
//            //http://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text="({28.3949},{84.1240})")&format=json
//
//            let str = "http://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in \(str111) and u='f'&format=json"
//
//            let urlwithPercentEscapes = str.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
//
//            if let url = NSURL(string:urlwithPercentEscapes!){
//                if let data = try? Data(contentsOf:url as URL ){
//                    do{
//                        let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
//
//
//                        //print("----------\(dict)")
//
//                        let dict_query = dict["query"] as! NSDictionary
//
//                        let dict_results = dict_query["results"] as! NSDictionary
//
//                        let dict_channel = dict_results["channel"] as! NSDictionary
//
//                        let dict_item = dict_channel["item"] as! NSDictionary
//
//                        let dict_location = dict_channel["location"] as! NSDictionary
//
//                        lbl_location.text = (dict_location["city"] as? String)! + "," + (dict_location["region"] as? String)! + "," + (dict_location["country"] as? String)!
//
//                        weather_ary = dict_item["forecast"] as! NSArray
//
//                        let condition = dict_item["condition"] as! NSDictionary
//
//                        lbl_condition.text = condition["text"] as? String
//
//                        lbl_degree.text = condition["temp"] as? String
//
//                        let str_img = condition["code"] as! String
//
//                        let concat_string = (str_img + ".png")
//
//                        imgvw.image=UIImage (named: concat_string)
//
//                        //let str_date = condition["date"] as! String
//
//                        let today_date = Date()
//
//                        //print("----\(today_date)")
//
//                        let format1 = DateFormatter()
//                        format1.dateFormat="yyyy-MM-dd HH:mm:ss"
//                        let str11111 = format1.string(from: today_date)
//
//                        let format222 = DateFormatter()
//                        format222.dateFormat="yyyy-MM-dd HH:mm:ss"
//                        let date11 = format222.date(from: str11111)
//
//                        let format2 = DateFormatter()
//                        format2.dateFormat="EEEE MMMM dd"
//                        let str_result = format2.string(from: date11!)
//
//                        lbl_date.text = str_result
//
//                        d.isHidden=false
//                        c.isHidden=false
//                        col.dataSource=self
//                        col.reloadData()
//
//                    }
//                    catch let error as NSError{
//                        print("detail of json parsing error\n\(error)")
//                    }
//                }
//
//            }
        
            
            
            
            
       YahooWeatherAPI.shared.weather(lat: "\(mylat!)", lon: "\(mylong!)", failure: { (error) in
       // YahooWeatherAPI.shared.weather(lat: "22.5726", lon: "88.3639", failure: { (error) in

            print(error.localizedDescription)
        },  success: { (response) in
            do {
                let dict_item = try response.jsonObject() as! NSDictionary
                
                let co = dict_item["current_observation"] as! NSDictionary
                  let condition = co["condition"] as! NSDictionary
                
                let dict_location =  dict_item["location"] as! NSDictionary
                self.lbl_condition.text = condition["text"] as? String
                
                self.lbl_degree.text = "\(condition["temperature"]!)"
                
                                        let str_img = "\(condition["code"]!)"
                
                
                let concat_string = (str_img + ".png")
                
                self.imgvw.image=UIImage (named: concat_string)
                
                                        //let str_date = condition["date"] as! String
                
                                        let today_date = Date()
                
                                        //print("----\(today_date)")
                
                                        let format1 = DateFormatter()
                                        format1.dateFormat="yyyy-MM-dd HH:mm:ss"
                                        let str11111 = format1.string(from: today_date)
                
                                        let format222 = DateFormatter()
                                        format222.dateFormat="yyyy-MM-dd HH:mm:ss"
                                        let date11 = format222.date(from: str11111)
                
                                        let format2 = DateFormatter()
                                        format2.dateFormat="EEEE MMMM dd"
                                        let str_result = format2.string(from: date11!)
                
                self.lbl_date.text = str_result
                
                self.d.isHidden=false
                self.c.isHidden=false
                self.col.dataSource=self
                self.col.reloadData()
                self.lbl_location.text = (dict_location["city"] as? String)! + "," + (dict_location["region"] as? String)! + "," + (dict_location["country"] as? String)!
                self.weather_ary = dict_item["forecasts"] as! NSArray
                
                print(self.weather_ary)

            } catch {
                print(error.localizedDescription)
            }
        })
            

        
        
        
        
        
        
        
        
    }
    
    
    // Mark: Pending Jobs
    
    func pending_data()
    {
        
        SVProgressHUD.dismiss()
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        /* let params: Parameters = [Parameter.first_name: f_name.text!,
         Parameter.last_name: l_name.text!,
         Parameter.dob: dob_str!,
         Parameter.tel: phn.text!]*/
        
        
        Alamofire.request(Webservice.service_pending, method: .get,  encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.ary_data = dict.object(forKey: "data") as! NSArray
                        self.mtble.dataSource = self
                          self.mtble.isHidden = false
                        self.no_datalbl.isHidden=true
                        self.mtble.reloadData()
                    }
                    else
                    {
                        self.mtble.dataSource = nil
                        
                         self.mtble.isHidden = true
                        self.no_datalbl.isHidden=false
                        self.no_datalbl.text=msg
                    }
                    
                    // AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
    }
    
    func pending_dataforcount()
    {
        
        SVProgressHUD.dismiss()
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        /* let params: Parameters = [Parameter.first_name: f_name.text!,
         Parameter.last_name: l_name.text!,
         Parameter.dob: dob_str!,
         Parameter.tel: phn.text!]*/
        
        
        Alamofire.request(Webservice.service_pending, method: .get,  encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.ary_data2 = dict.object(forKey: "data") as! NSArray
                        //self.mtble.dataSource = self
                        
                        
                    }
                    else
                    {
                        //self.mtble.dataSource = nil
                        self.ary_data2=[]
                        
                    }
                    //self.mtble.reloadData()
                    // AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    self.ser_req_count.text=String(self.ary_data.count)
                    self.p_req_count.text=String(self.ary_data2.count)
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
    }
    
    
    
    func loaddata() {
        SVProgressHUD.dismiss()
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        /* let params: Parameters = [Parameter.first_name: f_name.text!,
         Parameter.last_name: l_name.text!,
         Parameter.dob: dob_str!,
         Parameter.tel: phn.text!]*/
        
        
        Alamofire.request(Webservice.service_request, method: .get,  encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    //                    data =     (
                    //                    );
                    self.ary_data = dict.object(forKey: "data") as! NSArray
                    
                    
                    if (self.ary_data.count>0)
                    {
                        
                        
                        
                        self.no_datalbl.isHidden=true
                        
                        
                        
                        if succ==1
                        {
                            
                            self.ary_data = dict.object(forKey: "data") as! NSArray
                            self.mtble.dataSource = self
                            
                             self.mtble.isHidden = false
                            
                            
                        }
                        else
                        {
                            //self.mtble.dataSource = nil
                            
                            self.mtble.isHidden = true

                        }
                        self.mtble.reloadData()
                        // AppManager().AlertUser("Message", message: msg, vc: self)
                        
                    }
                        
                        
                    else
                    {
                        
                        self.mtble.reloadData()
                        self.ary_data=[]
                        self.no_datalbl.isHidden=false
                        self.no_datalbl.text=msg
                        
                    }
                    
                    self.pending_dataforcount()
                    
                    SVProgressHUD.dismiss()
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
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
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
        
    {
        
        
        return ary_data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let dict = ary[indexPath.row] as! NSDictionary
        let alldata = ary_data[indexPath.row] as! NSDictionary
        
        let value = alldata["book_service"] as! NSDictionary

     //   let status="\(value)"
        let status="\(value["status"]!)"
        
        if status=="-1" {
        }
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
            obj.order_id="\(value["id"]!)"
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell:dashboard_tblcellTableViewCell!
        
        if view_p_jobs.isHidden {
            
            
            
            cell =  mtble.dequeueReusableCell(withIdentifier: "A")  as! dashboard_tblcellTableViewCell
            
            
            let alldata = ary_data[indexPath.row] as! NSDictionary
            
            let value = alldata["name"] as! NSDictionary
            
            cell.lbl_service.text =  value["service_name"] as? String
            
            
            let value_add = alldata["book_address"] as! NSDictionary
            
            cell.address.text =  (value_add["address"] as? String)! + " " + (value_add["city"] as? String)! + "  "  + (value_add["state"] as? String)!
            
            
            
            // + (value_add["country"] as? String)!
            
            cell.name.text = (value_add["name"] as? String)!
            //  service_date
            
            
            //   service_price
            
            
            let value_service = alldata["book_service"] as! NSDictionary
            
            cell.service_money.text = "$" +  (value_service["service_price"] as? String)!
            
            cell.service_date.text = (value_service["service_date"] as? String)!
            
            cell.service_date.text = Time().dateformat(str_date: cell.service_date.text!)
            
            cell.prefered_time.text = (value_service["service_time"] as? String)!
            
            cell.prefered_time.text = Time().timeformat(str_date: cell.prefered_time.text!)
            //   service_time
            
            
            
            
            
            
            cell.btn_accept.tag = indexPath.row
            cell.btn_dec.tag = indexPath.row
            
            
            cell.btn_accept.addTarget(self, action:#selector(buttonPressed(_:)), for: .touchUpInside)
            cell.btn_dec.addTarget(self, action:#selector(dec_buttonPressed(_:)), for: .touchUpInside)
            // dec_buttonPressed
            let des_obj = Design()
            des_obj.button_round(my_view: cell.view_accept)
            
            des_obj.green_gradient(my_view: cell.view_accept)
            
            
            des_obj.button_round(my_view: cell.view_decline1)
            
            
            
            //return cell
            
        }
        else
        {
            cell =  mtble.dequeueReusableCell(withIdentifier: "B")  as! dashboard_tblcellTableViewCell
            
            
            let alldata = ary_data[indexPath.row] as! NSDictionary
            
            let value = alldata["name"] as! NSDictionary
            
            cell.lbl_service.text =  value["service_name"] as? String
            
            
            let value_add = alldata["book_address"] as! NSDictionary
            
            cell.address.text =  (value_add["address"] as? String)! + "," + (value_add["city"] as? String)! + ","  + (value_add["state"] as? String)! + "," + (value_add["country"] as? String)!
            
            
            
            // + (value_add["country"] as? String)!
            
            cell.name.text = (value_add["name"] as? String)!
            //  service_date
            
            
            //   service_price
            
            
            let value_service = alldata["book_service"] as! NSDictionary
            
            cell.service_money.text = "$" +  (value_service["service_price"] as? String)!
            
            cell.service_date.text = (value_service["service_date"] as? String)!
            
            cell.prefered_time.text = (value_service["service_time"] as? String)!
            
            cell.service_date.text = Time().dateformat(str_date: cell.service_date.text!)
            cell.prefered_time.text = Time().timeformat(str_date: cell.prefered_time.text!)
            
            //   service_time
            
            
            
            
            
            
            /*cell.btn_accept.tag = indexPath.row
             cell.btn_dec.tag = indexPath.row
             
             
             cell.btn_accept.addTarget(self, action:#selector(buttonPressed(_:)), for: .touchUpInside)
             cell.btn_dec.addTarget(self, action:#selector(dec_buttonPressed(_:)), for: .touchUpInside)
             // dec_buttonPressed
             let des_obj = Design()
             des_obj.button_round(my_view: cell.view_accept)
             
             des_obj.green_gradient(my_view: cell.view_accept)
             
             
             des_obj.button_round(my_view: cell.view_decline1)*/
            
            
            
            //return cell
        }
        
        return cell
        
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        let value_book_service = (((self.ary_data[sender.tag])) as AnyObject).object(forKey:"book_service") as! NSDictionary
        
        let  book_service_id = "\(value_book_service["id"]!)"
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //  self.accepdata(str_id: str_id)
            
            self.accept_data(bookservice_id: book_service_id )
            
        }
        
        
        
        
        
    }
    
    
    
    //MARK: accept Button
    
    func accept_data(bookservice_id:String)  {
        let currentDateTime = Date()
        
        
        
        print(currentDateTime)
        
        
        
        let format1 = DateFormatter()
        
        format1.dateFormat="yyyy-MM-dd HH:mm:ss z"
        
        let date1 = format1.date(from: "\(currentDateTime)")
        
        let format2 = DateFormatter()
        
        format2.dateFormat="yyyy-MM-dd HH:mm:ss"
        
        let str_result = format2.string(from: date1!)
        
        
        
        print(str_result)
        SVProgressHUD.dismiss()
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.book_service_id: bookservice_id,
                                  Parameter.status: "1",
                                  "accept_time":str_result
        ]
        
        
        Alamofire.request(Webservice.accept_reject_service, method: .post, parameters: params , encoding: JSONEncoding.default, headers: headers)
            
            
            //Alamofire.request(Webservice.accept_reject_service, method: .post, Parameters:params , encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.loaddata()
                    }
                    else
                    {
                        
                    }
                    
                    AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
    }
    
    
    
    //MARK: Decline Button
    
    @objc func dec_buttonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        let value_book_service = (((self.ary_data[sender.tag])) as AnyObject).object(forKey:"book_service") as! NSDictionary
        
        let  book_service_id = "\(value_book_service["id"]!)"
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //  self.accepdata(str_id: str_id)
            
            self.declined_data(bookservice_id: book_service_id )
            
        }
        
        
        
        
        
    }
    
    
    func declined_data(bookservice_id:String)  {
        let currentDateTime = Date()
        
        
        
        print(currentDateTime)
        
        
        
        let format1 = DateFormatter()
        
        format1.dateFormat="yyyy-MM-dd HH:mm:ss z"
        
        let date1 = format1.date(from: "\(currentDateTime)")
        
        let format2 = DateFormatter()
        
        format2.dateFormat="yyyy-MM-dd HH:mm:ss"
        
        let str_result = format2.string(from: date1!)
        
        
        
        print(str_result)
        SVProgressHUD.dismiss()
        let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.book_service_id: bookservice_id,
                                  Parameter.status: "-1","reject_time":str_result
        ]
        
        
        Alamofire.request(Webservice.accept_reject_service, method: .post, parameters: params , encoding: JSONEncoding.default, headers: headers)
            
            
            //Alamofire.request(Webservice.accept_reject_service, method: .post, Parameters:params , encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.loaddata()
                    }
                    else
                    {
                        
                    }
                    
                    AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if view_p_jobs.isHidden{
            return 209.0
        }
        else
        {
            return 150.0
        }
        return 0
    }
    
    // MARK:  Gps MAP
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
        //  mapView.showsUserLocation = false
        
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        mylat = String(format: "%.4f",
                      latestLocation.coordinate.latitude)
        mylong = String(format: "%.4f",
                      latestLocation.coordinate.longitude)
        
        print("tnay-----lat-------\(mylat)------lon---\(mylong)")
        
        loadweather()   //
        
        }
        
        
        
        
        
    
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        
        
    }
}

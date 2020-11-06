//
//  Chatlist.swift
//  Seazoned
//
//  Created by Apple on 02/05/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

import WebKit
class faq: UIViewController,UITableViewDataSource,UITableViewDelegate, WKNavigationDelegate,UIWebViewDelegate  {
    @IBOutlet weak var webview: UIWebView!
    
   
    @IBOutlet weak var lower_view: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var nodata: UILabel!
    var isexpand: Bool!
    var indexPathForTable: Int?

    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var bell_view: UIView!
    var expandedLabel: UITextView!
    
    var indexOfCellToExpand: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.isHidden = true
   
    
  indexOfCellToExpand = -1
         SVProgressHUD.show()
        
        self.perform(#selector(loadweb), with: self, afterDelay: 0.5)
      

        
        print(self.view.frame.size.height)
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)

            return false
        }
        return true
    }
    @objc func loadweb()
    {
        
       
        let url = URL(string: "http://www.seazoned.com/provider-FAQ")!
        
        let req1 = URLRequest.init(url: url)
     webview.loadRequest(req1)
        
        
    }
    
  func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        SVProgressHUD.dismiss()
        
    }

    var ary : NSArray!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "bkcll") as! BookCell
       let cell = Bundle.main.loadNibNamed("Cell1", owner: self, options: nil)?.first as! Cell1
        
        
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath) as! Cell1

        let dict = ary[indexPath.row] as! NSDictionary
        
        
      //  cell.lbl2.text = "\(dict.object(forKey: "questions")!)"
        
        let str1 = "\(dict.object(forKey: "answers")!)"
        //  str1.convertHtml()
     //   cell.txtvw.attributedText = str1.convertHtml()
        cell.contentView.backgroundColor = UIColor.clear
        let str2 = "\(dict.object(forKey: "questions")!)"
        cell.lbl2.text =  str2
        cell.txtvw.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(faq.expandCell(sender:)))
        cell.txtvw.addGestureRecognizer(tap)
        cell.txtvw.isUserInteractionEnabled = true
        
        
      
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  self.view.frame.size.height == 568
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 280
            }
            
        }
            
        else if  self.view.frame.size.height == 667
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 370
            }
            
        }
        else if  self.view.frame.size.height == 736
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 480
            }
            
        }
        
        else if  self.view.frame.size.height == 812
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 200
            }
            
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        indexPathForTable = indexPath.row
        print("dggfgfgf")
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

        tbl.dataSource=nil
        tbl.isHidden=true
        nodata.isHidden=true
        
       
       // loaddata()
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token1")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
       // let param  = ["profile_id": "3"]
        
        let params : Parameters = [
           "profile_id": "3"]
        
        
        print(params)
        
        Alamofire.request(Webservice.get_faq ,method: .post, parameters: params, headers: nil)
        
       // Alamofire.request(Webservice.get_faq,method: .post, headers: nil)
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    self.ary = []
                    
                    if succ==1
                    {
                        
                      //  let dict1 = dict["data"] as! NSDictionary
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
                        self.ary = []
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
    
    //MARK: Tabbar
    
    @IBAction func tabbar(_ sender: UIButton) {
        
        //Help
        if sender.tag==0 {
            
            
            print("hhghg")
            
        }
            //Message
        else if sender.tag==1 {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "clst") as! Chatlist
//            self.navigationController?.pushViewController(obj, animated: false)
            
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
    
    //MARK: Expand Table
    
    
  @objc func expandCell(sender: UITapGestureRecognizer)
    {
        
        if isexpand == false {
            let label = sender.view as! UITextView
            
            let cell: Cell1 = tbl.cellForRow(at: IndexPath(row: label.tag, section: 0)) as! Cell1
            let movie = ary[label.tag] as! NSDictionary
            let description = movie["answers"] as! String
            
            // cell.txtvw.sizeToFit()
         //   cell.txtvw.attributedText = description.convertHtml()
            expandedLabel = cell.txtvw
            indexOfCellToExpand = label.tag
            tbl.reloadRows(at: [IndexPath(row: label.tag, section: 0)], with: .fade)
            tbl.scrollToRow(at: IndexPath(row: label.tag, section: 0), at: .top, animated: true)
            ////agulo thakbhe /////
            /*  tbl.frame = CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: tbl.contentSize.height + cell.txtvw.frame.height + 80)
             
             last_img.frame = CGRect (x: last_img.frame.origin.x, y: tbl.frame.origin.y+tbl.contentSize.height + cell.txtvw.frame.height+80, width: last_img.frame.size.width, height: last_img.frame.size.height)
             
             self.MAIN_SCROLL.contentSize = CGSize (width: 0, height: last_img.frame.origin.y+last_img.frame.size.height+5)*/
            
            isexpand = true
            
        }
            
        else
        {
            
            let label = sender.view as! UITextView
            
            let cell: Cell1 = tbl.cellForRow(at: IndexPath(row: label.tag, section: 0)) as! Cell1
            let movie = ary[label.tag] as! NSDictionary
            //let description = movie["description"] as! String
            //cell.txtvw.sizeToFit()
            // cell.txtvw.frame = CGRect (x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width, height: 74)
            //cell.txtvw.attributedText = description.convertHtml()
            //expandedLabel = cell.txtvw
            //cell.txtvw.isHidden = true
            //cell.sizeThatFits(CGSize (width: 50, height: 50))
            indexOfCellToExpand = -1
            //  cell.txtvw.sizeToFit()
            
            //  cell.txtvw.sizeThatFits(CGSize (width: 50, height: 1))
            // let insets: UIEdgeInsets = cell.txtvw.textContainerInset;
            //  textViewHeight.constant = size.height + insets.top + insets.bottom;
            tbl.reloadRows(at: [IndexPath(row: label.tag, section: 0)], with: .fade)
            tbl.scrollToRow(at: IndexPath(row: label.tag, section: 0), at: .top, animated: true)
            
            
            tbl.frame = CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: tbl.contentSize.height)
            
//            last_img.frame = CGRect (x: last_img.frame.origin.x, y: tbl.frame.origin.y+tbl.contentSize.height + 60, width: last_img.frame.size.width, height: last_img.frame.size.height)
//
//            self.MAIN_SCROLL.contentSize = CGSize (width: 0, height: last_img.frame.origin.y+last_img.frame.size.height+5)
            
           // self.Tabledatadata()
            
            isexpand = false
            
        }
    }
}

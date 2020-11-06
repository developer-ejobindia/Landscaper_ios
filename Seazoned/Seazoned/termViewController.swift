//
//  termViewController.swift
//  Seazoned
//
//  Created by Apple on 26/09/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import SVProgressHUD

class termViewController: UIViewController,UITableViewDelegate,UIWebViewDelegate  {
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        
        self.perform(#selector(loadweb), with: self, afterDelay: 0.5)
        // Do any additional setup after loading the view.
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
            
            return false
        }
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
  @IBAction func back(_ sender: UIButton)    {
    
    self.navigationController?.popViewController(animated: true)
    
    
    }
    
    @objc func loadweb()
    {
        
        
        let url = URL(string: "http://www.seazoned.com/provider-terms-conditions")!
        
        let req1 = URLRequest.init(url: url)
        webview.loadRequest(req1)
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        SVProgressHUD.dismiss()
        
    }



}

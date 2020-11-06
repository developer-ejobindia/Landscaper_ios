//
//  second.swift
//  service
//
//  Created by Surjava Ghosh on 26/02/18.
//  Copyright © 2018 Surjava Ghosh. All rights reserved.
//

import UIKit

class second: UIViewController, UITableViewDelegate, UITableViewDataSource {
     @IBOutlet weak var red_msg: UIImageView!
    @IBAction func back(_ sender: Any) {
        
        removeAnimate()
        
    }
    @IBOutlet weak var sc: UIScrollView!
    var chlorine : Float!
    var Saline : Float!
    var spa : String!
    var Inground : Float!
    var aboveground : Float!
    var clear : Float!
    var cloudy : Float!
    var Algae : Float!
    var spa2 : Float!
    var price : Int!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if spa2 == 0
        {
            spa = "No"
        }
        else
        {
           
            spa = "Yes"
        }
       if indexPath.row == 0
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        return tabcell!
        }
        else if indexPath.row == 1
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa!
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Relatively Clear"
        price = Int(chlorine! + spa2! + Inground! + clear!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
        }
       else if indexPath.row == 2
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Moderately Cloudy"
        
        price = Int(chlorine! + spa2! + Inground! + cloudy!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 3
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Heavy Algae Present"
        price = Int(chlorine! + spa2! + Inground! + Algae!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 4
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Relatively Clear"
        price = Int(chlorine! + spa2! + aboveground! + clear!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 5
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Moderately Cloudy"
        price = Int(chlorine! + spa2! + aboveground! + cloudy!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 6
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Heavy Algae Present"
        price = Int(chlorine! + spa2! + aboveground! + Algae!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 7
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa!
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Relatively Clear"
        price = Int(Saline! + spa2! + Inground! + clear!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 8
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Moderately Cloudy"
        
        price = Int(Saline! + spa2! + Inground! + cloudy!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 9
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Inground"
        tabcell?.l4.text = "Heavy Algae Present"
        price = Int(Saline! + spa2! + Inground! + Algae!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 10
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Relatively Clear"
        price = Int(Saline! + spa2! + aboveground! + clear!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 11
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Moderately Cloudy"
        price = Int(Saline! + spa2! + aboveground! + cloudy!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
       else if indexPath.row == 12
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        tabcell?.l1.text = "Chlorine"
        tabcell?.l2.text = spa
        tabcell?.l3.text = "Above Ground"
        tabcell?.l4.text = "Heavy Algae Present"
        price = Int(Saline! + spa2! + aboveground! + Algae!)
        tabcell?.l5.text = String(price!)
        return tabcell!
        
       }
        
        else
       {
        let tabcell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?.first as? cell
        
        
        return tabcell!
        
        }
    }
    
    func removeAnimate()
        
    {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            self.view.alpha = 0.0
            
        }, completion: {(finished : Bool) in
            
            if(finished)
                
            {
                
                self.willMove(toParentViewController: nil)
                
                self.view.removeFromSuperview()
                
                self.removeFromParentViewController()
                
            }
            
        })
        
    }

    @IBOutlet weak var t1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        // Do any additional setup after loading the view.
        sc.contentSize=CGSize (width: 525, height: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
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

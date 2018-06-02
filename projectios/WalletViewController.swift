//
//  WalletViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire

class WalletViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBAction func add_click(_ sender: Any) {
        
    }
    var elements = [[String:Any]]()
    @IBOutlet weak var tablekategori: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tablekategori.delegate = self;
        tablekategori.dataSource = self;
        tablekategori.rowHeight = 60;
        tablekategori.estimatedRowHeight = 60;
        self.title = "Wallet"
        getwallet()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadwallet"), object: nil)
        
    }
    @objc func loadList(){
        self.tablekategori.reloadData()
        getwallet()
    }
    func getwallet(){
        let header = ["token":Config.token]
        
        print("asasd "+Config.token)
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"mywallet"), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["name_wallet"].unsafelyUnwrapped)
                    self.elements = array
                    
                    self.tablekategori?.reloadData()
                }
            }
        }
    }
    
    func rupiah(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = ","
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablekategori.dequeueReusableCell(withIdentifier: "customcell") as! WalletCell
        
        if elements.count>0
        {
            let eachelement = elements[indexPath.row]
            print(eachelement)
            cell.nama?.text = eachelement["name_wallet"] as? String ?? ""
            cell.img.image  = UIImage(named: "icon")
            let nominal = eachelement["nominal_wallet"] as? Double
            cell.harga?.text = "Rp. "+rupiah(nominal!)
            
            
            
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

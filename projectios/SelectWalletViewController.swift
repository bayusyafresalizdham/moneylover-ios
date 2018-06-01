//
//  SelectWalletViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 01/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire
class SelectWalletViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    

    @IBAction func cancelclick(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var tablewallet: UITableView!
    var elements = [[String:Any]]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablewallet.dequeueReusableCell(withIdentifier: "basictable", for: indexPath)
        
        let eachelement = elements[indexPath.row]
        let name = eachelement["name_wallet"] as? String ?? ""
            cell.textLabel?.text = name
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablewallet.delegate = self;
        tablewallet.dataSource = self;
        getAllWallet()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eachelement = elements[indexPath.row]
        let id = eachelement["id_wallet"] as? String ?? ""
        let nama = eachelement["name_wallet"] as? String ?? ""
        Config.add_wallet_name = nama
        Config.add_wallet_id = id
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setwallet"), object: nil)
        dismiss(animated: true)
    }
    func getAllWallet(){
        let header = ["token":Config.token]
        
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
                    self.tablewallet?.reloadData()
                }
            }
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

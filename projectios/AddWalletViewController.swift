//
//  AddWalletViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 02/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire
class AddWalletViewController: UIViewController {

    @IBOutlet weak var edit_name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func save_click(_ sender: Any) {
        addwallet(walletname: edit_name.text!)
    }
    func addwallet( walletname:String){
        
        let header = ["token":Config.token]
        let body = ["walletname":walletname]
        Alamofire.request(Config.base_url+Config.getAPI(jenis: "wallet"),method: .post,parameters:body,headers:header).responseJSON { response in
            if let json : [String : Any] = response.result.value as?[String:Any] {
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if(status == 1 && message == "wallet berhasil ditambah"){
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadwallet"), object: nil)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    @IBAction func cancel_click(_ sender: Any) {
         dismiss(animated: true)
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

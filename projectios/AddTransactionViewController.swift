//
//  AddTransactionViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 01/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire
class AddTransactionViewController: UIViewController {

    @IBOutlet weak var notek: UITextField!
    @IBOutlet weak var cat_name: UILabel!
    @IBOutlet weak var wallet_name: UILabel!
    @IBOutlet weak var date_name: UILabel!
    @IBOutlet weak var btnadd: UIButton!
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var nominal: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWallet), name: NSNotification.Name(rawValue: "setwallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setDate), name: NSNotification.Name(rawValue: "settanggal"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(setCat), name: NSNotification.Name(rawValue: "setkategori"), object: nil)
    }
    @objc func setCat(){
        cat_name.text = Config.add_cat_name
        print("cok")
    }
    @objc func setWallet(){
        wallet_name.text = Config.add_wallet_name
    }
    @objc func setDate(){
        date_name.text = Config.add_date
    }
    @IBAction func addclick(_ sender: Any) {
        tambahtransaksi(sender,nominal: nominal.text!, note: notek.text!, with_name: "", id_wallet_user: Config.add_wallet_id, id_category: Config.add_cat_id,date:Config.add_date)
    }
    func tambahtransaksi(_ sender:Any, nominal:String,note:String,with_name:String,id_wallet_user:String,id_category:String,date:String){
        
        let header = ["token":Config.token]
        let body = ["nominal":nominal,"note":note,"with_name":with_name,"id_wallet_user":id_wallet_user,
                    "id_category":id_category,"date":date]
        //let body = ["email":"bayusyafresalizdham@gmail.com","password":"bayuganteng2312"]
        Alamofire.request(Config.base_url+Config.getAPI(jenis: "transaction"),method: .post,parameters:body,headers:header).responseJSON { response in
            if let json : [String : Any] = response.result.value as?[String:Any] {
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if(status == 1 && message == "data berhasil di tambahkan"){
                    _ =  self.navigationController?.popToRootViewController(animated: false)
                    print(message)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

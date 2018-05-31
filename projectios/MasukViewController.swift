//
//  MasukViewController.swift
//  projectios
//
//  Created by DaFIDS on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import RealmSwift

class MasukViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.text="bayusyafresalizdham@gmail.com"
        passwordText.text = "bayuganteng2312"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
   
    @IBAction func loginTapped(_ sender: Any) {
      
        if let email = emailText.text {
            if let password = passwordText.text{
             
                cekuser(usr: email,pass: password){
                    (status,message,token) in
                    if(status==0)
                    {
                        print("tes2")
                        self.presentAlert(alert: message)
                    }else
                    {
                        print("tes3")
                        print(status)
                        Config.uID = email
                        Config.token = token
                        let realm = try! Realm()
                        let puppies = realm.objects(DBUser.self).count
                        if String(puppies) == "0"{
                            print("token")
                            let user = DBUser()
                            user.token = token
                            user.email = email
                            try! realm.write {
                                realm.add(user)
                            }
                        }else{
                            print("token1")
                        }
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                }
            }else
            {
                presentAlert(alert: "Email dan Password tidak boleh kosong")
            }
        }else{
            presentAlert(alert: "Email dan Password tidak boleh kosong")
        }
        
    }
    func cekuser(usr:String,pass:String,complete:@escaping (_ status:Int,_ message:String,_ token:String)->Void){
        let body = ["email":usr,"password":pass]
         //let body = ["email":"bayusyafresalizdham@gmail.com","password":"bayuganteng2312"]
        Alamofire.request(Config.base_url+Config.getAPI(jenis: "login"),method: .post,parameters:body,headers:nil).responseJSON { response in
            if let json : [String : Any] = response.result.value as?[String:Any] {
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                // print(json["status"].unsafelyUnwrapped)//0 username password salah//1 login benar
                //status = json["status"].unsafelyUnwrapped as! Int
                var result : [String:Any] = json["data"] as![String:Any]
                var token = ""
                if result["token"] != nil {
                    token = result["token"].unsafelyUnwrapped as! String
                }
                complete(status,message,token)
            }
        }
        // if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        //    print("Data: \(utf8Text)") // original server data as UTF8 string
        // }
    }
    
    func presentAlert(alert:String){
        let alertVC = UIAlertController(title:"Error",message:alert,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }


}

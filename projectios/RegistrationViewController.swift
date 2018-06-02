//
//  RegistrationViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: UIViewController {

    @IBOutlet weak var textRegisEmail: UITextField!
    @IBOutlet weak var textRegisPassword: UITextField!
    @IBOutlet weak var btnDaftar: UIButton!
    @IBAction func btnLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pindahlogin", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func daftarClick(_ sender: Any) {
        var email = textRegisEmail.text._rlmInferWrappedType()
        
        var password = textRegisPassword.text._rlmInferWrappedType()
        if(email != "" && password != "") {
            let body = ["email":email,"password":password]
            
            Alamofire.request(Config.base_url+Config.getAPI(jenis: "register"),method: .post,parameters:body,headers:nil).responseJSON { response in
                if let json : [String : Any] = response.result.value as?[String:Any] {
                    let message=json["message"].unsafelyUnwrapped as!String
                    let status = json["status"].unsafelyUnwrapped as!Int
                    // print(json["status"].unsafelyUnwrapped)//0 username password salah//1 login benar
                    //status = json["status"].unsafelyUnwrapped as! Int
                    let alert = UIAlertController(title: "Register", message: "Register Berhasil!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        self.performSegue(withIdentifier: "pindahlogin", sender: self)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
        else {
            if(email == "") {
                let alert = UIAlertController(title: "Email tidak boleh kosong!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if(password == "") {
                let alert = UIAlertController(title: "Password tidak boleh kosong!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
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

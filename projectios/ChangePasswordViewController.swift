//
//  ChangePasswordViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 02/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var now: UITextField!
    @IBOutlet weak var new: UITextField!
    @IBOutlet weak var ulang: UITextField!
    @IBAction func btnSimpan(_ sender: Any) {
        var sekarang = now.text._rlmInferWrappedType()
        
        var baru = new.text._rlmInferWrappedType()
        
        var ulangi = ulang.text._rlmInferWrappedType()
        
        if(baru != ulangi) {
            let alert = UIAlertController(title: "Konfirmasi password tidak sesuai", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let body = ["old":sekarang,"new":baru,"confirm":ulangi]
            Alamofire.request(Config.base_url+Config.getAPI(jenis: "register"),method: .post,parameters:body,headers:nil).responseJSON { response in
                if let json : [String : Any] = response.result.value as?[String:Any] {
                    let message=json["message"].unsafelyUnwrapped as!String
                    let status = json["status"].unsafelyUnwrapped as!Int
                    let alert = UIAlertController(title: "Change Password", message: "Change Password Berhasil!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Password"
        
        
        
        // Do any additional setup after loading the view.
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

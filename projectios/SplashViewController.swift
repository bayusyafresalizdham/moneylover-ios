//
//  SplashViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import RealmSwift
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        let puppies = realm.objects(DBUser.self).count
        
        if String(puppies) == "0"{
            print("pindah")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let move = storyboard.instantiateViewController(withIdentifier: "PreInstallViewController") as! PreInstallViewController
            self.navigationController?.pushViewController(move, animated: true)
        }else{
            print("gak pindah")
            let puppies = realm.objects(DBUser.self).first
            Config.uID = (puppies?.email)!
            Config.token = (puppies?.token)!
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let move = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(move, animated: true)
        }
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

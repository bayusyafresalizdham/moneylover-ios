//
//  OtherViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import RealmSwift

class OtherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var uID: UILabel!
    @IBOutlet weak var tablemenu: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elemen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablemenu.dequeueReusableCell(withIdentifier: "customcell") as! MenuCell
        cell.title.text = elemen[indexPath.row]
        cell.img.image = UIImage(named: image[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            performSegue(withIdentifier: "ubahpassword", sender: self)
        }else if(indexPath.row == 1){
            let url = NSURL(string: "http://note.moneylover.me/")!
            UIApplication.shared.openURL(url as URL as URL)
        }else if(indexPath.row == 2){
            let url = NSURL(string: "https://web.facebook.com/moneylover.me/")!
            UIApplication.shared.openURL(url as URL as URL)
        }else if(indexPath.row == 3){
            performSegue(withIdentifier: "pindahabout", sender: self)
        }
        else if(indexPath.row == 4) {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            performSegue(withIdentifier: "pindahlogin", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    let elemen = ["Pengelolaan Akun","Jelajahi Money Lover","Bantuan & Dukungan"
        ,"Tentang", "Keluar"]
    let image = ["icon_menu","icon_jelajahi","icon_bantuan","icon_tentang","icon_logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tablemenu.delegate = self;
        tablemenu.dataSource = self;
        tablemenu.rowHeight = 50;
        tablemenu.estimatedRowHeight = 50;
        self.title = "Other"
        uID.text = Config.uID
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

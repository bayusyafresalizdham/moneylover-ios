//
//  OtherViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

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
        performSegue(withIdentifier: "pindahDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    let elemen = ["Pengelolaan Akun","Dompet Saya","Jelajahi Money Lover","Bantuan & Dukungan"
        ,"Tentang", "Keluar"]
    let image = ["icon_menu","icon_dompet","icon_jelajahi","icon_bantuan","icon_tentang","icon_logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tablemenu.delegate = self;
        tablemenu.dataSource = self;
        tablemenu.rowHeight = 50;
        tablemenu.estimatedRowHeight = 50;
        self.title = "Other"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

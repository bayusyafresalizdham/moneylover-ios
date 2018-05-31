//
//  HistoriViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 30/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class HistoriViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elemen.count
    }
    @IBAction func addclick(_ sender: Any) {
        print("add new")
    }
    
    @IBOutlet weak var coba: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coba.dequeueReusableCell(withIdentifier: "customcell") as! HistoriCell
        cell.title.text = elemen[indexPath.row]
        cell.img.image = UIImage(named: image[indexPath.row])
        cell.desk.text = tgl[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pindahDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    let elemen = ["Makanan India","Makanan Cina","Makanan Mexico","Makanan Jepang"
        ,"Makanan Indonesia", "Makanan Italia","Makanan Thailand","Makanan Perancis","Makanan Malaysia","Makanan America Utara"]
    let image = ["icon","icon","icon","icon","icon","icon","icon","icon","icon","icon"]
    let tgl = ["23 Januari 2018","24 Januari 2018","25 Januari 2018","1 Februari 2018",
               "1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018"]
    override func viewDidLoad() {
        super.viewDidLoad()
        coba.delegate = self;
        coba.dataSource = self;
        coba.rowHeight = 110;
        coba.estimatedRowHeight = 110;
        self.title = "History"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

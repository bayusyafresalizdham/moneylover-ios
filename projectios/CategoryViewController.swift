//
//  CategoryViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tablekategori: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elemen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablekategori.dequeueReusableCell(withIdentifier: "customcell") as! CategoryCell
        cell.title.text = elemen[indexPath.row]
        cell.img.image = UIImage(named: image[indexPath.row])
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
        tablekategori.delegate = self;
        tablekategori.dataSource = self;
        tablekategori.rowHeight = 60;
        tablekategori.estimatedRowHeight = 60;
        self.title = "Category"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

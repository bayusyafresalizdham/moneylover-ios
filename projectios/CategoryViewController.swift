//
//  CategoryViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tablekategori: UITableView!
    
    var elements = [[String:Any]]()
    var elemen = ["Makanan India","Makanan Cina","Makanan Mexico","Makanan Jepang"
        ,"Makanan Indonesia", "Makanan Italia","Makanan Thailand","Makanan Perancis","Makanan Malaysia","Makanan America Utara"]
    var image = ["icon","icon","icon","icon","icon","icon","icon","icon","icon","icon"]
    var tgl = ["23 Januari 2018","24 Januari 2018","25 Januari 2018","1 Februari 2018",
               "1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018","1 Februari 2018"]
   
    @IBOutlet weak var Segmen1: UISegmentedControl!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
     
        return elements.count
    }
    @IBAction func changeSegmen1(sender: UISegmentedControl) {
        
        elemen.removeAll()
        image.removeAll()
        tgl.removeAll()
        if(sender.selectedSegmentIndex==0)
        {
            getKategoriExpense()
         tablekategori.tag = 0
        }else if (sender.selectedSegmentIndex==1)
        {
            
            getKategoriIncome()
           
         tablekategori.tag = 1
        }else if (sender.selectedSegmentIndex==2){
            tablekategori.tag = 2
            getKategoriOther()
            
        }
        print(image)
        print(elemen.count)
        tablekategori.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablekategori.dequeueReusableCell(withIdentifier: "customcell") as! CategoryCell
        
        if elements.count>0
        {
            let eachelement = elements[indexPath.row]
            print(eachelement)
            cell.title?.text = eachelement["category_name"] as? String ?? ""
            cell.img?.image = UIImage(named: eachelement["category_img"] as? String ?? "icon")
        }
       // cell.title.text = elemen[indexPath.row]
        //cell.img.image = UIImage(named: image[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pindahDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        tablekategori.delegate = self;
        tablekategori.dataSource = self;
        tablekategori.rowHeight = 60;
        tablekategori.estimatedRowHeight = 60;
        self.title = "Category"
        getKategoriExpense()
        
       
        
    }
    
    func getAllKategori(){
        let header = ["token":Config.token]
        
        
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"category"), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["name_wallet"].unsafelyUnwrapped)
                    self.elements = array
                    self.tablekategori?.reloadData()
                }
            }
        }
    }
    func getKategoriIncome(){
        let header = ["token":Config.token]
        
        
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"category/income"), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["name_wallet"].unsafelyUnwrapped)
                    self.elements = array
                    
                    self.tablekategori?.reloadData()
                }
            }
        }
    }
    func getKategoriExpense(){
        let header = ["token":Config.token]
        
        
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"category/expense"), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["name_wallet"].unsafelyUnwrapped)
                    self.elements = array
                    
                    self.tablekategori?.reloadData()
                }
            }
        }
    }
    func getKategoriOther(){
        let header = ["token":Config.token]
        
        
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"category/other"), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["name_wallet"].unsafelyUnwrapped)
                   
                   self.elements = array
                    
                    self.tablekategori?.reloadData()
                }
            }
        }
    }
    
  //  override func didReceiveMemoryWarning() {
       // super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}

}

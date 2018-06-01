//
//  SelectCategoryViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 01/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire
class SelectCategoryViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    var elements = [[String:Any]]()
    
    @IBOutlet weak var segmentcategory: UISegmentedControl!
    @IBOutlet weak var tablecategory: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablecategory.dequeueReusableCell(withIdentifier: "basictable", for: indexPath)
        
        let eachelement = elements[indexPath.row]
        cell.textLabel?.text = eachelement["category_name"] as? String ?? ""
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablecategory.delegate = self;
        tablecategory.dataSource = self;
        getKategoriExpense()
        // Do any additional setup after loading the view.
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
                    
                    self.tablecategory?.reloadData()
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
                    
                    self.tablecategory?.reloadData()
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
                    
                    self.tablecategory?.reloadData()
                }
            }
        }
    }
    @IBAction func clickbutton(_ sender: Any) {
       dismiss(animated: true)
    }
    @IBOutlet weak var cancel_click: UIButton!
    @IBAction func segmentchange(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0)
        {
            getKategoriExpense()
        }else if (sender.selectedSegmentIndex==1)
        {
            getKategoriIncome()
        }else if (sender.selectedSegmentIndex==2){
            getKategoriOther()
        }
        tablecategory.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eachelement = elements[indexPath.row]
        let nama = eachelement["category_name"] as? String ?? ""
        let id = eachelement["id_category"] as? String ?? ""
        Config.add_cat_name = nama
        Config.add_cat_id = id
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setkategori"), object: nil)
        dismiss(animated: true)
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

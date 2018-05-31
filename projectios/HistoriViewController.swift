//
//  HistoriViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 30/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import Alamofire
class HistoriViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tanggal: UISegmentedControl!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var coba: UITableView!
    var elements = [[String:Any]]()
    var dateList : Array<String> = Array()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    @IBAction func changesegment(_ sender: Any) {
    }
    @IBAction func addclick(_ sender: Any) {
        print("add new")
    }
    @IBAction func changesegmen(_ sender: UISegmentedControl) {
        
        getHistori(tanggalnow: dateList[sender.selectedSegmentIndex])
        coba.reloadData()
    }
    func getHistori(tanggalnow : String){
        let header = ["token":Config.token]
        Alamofire.request(Config.base_url+Config.getAPI(jenis:"transactionall/"+tanggalnow), method:.get,parameters:nil,encoding:JSONEncoding.default,headers:header).responseJSON{
            response in
            if let json : [String:Any] = response.result.value as?[String:Any]{
                let message=json["message"].unsafelyUnwrapped as!String
                let status = json["status"].unsafelyUnwrapped as!Int
                //print("coba"+message)
                if let array = json["data"] as? [[String: Any]] {
                    //If you want array of task id you can try like
                    //let name_wallet = array.flatMap { $0["name_wallet"] as? String }
                    //print(array[0]["nominal"].unsafelyUnwrapped)
                    self.elements = array
                    
                    self.coba?.reloadData()
                }
            }
        }
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    func dayOfWeek(val:Int)->String{
        if(val == 1){
            return "Sunday";
        }else if(val == 2){
            return "Monday";
        }else if(val == 3){
            return "Thuesday";
        }else if(val == 4){
            return "Wednesday";
        }else if(val == 5){
            return "Thursday";
        }else if(val == 6){
            return "Friday";
        }else if(val == 7){
            return "Saturday";
        }else {
            return "";
        }
    }
    func monthOfYear(val:Int)->String{
        if(val == 1){
            return "January";
        }else if(val == 2){
            return "February";
        }else if(val == 3){
            return "Maret";
        }else if(val == 4){
            return "April";
        }else if(val == 5){
            return "May";
        }else if(val == 6){
            return "June";
        }else if(val == 7){
            return "July";
        }else if(val == 8){
            return "August";
        }else if(val == 9){
            return "September";
        }else if(val == 10){
            return "Oktober";
        }else if(val == 11){
            return "November";
        }else if(val == 12){
            return "Desember";
        }else {
            return "";
        }
    }
    func rupiah(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = ","
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coba.dequeueReusableCell(withIdentifier: "customcell") as! HistoriCell
        if elements.count>0
        {
            let eachelement = elements[indexPath.row]
            cell.title?.text = eachelement["category_name"] as? String ?? ""
            let icon = eachelement["category_img"] as? String ?? "icon";
            let day = eachelement["date"] as? String ?? "";
            let nominal = eachelement["nominal"] as? String ?? "";
            let weekday = getDayOfWeek(day)
            let date = day.components(separatedBy: "-")
            let month = monthOfYear(val: Int(date[1])!)
            let type = eachelement["category_type"] as? String ?? "";
            let cat_name = eachelement["category_name"] as? String ?? ""
            let url = URL(string: Config.base_img_url+icon)
            cell.img.kf.setImage(with: url)
            cell.date.text = date[2]
            cell.bulantahun.text = month+" "+date[0]
            cell.price.text = "Rp. "+rupiah(Double(nominal)!)
            if(type == "0"){
                cell.pricetype.text = "Rp. - "+rupiah(Double(nominal)!)
                cell.price.textColor = UIColor.red
            }else if(type == "1"){
                cell.pricetype.text = "Rp. "+rupiah(Double(nominal)!)
                cell.price.textColor = hexStringToUIColor(hex: "#4493FF")
            }else if(type == "2"){
                if(cat_name == "Debt"){
                    cell.pricetype.text = "Rp. "+rupiah(Double(nominal)!)
                    cell.price.textColor = UIColor(red: 68, green: 147, blue: 255, alpha: 255)
                }else{
                    cell.pricetype.text = "Rp. - "+rupiah(Double(nominal)!)
                    cell.price.textColor = UIColor.red
                }
            }
            cell.day.text = dayOfWeek(val: weekday._rlmInferWrappedType());
            cell.desk.text = eachelement["note"] as? String ?? "";
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pindahDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.coba.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coba.delegate = self;
        coba.dataSource = self;
        coba.rowHeight = 110;
        coba.estimatedRowHeight = 110;
        self.title = "History"
        tanggal.selectedSegmentIndex = 2
        var index : Int = 0
        for i in -2...0 {
            let calendar = Calendar.current
            let twoDaysAgo = calendar.date(byAdding: .day, value: i, to: Date())
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let lastWeekDateString = dateFormatter.string(from: twoDaysAgo!)
            print(lastWeekDateString)
            dateList.append(lastWeekDateString)
            tanggal.setTitle(lastWeekDateString, forSegmentAt: index)
            index = index + 1
        }
        
        getHistori(tanggalnow: dateList[2])


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

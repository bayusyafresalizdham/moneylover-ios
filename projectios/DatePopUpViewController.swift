 //
//  DatePopUpViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 01/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class DatePopUpViewController: UIViewController {

    @IBOutlet weak var tanggal: UIDatePicker!
    @IBOutlet weak var btnsave: UIButton!
    var addItemVC : HistoriViewController? = HistoriViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var cancelkan: UIButton!
    
    @IBAction func tekancancel(_ sender: Any) {
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

         dismiss(animated: true)
    }
    @IBAction func savedata(_ sender: Any) {
        tanggal.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var selectedDate = dateFormatter.string(from: tanggal.date)
        //print(selectedDate)
        Config.datefilter = selectedDate
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
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

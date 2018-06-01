//
//  SelectDateViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 01/06/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {

    @IBOutlet weak var date_add: UIDatePicker!
    @IBOutlet weak var click_save: UIButton!
    @IBAction func click_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func save_click(_ sender: Any) {
        date_add.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var selectedDate = dateFormatter.string(from: date_add.date)
        //print(selectedDate)
        Config.add_date = selectedDate
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settanggal"), object: nil)
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

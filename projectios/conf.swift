//
//  conf.swift
//  projectios
//
//  Created by DaFIDS on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import Foundation

struct Config
{
    static var base_url:String = "https://moneylover.namagz.com/"
    static var base_img_url:String = "https://moneylover.namagz.com/img/";
    static var uID = ""
    static var token = ""
    static var datefilter = ""
    static var walletfilter = ""
    static var add_wallet_name = ""
    static var add_wallet_id = ""
    static var add_cat_name = ""
    static var add_cat_id = ""
    static var add_date = ""
    static func getAPI(jenis:String)->(String){
        return jenis
    }
}

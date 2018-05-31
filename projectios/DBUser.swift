//
//  DBUser.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 31/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit
import RealmSwift
class DBUser: Object {
    @objc dynamic var token = ""
    @objc dynamic var email = ""
}

//
//  Category.swift
//  Todoey
//
//  Created by Kaung Htet Lin on 12/07/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""

    var items = List<Item>()
}

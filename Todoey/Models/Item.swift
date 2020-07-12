//
//  Item.swift
//  Todoey
//
//  Created by Kaung Htet Lin on 12/07/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createDate : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: K.Data.itemProperty)
}

//
//  Person.swift
//  Project10
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/16/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class Person: NSObject {
	var name: String
	var imagePath: String
	init(name: String, imagePath: String) {
		self.name = name
		self.imagePath = imagePath
	}
}

//
//  PersonCollectionViewCell.swift
//  Project10
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/15/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		imageView.layer.borderWidth = 2
		imageView.layer.cornerRadius = 3
		imageView.clipsToBounds = true
		layer.cornerRadius = 7
	}
	
	func configCellWithPerson(_ person: Person) {
		nameLabel.text = person.name
		imageView.image = UIImage(contentsOfFile: person.imagePath)
		
	}
}

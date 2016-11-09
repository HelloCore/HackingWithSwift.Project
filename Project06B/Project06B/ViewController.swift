//
//  ViewController.swift
//  Project06B
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/9/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let label1 = initLabel("THESE", withColor: UIColor.red)
		let label2 = initLabel("ARE", withColor: UIColor.cyan)
		let label3 = initLabel("SOME", withColor: UIColor.yellow)
		let label4 = initLabel("AWESOME", withColor: UIColor.green)
		let label5 = initLabel("LABELS", withColor: UIColor.orange)
		
		view.addSubview(label1)
		view.addSubview(label2)
		view.addSubview(label3)
		view.addSubview(label4)
		view.addSubview(label5)
		
		let viewsDictionary = ["label1":label1,"label2":label2,"label3":label3,"label4":label4,"label5":label5]
//		for key in viewsDictionary.keys {
//			view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(key)]|", options: [], metrics: nil, views: viewsDictionary))
//		}
//		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
//		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
		
//		let metrics = ["labelHeight":88]
//		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
		
		var previous: UILabel!
		for label in viewsDictionary {
			label.value.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
			label.value.heightAnchor.constraint(equalToConstant: 88).isActive = true
			
			if previous != nil {
//				label.value.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
				label.value.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
			}
		
			previous = label.value
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	func initLabel(_ text: String!, withColor color: UIColor!) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = color
		label.text = text
		return label
	}

}


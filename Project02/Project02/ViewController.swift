//
//  ViewController.swift
//  Project02
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/4/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

	@IBOutlet weak var btn1: UIButton!
	@IBOutlet weak var btn2: UIButton!
	@IBOutlet weak var btn3: UIButton!
	
	var countries = ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
	var score = 0
	var correntAnswer = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
		
		btn1.layer.borderWidth = 1
		btn2.layer.borderWidth = 1
		btn3.layer.borderWidth = 1
		
		btn1.layer.borderColor = UIColor.lightGray.cgColor
		btn2.layer.borderColor = UIColor.lightGray.cgColor
		btn3.layer.borderColor = UIColor.lightGray.cgColor
		
		askQuestion()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func askQuestion(action: UIAlertAction? = nil) {
		countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
		correntAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
		title = countries[correntAnswer].uppercased()
		
		btn1.setImage(UIImage(named: countries[0]), for: .normal)
		btn2.setImage(UIImage(named: countries[1]), for: .normal)
		btn3.setImage(UIImage(named: countries[2]), for: .normal)
		
	}
	
	@IBAction func btnClick(_ sender: UIButton) {
		var title: String
		if sender.tag == correntAnswer {
			title = "Correct"
			score += 1
		}else {
			title = "Wrong"
			score -= 1
		}
		
		let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
		
	}
	
}


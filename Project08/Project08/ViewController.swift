//
//  ViewController.swift
//  Project08
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/13/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

	@IBOutlet weak var scoreLabel: UILabel!
	
	@IBOutlet weak var cluesLabel: UILabel!
	@IBOutlet weak var answersLabel: UILabel!
	
	@IBOutlet weak var currentAnswer: UITextField!
	
	@IBOutlet weak var btnAreaView: UIView!
	
	var letterBtns = [UIButton]()
	var activedBtns = [UIButton]()
	var solutions = [String]()
	
	var score:Int = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var level = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		for subview in btnAreaView.subviews {
			let btn = subview as! UIButton
			letterBtns.append(btn)
			btn.addTarget(self, action: #selector(letterBtnClick), for: .touchUpInside)
		}
		
		loadLevel()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func submitBtnClick(_ sender: Any) {
		if let solutionPosition = solutions.index(of: currentAnswer.text!) {
			activedBtns.removeAll()
			
			var splitClues = answersLabel.text!.components(separatedBy: "\n")
			splitClues[solutionPosition] = currentAnswer.text!
			answersLabel.text = splitClues.joined(separator: "\n")
			
			currentAnswer.text = ""
			score += 1
			if score % 7 == 0 {
				let ac = UIAlertController(title: "Well Done!!", message: "Are you ready for the next level?", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "Lets Go!", style: .default, handler: levelUp))
				present(ac, animated: true)
			}
		} else {
			let ac = UIAlertController(title: "You submitted the wrong answer!!", message: "Please try again", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .cancel))
			present(ac, animated: true)
		}
	}

	@IBAction func clearBtnClick(_ sender: Any) {
		currentAnswer.text = ""
		
		for btn in activedBtns {
			btn.isHidden = false
		}
		
		activedBtns.removeAll()
	}
	
	func letterBtnClick(_ sender: UIButton) {
		currentAnswer.text = currentAnswer.text! + sender.titleLabel!.text!
		activedBtns.append(sender)
		sender.isHidden = true
	}
	
	func loadLevel() {
		var clueString = ""
		var solutionString = ""
		var letterBits = [String]()
		if let bundlePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
			if let levelContents = try? String(contentsOfFile: bundlePath) {
				var lines = levelContents.components(separatedBy: "\n")
				
				lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
				for (index,line) in lines.enumerated() {
					let parts = line.components(separatedBy: ":")
					let answer = parts[0]
					let clue = parts[1]
					
					clueString+="\(index + 1). \(clue)\n"
					
					let solutionWord = answer.replacingOccurrences(of: "|", with: "")
					solutionString += "\(solutionWord.characters.count) letters \n"
					solutions.append(solutionWord)
					
					let bits = answer.components(separatedBy: "|")
					letterBits += bits
				}
			}
		}
		
		cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
		answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
		
		letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
		if letterBits.count == letterBtns.count {
			for i in 0..<letterBits.count {
				letterBtns[i].setTitle(letterBits[i], for: .normal)
			}
		}
	}
	
	func levelUp(action: UIAlertAction) {
		level += 1
		solutions.removeAll(keepingCapacity: true)
		
		loadLevel()
		
		for btn in letterBtns {
			btn.isHidden = false
		}
	}
	
}


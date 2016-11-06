//
//  ViewController.swift
//  Project05
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/6/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {

	var allWords = [String]()
	var usedWords = [String]()
	var scoreLabel: UILabel!
	var realScore = 0
	var score: Int{
		get {
			return realScore
		}
		set(newValue) {
			realScore = newValue
			scoreLabel.text = "[\(realScore)]"
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
		
		let restartBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(checkStartGame))
		let barSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let scoreLabelBar = UIBarButtonItem(customView: scoreLabel)
		
		navigationItem.leftBarButtonItems = [scoreLabelBar, barSpacer, restartBtn]
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnwer))
		
		if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
			if let startWords = try? String(contentsOfFile: startWordsPath) {
				allWords = startWords.components(separatedBy: "\n")
			}
		}else{
			allWords = ["WTF"]
		}
		startGame()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func checkStartGame() {
		let ac = UIAlertController(title: "Warning!!", message: "Do you want to restart game", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "YES", style: .default) { action in
			self.startGame()
		})
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		
		present(ac,animated: true)
	}

	func startGame() {
//		allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
		let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: allWords.count)
		score = 0
		title = allWords[randomIndex]
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usedWords.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		return cell
	}
	
	func promptForAnwer() {
		let ac = UIAlertController(title: "Enter Answer:", message: nil, preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Submit", style: .default) { (action) in
			let answer = ac.textFields!.first
			self.submit(answer: answer?.text)
		})
		
		present(ac,animated: true)
	}
	
	func submit(answer: String!) {
		let errMsg: String
		let errTitle: String
		
		if  answer.characters.count > 0 {
			let lowerCasedAnswer = answer.lowercased()
			if !isPossible(word: lowerCasedAnswer) {
				errTitle = "Word not possible"
				errMsg = "You can't spell that word from '\(title!.lowercased())'!"
			}else if !isOriginal(word: lowerCasedAnswer) {
				errTitle = "Word used already"
				errMsg = "Be more original!"
			}else if !isReal(word: lowerCasedAnswer) {
				errTitle = "Word not recognised"
				errMsg = "You can't just make them up, you know!"
			}else {
				score += 1
				usedWords.insert(answer!, at: 0)
				tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
				return
			}
		}else{
			errTitle = "Word cannot be null"
			errMsg = "You must answer!"
		}
		
		let ac = UIAlertController(title: errTitle, message: errMsg, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac,animated: true)
	}
	
	
	func isPossible(word: String) -> Bool {
		if word.characters.count < 3 {
			return false
		}
		var tempWord = title!.lowercased()
		for letter in word.characters {
			if let pos = tempWord.range(of: String(letter)) {
				tempWord.remove(at: pos.lowerBound)
			}else{
				return false
			}
		}
		return true
	}
	
	func isOriginal(word: String) -> Bool {
		return !usedWords.contains(word)
	}
	
	func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSMakeRange(0, word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		
		return misspelledRange.location == NSNotFound
	}
	
	
}


//
//  ViewController.swift
//  Project01
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/3/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	var pictureList = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		title = "Choose Image"
		
		let fileManager = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fileManager.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasSuffix(".png") {
				pictureList.append(item)
			}
		}
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictureList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = pictureList[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailedViewController {
			detailVC.imageName = pictureList[indexPath.row]
			navigationController?.pushViewController(detailVC, animated: true)
		}
			
	}

}


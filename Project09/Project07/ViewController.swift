//
//  ViewController.swift
//  Project07
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/12/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

struct Petition {
	let title : String
	let body : String
	let sigs : String
	
	init(_ obj: JSON){
		self.title = obj["title"].stringValue
		self.body = obj["body"].stringValue
		self.sigs = obj["signatureCount"].stringValue
	}
}

class ViewController: UITableViewController {

	var petitions = [Petition]()
	var labels = [UILabel]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
			let urlStr:String
			if self.navigationController?.tabBarItem.tag == 0 {
				urlStr = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
			}else {
				urlStr = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
			}
			if let url = URL(string: urlStr) {
				if let data = try? Data(contentsOf: url) {
					let json = JSON(data: data)
					
					if(json["metadata"]["responseInfo"]["status"].intValue == 200){
						self.parse(json: json)
						return
					}
				}
			}
			
			DispatchQueue.main.async { [unowned self] in
				let ac = UIAlertController(title: "Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "OK", style: .cancel))
				self.present(ac, animated: true)
			}
		}		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = petitions[indexPath.row]
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailedViewController()
		vc.petition = petitions[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func parse(json:JSON) {
		for result in json["results"].arrayValue {
			petitions.append(Petition(result))
		}
		
		DispatchQueue.main.async { [unowned self] in
			self.tableView.reloadData()
		}
	}
}


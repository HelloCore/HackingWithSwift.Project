//
//  ViewController.swift
//  Project10
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/15/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

	var people = [Person]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return people.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCollectionViewCell
		personCell.configCellWithPerson(people[indexPath.item])
		return personCell
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let person = people[indexPath.item]
		let ac = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.addAction(UIAlertAction(title: "OK", style: .default) {  [unowned self, ac, indexPath] _ in
			let newName = ac.textFields!.first!
			person.name = newName.text!
			
			self.collectionView?.reloadItems(at: [indexPath])
		})
		present(ac,animated: true)
	}
	
	func addPerson() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths.first!
	}
}

extension ViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		if let jpegData = UIImageJPEGRepresentation(image, 80) {
			try? jpegData.write(to: imagePath)
		}
		
		people.append(Person(name: "UNKNOW",imagePath: imagePath.path))
		collectionView?.reloadData()
		dismiss(animated: true)
	}
}

extension ViewController: UINavigationControllerDelegate {
	
}


//
//  DetailedViewController.swift
//  Project01
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/3/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import Social

class DetailedViewController: UIViewController {

	@IBOutlet weak var mainImageView: UIImageView!
	var imageName:String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "View Image"
		if let imgName = imageName {
			mainImageView.image = UIImage(named: imgName)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedClick))
		
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.hidesBarsOnTap = false
		super.viewWillDisappear(animated)
	}
    
	func sharedClick(){
//		let vc = UIActivityViewController(activityItems: [mainImageView.image!], applicationActivities: nil)
//		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//		present(vc,animated: true)
		
		if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
			vc.setInitialText("Hello World")
			vc.add(mainImageView.image)
			vc.add(URL(string: "https://github.com/HelloCore/HackingWithSwift.Project"))
			present(vc,animated: true)
		}
		
	}
}

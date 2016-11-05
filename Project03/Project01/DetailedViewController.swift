//
//  DetailedViewController.swift
//  Project01
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/3/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

	@IBOutlet weak var mainImageView: UIImageView!
	var imageName:String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "View Image"
		if let imgName = imageName {
			mainImageView.image = UIImage(named: imgName)
		}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.hidesBarsOnTap = false
		super.viewWillDisappear(animated)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

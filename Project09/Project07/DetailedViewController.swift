//
//  DetailedViewController.swift
//  Project07
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/12/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {

	var webView: WKWebView!
	var petition: Petition!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		guard petition != nil else { return }
		
		var html = "<html>"
		html += "<head>"
		html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
		html += "<style> body { font-size: 150%; } </style>"
		html += "</head>"
		html += "<body>"
		html += petition.body
		html += "</body>"
		html += "</html>"
		webView.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func loadView() {
		webView = WKWebView()
		view = webView
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

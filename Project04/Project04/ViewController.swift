//
//  ViewController.swift
//  Project04
//
//  Created by AKKHARAWAT CHAYAPIWAT on 11/5/16.
//  Copyright © 2016 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

	
	var webView: WKWebView!
	var progressView: UIProgressView!

	let websites = ["apple","hackingwithswift"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let url = URL(string: "https://\(websites[1]).com")!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(rightBarClick))
		
		let progressBar = UIBarButtonItem(customView: progressView)
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refreshBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
	
		toolbarItems = [progressBar,spacer,refreshBtn]
		navigationController?.isToolbarHidden = false
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == #keyPath(WKWebView.estimatedProgress) {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func openPage(action:UIAlertAction!) {
		let url = URL(string: "https://" + action.title! + ".com")!
		webView.load(URLRequest(url: url))
	}
	
	func rightBarClick() {
		let ac = UIAlertController(title: "Open Page..", message: nil, preferredStyle: .actionSheet)
		for website in websites {
			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(ac,animated: true)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url
		if let host = url!.host {
			for website in websites {
				if host.range(of: website) != nil {
					decisionHandler(.allow)
					return
				}
			}
		}
		
		decisionHandler(.cancel)
	}
}


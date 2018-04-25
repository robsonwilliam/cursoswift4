//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by T1aluno10 on 25/04/18.
//  Copyright © 2018 T1aluno10. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    
    override func loadView() {
        //let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView() //frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}

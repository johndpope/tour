//
//  WebUtilitiesViewController.swift
//  Tour
//
//  Created by tnt on 6/2/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class WebUtilitiesViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    var itemselect:Utilities = Utilities()
    
    
    @IBOutlet weak var iconLoading: UIActivityIndicatorView!
   
    
    @IBAction func btnRefresh(_ sender: Any) {
        webview.reload()
    }
    
    @IBAction func goBack(_ sender: Any) {
        webview.goBack()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = itemselect._label
        let url:URL = URL(string:itemselect._link)!
        iconLoading.startAnimating()
        webview.loadRequest(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        iconLoading.startAnimating()
        iconLoading.isHidden = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        iconLoading.stopAnimating()
        iconLoading.isHidden = true
    }

}

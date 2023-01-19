//
//  StartController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit
import WebKit

class StartScreen: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        guard let url = Bundle.main.url(forResource: "jumbo", withExtension: "gif"),
           let data = try? Data(contentsOf: url),
           let baseURL = Foundation.URL(string: "about:blank") else {
          return
        }
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: baseURL)
      }
}

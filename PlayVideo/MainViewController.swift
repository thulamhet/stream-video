//
//  MainViewController.swift
//  PlayVideo
//
//  Created by Nguyễn Công Thư on 29/05/2023.
//

import UIKit
import WebKit
var myPlayer: WKWebView!
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
       webConfiguration.allowsInlineMediaPlayback = true
       webConfiguration.mediaTypesRequiringUserActionForPlayback = []

       myPlayer = WKWebView(frame: CGRect(x: 0, y: 0, width: 375, height: 300), configuration: webConfiguration)
       self.view.addSubview(myPlayer)

       if let videoURL:URL = URL(string: "https://om-other.vnpay.vn/test.mp4") {
            let request:URLRequest = URLRequest(url: videoURL)
            myPlayer.load(request)
       }
    }
}

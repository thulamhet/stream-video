//
//  MainViewController.swift
//  PlayVideo
//
//  Created by Nguyễn Công Thư on 29/05/2023.
//

import UIKit
import WebKit
class MainViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    let screenSize: CGRect = UIScreen.main.bounds
    var videoURL:URL!
    var isYTB: Bool = false
    
    override func viewDidLoad() {
//        let url = "https://www.youtube.com/watch?v=RlTDbIutJsU&ab_channel=Lucin3x"
      let url = "https://om-other.vnpay.vn/test.mp4"
        if url.contains("youtube.com") {
            guard let videoID = extractYouTubeVideoID(url) else {
                print("Invalid YouTube URL")
                return
            }
            let youtubeVideoURL = "https://www.youtube.com/embed/\(videoID)"
            videoURL = URL(string: youtubeVideoURL)
            isYTB = true
        } else {
            isYTB = false
            videoURL = URL(string: url)
        }
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    var embedVideoHtml:String {
            return """
            <!DOCTYPE html>
            <html>
            <body>
            <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
            <div id="player"></div>

            <script>
            var tag = document.createElement('script');

            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

            var player;
            function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
            playerVars: { 'autoplay': 1, 'controls': 0, 'playsinline': 1 },
            height: '\(webView.frame.height)',
            width: '\(webView.frame.width)',
            videoId: '\(videoURL.lastPathComponent)',
            events: {
            'onReady': onPlayerReady
            }
            });
            }

            function onPlayerReady(event) {
            event.target.playVideo();
            }
            </script>
            </body>
            </html>
            """
        }
    
    @IBAction func didSelectPlayBtn(_ sender: Any) {
        if isYTB {
            webView.loadHTMLString(embedVideoHtml, baseURL: nil)
        } else {
            webView.load(URLRequest(url: videoURL!))
        }
    }
    
    func extractYouTubeVideoID(_ url: String) -> String? {
        if let videoID = URLComponents(string: url)?.queryItems?.first(where: { $0.name == "v" })?.value {
            return videoID
        }
        return nil
    }
}

extension MainViewController: WKNavigationDelegate, WKUIDelegate {
}

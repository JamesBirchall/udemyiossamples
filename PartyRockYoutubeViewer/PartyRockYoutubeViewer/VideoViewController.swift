//
//  VideoViewController.swift
//  PartyRockYoutubeViewer
//
//  Created by James Birchall on 08/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Private Viariables
    
    private var webView: WKWebView!
    private var _videoModel: VideoModel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK: - Public Methods
    
    var videoModel: VideoModel {
        get {
            return _videoModel
        }
        
        set {
            _videoModel = newValue
            print("Model Setup for Video")
        }
    }
    
    // MARK: - Override Methods for Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        
        let frameForWebView = CGRect(x: 0, y: 0, width: 300, height: 200)
        webView = WKWebView(frame: frameForWebView, configuration: webConfiguration)
        webView.center = view.center
        webView.uiDelegate = self
        view.addSubview(webView)
        
        view.backgroundColor = UIColor.blue

        let myURL = URL(string: videoModel.videoURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // finally set navigation title
        navigationBar.topItem?.title = videoModel.videoTitle

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }

}

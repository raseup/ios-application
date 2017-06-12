//
//  DashboardViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var videoPlayer_Test: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/8Cee03T9cDY") else { return }
        videoPlayer_Test.loadRequest( URLRequest(url: youtubeURL) )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


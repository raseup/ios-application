//
//  LoginViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeLoginButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}


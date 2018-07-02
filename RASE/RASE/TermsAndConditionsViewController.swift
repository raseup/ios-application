//
//  TermsAndConditionsViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/24/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {
    
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var raseIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var background: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background to the image
        self.view.backgroundColor = UIColor.clear
        
        // Sets the blur background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        self.view.insertSubview(blurEffectView, at: 0)

        // Sets the terms and conditions
        termsAndConditionsLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam venenatis risus ut velit rutrum eleifend. Proin dictum lorem mi, ac vestibulum diam accumsan eu. Proin pretium hendrerit malesuada. Nam lacus leo, dignissim vitae ullamcorper nec, molestie vitae lorem. Mauris id pulvinar felis, eu pretium turpis. In hac habitasse platea dictumst. Cras ultricies mauris posuere metus eleifend, nec fermentum lacus molestie. \n\nSuspendisse eu tortor sed lectus consequat fringilla in at dui. Fusce volutpat justo eu mollis egestas. Nunc non fermentum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus pretium turpis nec turpis bibendum, nec dapibus lectus semper. Fusce viverra augue vel libero consequat, id vulputate lorem convallis. Vivamus risus justo, imperdiet a efficitur eget, porta ac leo. Vestibulum dictum rhoncus metus, et pellentesque mauris blandit vitae. Morbi tristique laoreet diam eget semper. Nulla egestas orci arcu, nec venenatis nisi consequat a. \n\nIn nec nisi arcu. Ut sagittis erat ut sem tempus consectetur. Integer tempor, orci sit amet blandit convallis, leo turpis ultricies ipsum, non luctus augue nunc nec eros. Proin elementum magna in facilisis mollis. Mauris commodo purus sed libero auctor rhoncus. Nulla fermentum arcu lectus, eu tincidunt metus tincidunt ac. Nullam malesuada est a tristique faucibus. Mauris congue lectus justo, nec cursus quam iaculis sed. Cras vestibulum, metus ut malesuada tristique, nisl diam gravida diam, et pharetra leo urna sit amet nisl. In vitae tellus a odio rutrum mollis.Aenean aliquam suscipit orci, eu dignissim dui dignissim nec. Proin quis tellus vel diam volutpat interdum. Nunc euismod ipsum mi, sed consectetur velit pulvinar id. \n\nSuspendisse non ullamcorper est, a malesuada felis. Nullam tempor pharetra massa sed auctor. Proin est urna, rutrum ac leo ut, porta mattis nisl. Duis et quam vel sapien vehicula pretium. Aliquam erat volutpat. Mauris eget felis id odio tincidunt imperdiet. Etiam dapibus lorem non quam condimentum imperdiet. Ut in turpis ultricies, varius ipsum non, dictum orci. Nulla facilisi. Suspendisse id tristique augue, sit amet fermentum risus. Aenean rhoncus, erat ut fermentum laoreet, magna odio congue neque, sit amet auctor augue neque sit amet augue.Aenean dictum arcu eu lorem interdum pharetra. \n\nPellentesque eget ultricies leo, quis ullamcorper orci. Morbi tempor non sem id dictum. Vestibulum eget turpis vel leo convallis varius. Vivamus a quam ut orci varius commodo id ut velit. Phasellus at erat eu arcu convallis iaculis id et purus. Duis commodo turpis vitae purus fringilla condimentum."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Sets the background image - done here for proper screen size
        let backgroundImageView = UIImageView(image: background)
        backgroundImageView.frame = UIScreen.main.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Dismisses the page
    @IBAction func dismissPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

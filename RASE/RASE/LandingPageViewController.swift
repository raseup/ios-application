//
//  ViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 3/24/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import UIKit

class LandingPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    var newIndex: Int = 0
    var orderedViewControllers: [UIViewController] = []
    var pageControl: UIPageControl!
    
    // For scroll transition style
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare the page based view controllers
        dataSource = self
        delegate = self
        
        for image in landingBackgroundImages {
            let vc = LandingPageImageViewController(nibName: "LandingPageImageViewController", bundle: nil)
            vc.background = image
            orderedViewControllers.append(vc)
        }
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Handle the landing page view controllers
extension LandingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
        
        let viewControllerIndex = orderedViewControllers.index(of: self.viewControllers![0])
        pageControl.currentPage = viewControllerIndex!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        var previousIndex = viewControllerIndex-1
        if previousIndex < 0 {
            previousIndex = orderedViewControllers.count - 1
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        var nextIndex = viewControllerIndex+1
        let orderedViewControllersCount = orderedViewControllers.count
        
        if orderedViewControllersCount == nextIndex {
            nextIndex = 0
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}


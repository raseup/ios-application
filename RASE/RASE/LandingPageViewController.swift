//
//  LandingPageViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/29/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

var orderedViewControllers: [UIViewController] = {
    return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Green"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Red"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Blue")]
}()

class LandingPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    var newIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LandingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
        
        let viewControllerIndex = orderedViewControllers.index(of: self.viewControllers![0])
        pageControlGlobal!.currentPage = viewControllerIndex!
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

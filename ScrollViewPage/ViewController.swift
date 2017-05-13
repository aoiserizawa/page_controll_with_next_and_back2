//
//  ViewController.swift
//  ScrollViewPage
//
//  Created by Brian Advent on 02/12/2016.
//  Copyright © 2016 Brian Advent. All rights reserved.
//

import UIKit

class Page {
    var model: UIView
    var nibName: String
    init(model: UIView, nibName: String) {
        self.model = model
        self.nibName = nibName
    }
}

class Pages{
    
    var model: NSObject
    var items: [Page]
    var height: CGFloat
    var identifier: String
    
    init(model: NSObject, items: [Page], height: CGFloat, identifier: String) {
        self.model = model
        self.items = items
        self.height = height
        self.identifier = identifier
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var featureScrollView: UIScrollView!
    
    
    var pages: [Page] = [Page]()
    
    let feature1 = ["title": "watch", "price": "$0.99", "image": "1"]
    
    let feature2 = ["title": "more ampe", "price": "$0.99", "image": "2"]
    
    let feature3 = ["title": "aontehe", "price": "$0.99", "image": "3"]
    
    var featureArray = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        featureArray = [feature1, feature2, feature3]
        
        
        self.pages.append(Page(model: FeatureView(), nibName: "Feature"))
        self.pages.append(Page(model: FeatureView(), nibName: "Feature"))
        
        
        featureScrollView.isPagingEnabled = true
        featureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(self.pages.count), height: 250)
        
        featureScrollView.showsHorizontalScrollIndicator = false
        
        loadFeatures()
        
    }
    
    func loadFeatures() {
        
        for (index, feature) in self.pages.enumerated(){
            
            print(index)
            if let featureView = Bundle.main.loadNibNamed(feature.nibName, owner: self, options: nil)?[index] as? Form {
                
                featureView.nextButton.tag = index
                
//                if index == 0 {
//                    featureView.backButton.isHidden = true
//                }
                
//                featureView.backButton.tag = index
                
                featureView.nextButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                
//                featureView.backButton.addTarget(self, action: #selector(ViewController.backAction(sender:)), for: .touchUpInside)
                
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                featureScrollView.addSubview(featureView)
                
            }else if let featureView = Bundle.main.loadNibNamed(feature.nibName, owner: self, options: nil)?[index] as? FeatureView {
                
                featureView.purchaseButton.tag = index
                
//                if index == 0 {
//                    featureView.backButton.isHidden = true
//                }
                
                featureView.backButton.tag = index
                featureView.purchaseButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                featureView.backButton.addTarget(self, action: #selector(ViewController.backAction(sender:)), for: .touchUpInside)
                
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                featureScrollView.addSubview(featureView)
            }
            
        }
        
    }
    
    func buyFeature (sender:UIButton) {
        
        
        print(sender.tag)
        
        var frame = featureScrollView.frame
        
        let pageNumber = CGFloat(sender.tag + 1)
        
        print(pageNumber)
        frame.origin.x = featureScrollView.frame.size.width * pageNumber;
        
        print(frame.origin.x)
        frame.origin.y = 0;
        featureScrollView.scrollRectToVisible(frame, animated: true)
        
        if sender.tag == 0 {
            var formView = featureScrollView.subviews[0] as! Form
            
            print(formView.form1Textfield.text)
            print(formView.form2TextField.text)
        }
        
    }
    
    func backAction (sender:UIButton) {
        
        
        var frame = featureScrollView.frame
        
        let pageNumber = CGFloat(sender.tag - 1)
        
        print(pageNumber)
        frame.origin.x = featureScrollView.frame.size.width * pageNumber;
        
        print(frame.origin.x)
        frame.origin.y = 0;
        featureScrollView.scrollRectToVisible(frame, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


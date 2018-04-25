//
//  ViewController.swift
//  LayoutGuide
//
//  Created by SERGIO J RAFAEL ORDINE on 25/04/2018.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 30))
        myView.backgroundColor = UIColor.blue
        view.addSubview(myView)
        
        let left = UILayoutGuide()
        view.addLayoutGuide(left)
        
        let leadingAnchor = left.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let widthAnchor = left.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        let topAnchor = left.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let heightAnchor = left.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        
        leadingAnchor.isActive = true
        widthAnchor.isActive = true
        topAnchor.isActive = true
        heightAnchor.isActive = true
        
        
        let fakeView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        fakeView.backgroundColor = UIColor.red
        view.addSubview(fakeView)
        fakeView.translatesAutoresizingMaskIntoConstraints = false
        
        let c1 = fakeView.topAnchor.constraint(equalTo: left.topAnchor)
        let c2 = fakeView.leadingAnchor.constraint(equalTo: left.leadingAnchor)
        let c3 = fakeView.trailingAnchor.constraint(equalTo: left.trailingAnchor)
        let c4 = fakeView.bottomAnchor.constraint(equalTo: left.bottomAnchor)
        
        c1.isActive = true
        c2.isActive = true
        c3.isActive = true
        c4.isActive = true
        
        
       
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = myView.topAnchor.constraint(equalTo: left.bottomAnchor)
        let leading = myView.leadingAnchor.constraint(equalTo: left.trailingAnchor)
        let width = myView.widthAnchor.constraint(equalTo: left.widthAnchor)
        let height = myView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        
        top.isActive = true
        leading.isActive = true
        width.isActive = true
        height.isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


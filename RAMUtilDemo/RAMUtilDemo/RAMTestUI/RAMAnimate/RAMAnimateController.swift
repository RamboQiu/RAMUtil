//
//  RAMAnimateController.swift
//  RAMUtilDemo
//
//  Created by rambo on 2020/3/11.
//  Copyright © 2020 裘俊云. All rights reserved.
//

import UIKit

var subview = UIView()

class RAMAnimateController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "animate";
        self.view.backgroundColor = UIColor.white;
        
        subview.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.addSubview(subview)
        subview.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.setTitle("点击", for: .normal)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        
    }
    
    @objc func clickAction(_ event: UIButton) {
        
        var frame = subview.frame
        if frame.size.height == 300 {
            frame.size.height = 100
        } else {
            frame.size.height = 300
        }
        UIView.animate(withDuration: 0.3) {
            subview.frame = frame
        }
    }
    

}

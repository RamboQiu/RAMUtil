//
//  RAMSwiftViewController.swift
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/21.
//  Copyright © 2020 裘俊云. All rights reserved.
//

import UIKit
//import RAMSwiftObject

class RAMSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "test";
        self.view.backgroundColor = UIColor.white;

        // Do any additional setup after loading the view.
        
        var object = RAMSwiftObject();
        object.test();
//        print(object.greet());
        
//        var object = RAMSwiftObject();
//        object.test();
        
//        var subview1 = RAMSwiftView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
////        subview1.frame
//        self.view.addSubview(view: subview1);
//        subview1.fra
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

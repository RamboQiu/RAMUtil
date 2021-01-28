//
//  RAMSwiftViewController.swift
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/21.
//  Copyright © 2020 裘俊云. All rights reserved.
//

import UIKit
import Apollo

class RAMSwiftViewController: UIViewController {
    
    var launches = [LaunchListQuery.Data.Launchess.Launch]()
    private var lastConnection: LaunchListQuery.Data.Launchess?
    private var activeRequest: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "test";
        self.view.backgroundColor = UIColor.white;
        
        self.loadMoreLaunches();

    }
    
    private func loadMoreLaunches() {
        self.activeRequest = Network.shared.apollo.fetch(query: LaunchListQuery()) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.activeRequest = nil
            
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launchess {
                    self.lastConnection = launchConnection
                    self.launches.append(contentsOf: launchConnection.launches.compactMap { $0 })
                }
                for launch in self.launches {
                    print("launch mission name: \(launch.mission?.name ?? "")")
                    print("launch site: \(launch.site ?? "")")
                }
                
                if let errors = graphQLResult.errors {
                    self.showAlertForErrors(errors)
                }
            case .failure(let error):
                self.showAlert(title: "Network Error",
                               message: error.localizedDescription)
            }
        }
    }

}

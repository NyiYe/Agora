//
//  MyViewController.swift
//  Agora
//
//  Created by Nyi Ye Han on 04/03/2023.
//

import Foundation
import UIKit
import SwiftUI

class MyViewController : UIViewController{
    private var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Hello UI Kit"
        label.textAlignment = .center
        
        return label
    }()
    override func viewDidLoad() {
        // 2
        view.backgroundColor = .systemPink
        
        // 3
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
}

struct MyView :UIViewControllerRepresentable{
        
    func makeUIViewController(context: Context) -> MyViewController {
        let vc = MyViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = MyViewController
}

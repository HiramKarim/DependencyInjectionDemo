//
//  ViewController.swift
//  DependencyInjection
//
//  Created by Hiram Castro on 23/01/22.
//

import UIKit
import UIElements
import APIServices

class ViewController: UIViewController {
    
    let showTableButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(showTableButton)
        showTableButton.addTarget(self, action: #selector(showCoursesList), for: .touchUpInside)
        NSLayoutConstraint.activate([
            showTableButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            showTableButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            showTableButton.widthAnchor.constraint(equalToConstant: 100),
            showTableButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func showCoursesList() {
        let vc = ListVC(dataFetcher: ApiServiceManager.shared)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}

extension ApiServiceManager: DataFetcher {}


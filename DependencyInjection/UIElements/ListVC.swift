//
//  ListVC.swift
//  UIElements
//
//  Created by Hiram Castro on 23/01/22.
//

import UIKit

public protocol DataFetcher {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

struct Course {
    let name:String
}

public class ListVC: UIViewController {
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let dataFetcher:DataFetcher
    var courses:[Course] = []
    
    public init(dataFetcher:DataFetcher) {
        self.dataFetcher = dataFetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableview)
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        dataFetcher.fetchCourseNames { [weak self] data in
            guard let self = self else { return }
            self.courses = data.map { Course(name: $0) }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = self.view.bounds
    }
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        else { return UITableViewCell() }
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }
    
}

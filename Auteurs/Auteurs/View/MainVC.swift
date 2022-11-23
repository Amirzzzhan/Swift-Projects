//
//  ViewController.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 20.11.2022.
//

import UIKit

final class MainVC: UIViewController, AuteursPresenterDelegate {
    
    // MARK: - UI
    private var tableView: UITableView?
    
    // MARK: - Private Attributes
    private var authors = [Auteurs]()
    
    private let presenter = AuteursPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        
        presenter.setDelegate(delegate: self)
        presenter.getAuteurs()
    }
    
    // MARK: - UI Setup
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Auteurs"
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .grouped)
        
        guard let safeTableView = tableView else { return }
        
        view.addSubview(safeTableView)
        
        safeTableView.separatorInset.left = 0
        
        safeTableView.register(AuteursTableViewCell.self, forCellReuseIdentifier: AuteursTableViewCell.className)
        
        safeTableView.rowHeight = UITableView.automaticDimension
        safeTableView.estimatedRowHeight = 600
        
        safeTableView.dataSource = self
        safeTableView.delegate = self
    }
    
    // MARK: - AuteursPresenterDelegate
    func presentAuteurs(auteurs: [Auteurs]) {
        authors = auteurs
        
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AuteursTableViewCell.className, for: indexPath) as! AuteursTableViewCell
        
        let author = authors[indexPath.row]
        
        cell.auteursPhoto.image = UIImage(named: author.image)
        cell.auteursPhoto.layer.cornerRadius = cell.auteursPhoto.frame.size.width / 2
        
        cell.nameText.text = author.name
        cell.bioText.text = author.bio
        cell.sourceText.text = author.source
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let films = authors[indexPath.row].films
        let authorsName = authors[indexPath.row].name
        navigationController?.pushViewController(FilmsPageVC(films: films, authorsName: authorsName), animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


//
//  FilmsPageVC.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 23.11.2022.
//

import UIKit

final class FilmsPageVC: UIViewController {
    
    // MARK: - UI
    private var tableView: UITableView?
    
    // MARK: - Private Attributes
    private let authorsName: String
    private var films: [Films]
    
    // MARK: - LifeCycle
    init(films: [Films], authorsName: String) {
        self.films = films
        self.authorsName = authorsName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = authorsName
        navigationController?.navigationBar.tintColor = .red
        
        setupTableView()
    }
    
    // MARK: - Table View Setup
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .grouped)
        
        guard let safeTableView = tableView else { return }
        
        view.addSubview(safeTableView)
        
        safeTableView.separatorInset.left = 0
        
        safeTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.className)
        
        safeTableView.rowHeight = UITableView.automaticDimension
        safeTableView.estimatedRowHeight = 300
        
        safeTableView.dataSource = self
        safeTableView.delegate = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FilmsPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.className, for: indexPath) as! FilmTableViewCell
        
        let film = films[indexPath.row]
        
        cell.filmsPhoto.image = UIImage(named: film.poster)
        
        cell.filmsName.text = film.title
        
        cell.moreInfoText.text = film.isExpanded ? film.plot : "Tap For Details >"
        cell.moreInfoText.textAlignment = film.isExpanded ? .left : .center
        cell.moreInfoText.textColor = film.isExpanded ? UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0) : .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilmTableViewCell else {
            return
        }
        
        var film = films[indexPath.row]
        
        film.isExpanded = !film.isExpanded
        films[indexPath.row] = film
        
        cell.moreInfoText.text = film.isExpanded ? film.plot : "Tap For Details >"
        cell.moreInfoText.textAlignment = film.isExpanded ? .left : .center
        cell.moreInfoText.textColor = film.isExpanded ? UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0) : .red
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

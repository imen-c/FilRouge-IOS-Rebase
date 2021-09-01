//
//  SmileViewController.swift
//  filRouge
//
//  Created by Joris Thiery on 09/06/2021.
//

import UIKit

class SmileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var jokes = [Joke]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        retrieveDatas()
    }

    private func retrieveDatas() {

        JokeService.shared.jokes { jokes in
            if let jokes = jokes {
                self.jokes = jokes
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            } else {
                // TODO: Manage Error
            }
        }
    }

    private func setupView() {
        title = "Rigoler"

        activityIndicator.startAnimating()

        view.backgroundColor = .blueGrey
        tableView.backgroundColor = .blueGrey

        setupTableView()
    }

    private func setupTableView() {

        tableView.tableFooterView = UIView() // Remove empty extra cell
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // Add padding at top

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "JokeTableViewCell", bundle: nil), forCellReuseIdentifier: "JokeTableViewCell")
    }

}

extension SmileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let jokeCell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as! JokeTableViewCell
        jokeCell.delegate = self
        jokeCell.setupCell(joke: jokes[indexPath.row], index: indexPath.row)
        return jokeCell
    }

}

extension SmileViewController: JokeTableViewCellDelegate {

    func didTapOnShare(index: Int) {

        let activityViewController = UIActivityViewController(activityItems: [jokes[index]] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)    }
}

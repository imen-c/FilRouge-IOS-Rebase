//
//  JokeTableViewCell.swift
//  filRouge
//
//  Created by Joris Thiery on 28/07/2021.
//

import UIKit

protocol JokeTableViewCellDelegate: AnyObject {
    func didTapOnShare(index: Int)
}

class JokeTableViewCell: UITableViewCell {

    @IBOutlet var jokeLabel: UILabel!
    @IBOutlet var cellContainerView: UIView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet weak var cellContainerTopAnchorConstraint: NSLayoutConstraint!

    var index: Int = 0

    weak var delegate: JokeTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .blueGrey

        cellContainerView.backgroundColor = .white
        cellContainerView.layer.cornerRadius = 12
        cellContainerView.layer.masksToBounds = true

        shareButton.setImage(UIImage(named: "icoSharePink"), for: .normal)

        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.boldSystemFont(ofSize: 28)
        jokeLabel.textColor = .middleBlue

        cellContainerTopAnchorConstraint.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(joke: Joke, index: Int) {

        self.index = index

        jokeLabel.text = joke.joke

        // Show the guy only for the first cell
        if index == 0 {
            self.showGuy()
        } else {
            self.hideGuy()
        }
    }

    private func showGuy() {
        cellContainerTopAnchorConstraint.constant = 60
        layoutIfNeeded()
    }

    private func hideGuy() {
        cellContainerTopAnchorConstraint.constant = 0
        layoutIfNeeded()
    }

    @IBAction func didTapOnShare() {
        delegate?.didTapOnShare(index: index)
    }
}

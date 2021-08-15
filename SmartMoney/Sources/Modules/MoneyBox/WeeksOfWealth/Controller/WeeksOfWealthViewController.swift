//
//  WeeksOfWealthViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

private let cellIdentifier = "cell"

class WeeksOfWealthViewController: UIViewController {
    
    private var depositAmountArray: [Deposit] = {
        var array = [Deposit]()
        for i in stride(from: 100, through: 5700, by: 100) {
            array.append(Deposit(amount: i))
        }
        return array
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "52 WEEKS OF WEALTH"

        setupCollectionView()
        layout()
    }
    private func layout() {
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeArea()
    }

    private func setupCollectionView() {
        collectionView.register(WeeksOfWealthCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension WeeksOfWealthViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return depositAmountArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WeeksOfWealthCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.amountLabel.text = String(depositAmountArray[indexPath.row].amount)

        return cell
    }
}

extension WeeksOfWealthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 68)
    }
}

extension WeeksOfWealthViewController: WeeksOfWealthCollectionViewCellDelegate {
    func weeksOfWealthCollectionViewCellTapped(_ cell: WeeksOfWealthCollectionViewCell) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.amountLabel.text!)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

        cell.amountLabel.attributedText = attributeString
        cell.artworkView.backgroundColor = .green
    }
}

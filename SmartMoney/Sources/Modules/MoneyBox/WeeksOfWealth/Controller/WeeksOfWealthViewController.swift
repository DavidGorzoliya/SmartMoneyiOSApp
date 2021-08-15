//
//  WeeksOfWealthViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

private let cellIdentifier = "cell"

class WeeksOfWealthViewController: UIViewController {
    
    private lazy var infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(textFildBarButtomItem))
    private var depositAmountArray = BackendManager.shared.getAllDeposits()
    
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
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.register(WeeksOfWealthCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @objc private func textFildBarButtomItem() {
        let vc = UIViewController()
        let navVc = UINavigationController(rootViewController: vc)

        vc.navigationController?.navigationBar.prefersLargeTitles = true
        vc.title = "Правила игры"

        let gameDescriptionLabel = UILabel()
        gameDescriptionLabel.numberOfLines = 0
        gameDescriptionLabel.font = UIFont.boldSystemFont(ofSize: gameDescriptionLabel.font.pointSize)
        gameDescriptionLabel.text = "- 1 раз в неделю выбирай любую ячейку и пополняй копилку номиналом ячейки! \n\n- Игра пройдена, когда все ячейки закрашены!"

        vc.view.addSubview(gameDescriptionLabel)
        gameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        gameDescriptionLabel.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        gameDescriptionLabel.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 12).isActive = true
        gameDescriptionLabel.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -12).isActive = true

        navVc.modalPresentationStyle = .pageSheet
        vc.view.backgroundColor = .white

        present(navVc, animated: true)
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
        let deposit = depositAmountArray[indexPath.row]
        if deposit.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(deposit.amount))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

            cell.amountLabel.attributedText = attributeString
            cell.artworkView.backgroundColor = .green
        } else {
            cell.amountLabel.attributedText = nil
            cell.amountLabel.text = String(deposit.amount)
            cell.artworkView.backgroundColor = .white
        }
        cell.delegate = self

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
        let deposit = BackendManager.shared.modifyDeposit(with: Int(cell.amountLabel.text!)!)

        if deposit.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.amountLabel.text!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

            cell.amountLabel.attributedText = attributeString
            cell.artworkView.backgroundColor = .green
        } else {
            cell.amountLabel.attributedText = nil
            cell.amountLabel.text = String(deposit.amount)
            cell.artworkView.backgroundColor = .white
        }
    }
}

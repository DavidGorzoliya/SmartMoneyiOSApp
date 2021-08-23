//
//  WeeksOfWealthViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

private let cellIdentifier = "cell"

class AdultPiggyBankViewController: UIViewController {
    
    private var depositAmountArray = BackendManager.shared.adultPiggyBankCoins
    
    private lazy var infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(textFildBarButtomItem))

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
        collectionView.register(AdultPiggyBankCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
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

extension AdultPiggyBankViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return depositAmountArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AdultPiggyBankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let deposit = depositAmountArray[indexPath.row]
        if deposit.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(deposit.amount))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

            cell.coinAmountLabel.attributedText = attributeString
            cell.coinView.backgroundColor = .green
        } else {
            cell.coinAmountLabel.attributedText = nil
            cell.coinAmountLabel.text = String(deposit.amount)
            cell.coinView.backgroundColor = .white
        }
        cell.delegate = self

        return cell
    }
}

extension AdultPiggyBankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 68)
    }
}

// MARK: - WeeksOfWealthCollectionViewCellDelegate
extension AdultPiggyBankViewController: AdultPiggyBankCollectionViewCellDelegate {
    func adultPiggyBankCollectionViewCellTapped(_ cell: AdultPiggyBankCollectionViewCell) {

        guard let text = cell.coinAmountLabel.text,
              let amount = Int(text),
              let deposit = BackendManager.shared.modifyAdultPiggyBankCoinCompletion(coinWithAmount: amount) else {
            return
        }

        if deposit.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.coinAmountLabel.text!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

            cell.coinAmountLabel.attributedText = attributeString
            cell.coinView.backgroundColor = .green
            BackendManager.shared.addToBalanceFromAdultPiggyBank(amount: amount)
        } else {
            cell.coinAmountLabel.attributedText = nil
            cell.coinAmountLabel.text = String(deposit.amount)
            cell.coinView.backgroundColor = .white
            BackendManager.shared.addToBalanceFromAdultPiggyBank(amount: -amount)
        }
    }
}

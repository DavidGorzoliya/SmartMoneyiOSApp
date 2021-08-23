//
//  ChildrensPiggyBankViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/18/21.
//

// iPhone 12pro 2499249
// lamborghini 94204002402
// Santexnik ustranit zasor 9500

import UIKit

private let cellIdentifier = "cell"

class KidPiggyBankViewController: UIViewController {
    
    private lazy var infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(textFildBarButtomItem))
    
    private var depositAmountArray = BackendManager.shared.kidPiggyBankCoins
    
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
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        title = "1 - 100 PIGGY BANK"
        layout()
        setupCollectionView()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeArea()
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }
    private func setupCollectionView() {
        collectionView.register(ChildrensPiggyBankCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
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
        gameDescriptionLabel.text = "- 1 раз в день выбирай любую ячейку и пополняй копилку номиналом ячейки! \n\n- Игра пройдена, когда все ячейки закрашены!"

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

extension KidPiggyBankViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return depositAmountArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ChildrensPiggyBankCollectionViewCell else {
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

extension KidPiggyBankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 68)
    }
}

extension KidPiggyBankViewController: ChildrensPiggyBankCollectionViewCellDelegate {
    func childrensPiggyBankCollectionViewCellTapped(_ cell: ChildrensPiggyBankCollectionViewCell) {
        guard let text = cell.amountLabel.text,
              let amount = Int(text),
              let deposit = BackendManager.shared.modifyChildrensPiggyBankCoinCompletion(coinWithAmount: amount) else {
            return
        }

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

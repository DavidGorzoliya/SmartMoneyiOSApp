//
//  WeeksOfWealthViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit
import AVFoundation

private let cellIdentifier = "cell"

class AdultPiggyBankViewController: UIViewController {
    
    private var depositAmountArray = BackendManager.shared.adultPiggyBankCoins
    var bombSoundEffect: AVAudioPlayer?
    
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
        cell.coinView.backgroundColor = deposit.completed ? .SMGreen : .white
        cell.coinAmountLabel.text = "\(deposit.amount)"
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
            let coinImageView = UIImageView(frame: CGRect(x: 68 / 2 - 11, y: 0, width: 22, height: 22))
            coinImageView.image = UIImage(systemName: "dollarsign.circle.fill")
            coinImageView.tintColor = UIColor(red: 0.99, green: 0.80, blue: 0.28, alpha: 1.00)
            
            let coinImageView1 = UIImageView()
            coinImageView1.image = UIImage(systemName: "dollarsign.circle.fill")
            coinImageView1.tintColor = UIColor(red: 0.93, green: 0.80, blue: 0.28, alpha: 1.00)
            
            coinImageView1.frame = CGRect(x: coinImageView.frame.origin.x - 12, y: coinImageView.frame.origin.y, width: 22, height: 22)
            
            cell.contentView.addSubview(coinImageView)
            cell.contentView.addSubview(coinImageView1)
            
            UIView.animate(withDuration: 1.5, animations: {
                coinImageView.frame = CGRect(x: coinImageView.frame.origin.x, y: coinImageView.frame.origin.y + 50, width: 22, height: 22)
                coinImageView1.frame = CGRect(x: coinImageView1.frame.origin.x, y: coinImageView.frame.origin.y + 50, width: 22, height: 22)
            }) { _ in
                coinImageView.removeFromSuperview()
                coinImageView1.removeFromSuperview()
            }
            
            cell.coinView.backgroundColor = .SMGreen
            let path = Bundle.main.path(forResource: "money_v2_mi.mp3", ofType: nil)!
            let url = URL(fileURLWithPath: path)

            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
            } catch {
                print(error)
            }
            BackendManager.shared.addToBalanceFromAdultPiggyBank(amount: amount)
        } else {
            cell.coinView.backgroundColor = .white
            BackendManager.shared.addToBalanceFromAdultPiggyBank(amount: -amount)
        }
        cell.coinAmountLabel.text = String(deposit.amount)
    }
}

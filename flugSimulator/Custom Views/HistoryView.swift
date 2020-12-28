//
//  HistoryView.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class HistoryView: UIView {
    var collectionView: UICollectionView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        // 2 items per row
        let itemsMarginToBorders = 20.0
        let spaceBetweenItems = 10.0
        let spaceBetweenRows = 20.0
        let size = (Double((bounds.width)) / 2) - (itemsMarginToBorders * 2) - spaceBetweenItems
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = CGFloat(spaceBetweenItems)
        layout.minimumLineSpacing = CGFloat(spaceBetweenRows)
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(itemsMarginToBorders), bottom: 0, right: CGFloat(itemsMarginToBorders))
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.reuseId)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
    }
}

extension HistoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.reuseId, for: indexPath)
        return cell
    }
    
    
}

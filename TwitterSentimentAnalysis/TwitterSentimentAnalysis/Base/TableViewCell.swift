//
//  TableViewCell.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 10/11/21.
//

import UIKit

class TableViewCell: UITableViewCell, Reusable {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

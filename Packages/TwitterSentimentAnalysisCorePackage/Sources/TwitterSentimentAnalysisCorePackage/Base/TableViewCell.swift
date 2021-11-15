//
//  TableViewCell.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 10/11/21.
//

import UIKit

open class TableViewCell: UITableViewCell, Reusable {

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        nil
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

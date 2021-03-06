//
//  DokuryoTableViewCell.swift
//  TsundokuBreak
//
//  Created by Mizuki Kubota on 2020/04/12.
//  Copyright © 2020 MizukiKubota. All rights reserved.
//

import UIKit
import AlamofireImage
import FaveButton
import CDAlertView

class DokuryoTableViewCell: UITableViewCell {
    weak var delegate: CellDeleteDelegate?
    var indexPathRowTag: Int?

    @IBOutlet weak var bookImage: UIImageView! {
        didSet {
            bookImage.image = UIImage.gif(name: R.string.dokuryoTableViewCell.loading())
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var trashBox: FaveButton!
    @IBAction func touchUpTrashBox(_ sender: Any) {

        trashBox.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            //print("2.0秒後に実行")
            self.doAlert()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(cellData: CellData) {
        titleLabel.text = cellData.title
        authorLabel.text = cellData.author
        setImageUrl(cellData.thumbnailUrl)
        setTrashBoxButton()

    }

    private func setTrashBoxButton() {
        trashBox.isEnabled = true
        trashBox.setSelected(selected: false, animated: false)
    }

    private func setImageUrl(_ urlString: String) {
        let url = URL(string: urlString)!
        let filter = AspectScaledToFillSizeFilter(size: self.bookImage.frame.size)
        let placeFolder = UIImage.gif(name: R.string.dokuryoTableViewCell.loading())
        bookImage.af.setImage(
            withURL: url,
            placeholderImage: placeFolder,
            filter: filter,
            imageTransition: .crossDissolve(0.5)
        )
    }

    private func doAlert() {
        let alert = CDAlertView(
            title: R.string.dokuryoTableViewCell.alertTitle(),
            message: R.string.dokuryoTableViewCell.alertDescription(),
            type: .warning
        )
        let cancelAction = CDAlertViewAction(
            title: R.string.dokuryoTableViewCell.cancel(),
            handler: { _ in self.resetCell()}
        )
        let doneAction = CDAlertViewAction(
            title: R.string.dokuryoTableViewCell.ok(),
            handler: { _ in self.deleteCell()}
        )
        alert.add(action: cancelAction)
        alert.add(action: doneAction)

        alert.show()

    }

    private func deleteCell() -> Bool {
        self.delegate?.deleteCell(indexPathRow: self.indexPathRowTag!)
        return true
    }

    private func resetCell() -> Bool {
        self.setTrashBoxButton()
        return true
    }

}

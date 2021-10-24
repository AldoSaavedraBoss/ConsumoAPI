//
//  NoticiasCell.swift
//  ConsumoAPI
//
//  Created by Mac10 on 23/10/21.
//

import UIKit

class NoticiasCell: UITableViewCell {

    @IBOutlet weak var LBDescripcion: UILabel!
    @IBOutlet weak var LBTitulo: UILabel!
    @IBOutlet weak var IVNoticia: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

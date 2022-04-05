//
//  NoticiaTableViewCell.swift
//  Noticia
//
//  Created by Mac8 on 04/04/22.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloNoticiaLabel: UILabel!
    
    @IBOutlet weak var descripcionNoticiaLabel: UILabel!
    
    @IBOutlet weak var fuenteNoticiaView: UILabel!
    
    @IBOutlet weak var imagenNoticiaLabel: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

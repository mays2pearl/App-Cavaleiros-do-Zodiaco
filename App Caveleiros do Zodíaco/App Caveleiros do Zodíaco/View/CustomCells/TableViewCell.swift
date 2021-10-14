//
//  TableViewCell.swift
//  App Caveleiros do Zodíaco
//
//  Created by Maysa on 13/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imagemCavaleiro: UIImageView!
    
    @IBOutlet weak var nomeCavaleiro: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func  setup(value: Cavaleiros) {
        
      
        self.imagemCavaleiro.image = UIImage(named: value.imagem)
        self.nomeCavaleiro.text = String?(value.nome)
    
    }
}

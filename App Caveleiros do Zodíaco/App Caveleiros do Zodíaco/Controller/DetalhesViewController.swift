//
//  DetalhesViewController.swift
//  App Caveleiros do Zodíaco
//
//  Created by Maysa on 13/10/21.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var imagemCavaleiro: UIImageView!
    
    @IBOutlet weak var descricaoCavaleiro: UITextView!
    
    var cavaleiroSelecionado: Cavaleiros?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        borderImagem()
        self.imagemCavaleiro.image = UIImage(named: self.cavaleiroSelecionado?.imagem ?? "")
        self.descricaoCavaleiro.text = self.cavaleiroSelecionado?.descricao
    }
    
    func borderImagem(){
        
        self.descricaoCavaleiro.layer.borderWidth = 3
        self.descricaoCavaleiro.layer.borderWidth = 3
        self.imagemCavaleiro.layer.cornerRadius = 0.2 * self.imagemCavaleiro.bounds.size.width
        
        self.imagemCavaleiro.clipsToBounds = true
        self.imagemCavaleiro.layer.borderWidth = 10
    }

}

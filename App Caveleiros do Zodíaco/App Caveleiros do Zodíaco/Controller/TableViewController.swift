//
//  ViewController.swift
//  App Caveleiros do Zodíaco
//
//  Created by Maysa on 13/10/21.
//

import UIKit

class TableViewController: UIViewController {
 
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!
        
        var data: Cavaleiros?
        var arrayCavaleiros:[Cavaleiros] = []
        var filterCavaleiros:[Cavaleiros] = []
        var isFilterCavaleiros: Bool = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadData()
            setupSearchBar()
            setupTableView()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc: DetalhesViewController? = segue.destination as? DetalhesViewController
            vc?.cavaleiroSelecionado = sender as? Cavaleiros
        }
        
        private func setupTableView() {
            self.myTableView.dataSource = self
            self.myTableView.delegate = self
            self.myTableView.register(UINib(nibName:"TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        }
        
        private func setupSearchBar() {
            self.searchView.delegate = self
        }
        
        private func loadData() {
            self.arrayCavaleiros = gerarCavaleiros()
        }
        
        private func didSelectCavaleiros(value: Cavaleiros) {
            print("ViewController============didSelectCavaleiros\n \(value)")
        }
        
        private func getCavaleiro(index: Int) -> Cavaleiros {
            if isFilterCavaleiros {
                return filterCavaleiros[index]
            } else {
                return arrayCavaleiros[index]
            }
        }
        
    }

    extension TableViewController: UITableViewDelegate, UITableViewDataSource {
        
        // =>> Nao precisa colocar essa func pois só terá uma unica Section.
        // =>> O default de Section é 1
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            // =>> Esse IF poderia ser melhorado, utilizando :
            // isFilterCavaleiros ? filterCavaleiros.count : arrayCavaleiros.count
            if isFilterCavaleiros {
                return filterCavaleiros.count
            } else {
                return arrayCavaleiros.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cavaleiro: Cavaleiros = getCavaleiro(index: indexPath.row)
        
            let cell: TableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
            
            cell?.setup(value: cavaleiro)
            
            return cell ?? UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cavaleiroSelecionado: Cavaleiros = self.arrayCavaleiros[indexPath.row]
            performSegue(withIdentifier: "DetalhesViewController", sender: cavaleiroSelecionado)
        }
        
    }

    extension TableViewController: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if searchText.isEmpty {
                isFilterCavaleiros = false
                filterCavaleiros = []
            } else {
                isFilterCavaleiros = true
                filterCavaleiros = arrayCavaleiros.filter {
                    $0.nome.lowercased().contains(searchText.lowercased())
                }
                if filterCavaleiros.isEmpty {
                    isFilterCavaleiros = false
                }
                
            }
            myTableView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            
            guard let text = searchBar.text else { return }
            
            if text.isEmpty {
                isFilterCavaleiros = false
                filterCavaleiros = []
            }
        }
        
    }

    extension TableViewController {
        
        func gerarCavaleiros() -> [Cavaleiros] {
            
            let listCavaleiros = [
                Cavaleiros(nome: "Shion de Áries",
                              descricao: "Um dos personagens de Lost Canvas que havia sido apresentado na Saga de Hades em Cavaleiros do Zodíaco. Shion futuramente viria à ser o mestre de Mu e também o Mestre do Santuário. Mas antes disso ele foi o discípulo de Hakurei, que então era Mestre do Santuário após a morte de seu irmão Sage.Nascido no Tibete, Shion é um mestre em telecinese, teleporte e telepatia, por muito pouco Shion não acabou se tornando um espectro de Hades, ao ser abordado por Lune de Balron.Técnicas: Muralha de Cristal, Revolução Estelar.",
                              imagem: "Shion de aries"),
                
                Cavaleiros(nome: "Hasgard de Touro",
                              descricao: "Hasgard, também conhecido como Aldebaran - assim como os demais Cavaleiros de Touro - é um cavaleiro muito forte e bastante sábio. Possuía três discípulos que demonstravam imensa admiração pelo Cavaleiro.Quando jovem, Hasgard demonstrava por sua parte uma imensa admiração pelo antigo Cavaleiro de Leão, Ilías. Sua filosofia tanto de vida quanto de combate em principal era firmada acima de tudo em proteger os mais fracos, de modo que possam crescer e se tornarem mais fortes.Técnicas: Grande Chifre, Destruição Titânica, Supernova Titânica",
                              imagem: "Hasgard de touro"),
                
                Cavaleiros(nome: "Aspros/Defteros de Gêmeos",
                              descricao: "Assim como em toda encarnação, o Cavaleiro de Gêmeos possui um irmão gêmeo. Em Lost Canvas, o Cavaleiro Aspros nasceu sob a constelação de Gêmeos, enquanto seu irmão Defteros era visto como uma sombra, um peso para o grande futuro Cavaleiro de Gêmeos.Ao descobrir que não foi nomeado para ser o Grande Mestre do Santuário, Aspros revelou sua verdadeira natureza e tentou assassinar Sage. Defteros - que estava sob controle do Satã Imperial de Aspros - conseguiu assassinar seu irmão e impedir que ele matasse o Grande Mestre.Defteros se tornaria então o Cavaleiro de Gêmeos e se recolheria para as Ilha Kanon para se aperfeiçoar. Posteriormente, Aspros e Defteros acabariam por se tornar uma só pessoa na luta contra Hades e foram capazes de deter até um deus.Técnicas: Outra Dimensão, Explosão Galática, Erupção Negra (Só Defteros).",
                              imagem: "Aspros:Defteros de gemeos"),
                
                Cavaleiros(nome: "Manigold de Câncer",
                              descricao: "Manigold de Câncer. Manigold foi o único discípulo do Grande Mestre Sage, o antigo Cavaleiro de Câncer. Sage foi o responsável por mostrar à Manigold que havia valor em proteger a vida.O personagem ficou marcado por sua personalidade debochada, grande o suficiente para que ele zombasse da cara do deus Tânatos em seu próprio reino. Manigold teve grande importância e participação na derrota do grande deus da morte, juntamente com seu mestre.Técnicas: Acubens, Ondas do Inferno, Chamas Demoníacas, Hecatombe dos Espíritos.",
                              imagem: "Manigold de cancer"),
                
                Cavaleiros(nome: "Regulus de Leão",
                              descricao: "Regulus de Leão. Um dos mais notáveis Cavaleiros daquela época, Regulus era o filho de Ilías de Leão, morto por Radamanthys. Regulus era apenas um garoto da idade de Tenma e Yato, mas mesmo assim tinha um poder enorme.Sua maior habilidade eram seus olhos, com eles o Leão podia simplesmente analisar o cosmo do seu inimigo e aprendê-lo, assim ele simplesmente anulava o cosmo de seu oponente podendo assim superá-lo. Além disso, com seus olhos Regulus era capaz de aprender os golpes de outros cavaleiros. Com isso ele foi capaz de executar uma Exclamação de Athena sozinho, além de executar todos os golpes dos 12 Cavaleiros de Ouro de uma vez por conta própria. Técnicas: Basicamente a técnica que quiser...",
                              imagem: "Regulus de leao"),
                
                Cavaleiros(nome: "Asmita de Virgem",
                              descricao: "Enquanto Shakka de Virgem era conhecido por manter seus olhos fechados, Asmita por outro lado, de fato era cego, o que o priva de um sentido, fazendo com que alcance muito mais facilmente o sétimo sentido. Asmita foi o cavaleiro responsável por criar o famoso Rosário que sela e aprisiona os espectros de Hades, impedindo que eles continuem renascendo. Técnicas: Ohm, Kahn, Rendição Divina, Ciclo das Seis Existências, Tesouro do Céu, Invocação dos Espíritos Malignos, Selo Conquistador do Mal",
                              imagem: "Asmita de virgem"),
                
                Cavaleiros(nome: "Dohko de Libra",
                              descricao: "Dohko de Libra, O cavaleiro mais conhecido pelo público dentre os 12 de ouro em Lost Canvas. Dohko de Libra é o famoso grande Mestre Ancião, que treinou Shiryu e auxilia os Cavaleiros de Athena sempre que possível no anime clássico. Mas em lost Canvas, acompanhamos as aventuras do Cavaleiro quando ele ainda era jovem, enfrentando sua primeira Guerra Santa. Dohko foi treinado por um ser antigo e poderoso que literalmente se transformou em um dragão imortal. Além disso, Dohko tem circulando em seu corpo o sangue da Athena da geração anterior à de Sasha. Um dos sobreviventes da Guerra Santa juntamente com Shion, viveu mais de 243 anos por conta do Misopheta Menos que fez seu coração bater 100.000 vezes por ano, o que é o equivalente ao que ele bate em um dia. Técnicas: Cólera do Dragão, Cólera dos Cem Dragões",
                              imagem: "Dohko de libra"),
                
                Cavaleiros(nome: "Kardia de Escorpião",
                              descricao: "Kardia era uma pessoa extremamente intensa. Com uma personalidade bastante explosiva, Kardia também é bem atraído por violência. Segundo ele próprio, sua razão de existir é abater suas presas, como ele chama seus inimigos, sem pensar duas vezes.Kardia tem uma condição cardíaca atípica, que faz necessário que o Cavaleiro necessite do auxílio de Degel de Aquário para abaixar sua febre. Por conta dessa condição, Kardia é capaz de lançar uma segunda Agulha Escarlate, uma flamejante, que incendeia o coração de seu inimigo para sempre. Técnicas: Agulha Escarlate, Agulha Incandescente, Agulha Antares & Antares Incandescente",
                              imagem: "Kardia de escorpiao"),
                
                Cavaleiros(nome: "Sisifos de Sagitário",
                              descricao: "Ele é o irmão menor de Ilías de Leão e o guardião de Sasha, a reencarnação da deusa Atena nessa época, desde que a encontrou em um orfanato na Itália. Sua lealdade à sua deusa é indiscutível, equiparando-se à sua lealdade aos seus companheiros. Por muitas vezes, Sísifos é visto como um líder para os Cavaleiros, assim como diversas vezes é visto como um escudo para seus companheiros, como ele mesmo alega ser.Técnicas: Impulso da Luz de Quíron, Tempestade de Quíron",
                              imagem: "Sisifos de sagitario"),
                
                Cavaleiros(nome: "El Cid de Capricórnio",
                              descricao: "El Cid é um dos cavaleiros mais perseverantes que existem naquela época, de personalidade muito séria e compenetrante, El Cid age geralmente como um grande assassino silencioso.Perfeccionista, almeja por aperfeiçoar sua espada sagrada em seu braço, podendo finalmente chamá-la de Excalibur. Quando teve seu braço cortado foi finalmente quando conseguiu alcançar o poder máximo de sua espada, comparando com uma espada sem bainha.",
                              imagem: "El Cid de capricornio"),
                
                Cavaleiros(nome: "Dégel de Aquário",
                              descricao: "Uma das pessoas mais cultas e sábias do santuário, Dégel é discípulo do lendário cavaleiro Krest de Aquário. Assim como os demais Cavaleiros de Aquário Dégel também é um mestre no controle do frio. Seu poder é tamanho que conseguiu sozinho impedir o despertar de Poseidon, deus dos mares.Técnicas: Pó de Diamante, Pó de Diamante Zero, Círculo de Gelo, Grande Círculo de Gelo, Execução Aurora, Esquife de Gelo, Escudo de Gelo.",
                              imagem: "Degel de aquario"),
                
                Cavaleiros(nome: "Albafica de Peixes",
                              descricao: "Uma pessoa que ama a beleza da vida, mas em contrapartida é extremamente solitário por conta da sombra da morte que sempre o cerca. Albafica é um cavaleiro absurdamente poderoso com uma grande peculiaridade: seu sangue é venenoso.Seu poder é tão grande que, durante a Guerra Santa, ele enfrenta e derrota Minos de Griffon, um dos juízes de Hades, mas perde a vida no processo.",
                              imagem: "Albafica de peixes")
            ]
            
            return listCavaleiros
        }
        
    }

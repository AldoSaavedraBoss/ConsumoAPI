//
//  NoticiasViewController.swift
//  ConsumoAPI
//
//  Created by marco rodriguez on 18/10/21.
//

import UIKit
// MARK: - Estructuras
struct Noticias: Codable {
    var articles: [Noticia]
}


struct Noticia: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    
}

class NoticiasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var noticias = [Noticia]()
    
    // Se retor la cantidad de cledas igual  a la cantidad de articulos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Reutilizar la misa celda al mismo tiempo que se castea como la celda personalizada
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiasCell
        celda.LBTitulo.text = noticias[indexPath.row].title
        celda.LBDescripcion.text = noticias[indexPath.row].description
        if let url = URL(string: noticias[indexPath.row].urlToImage ?? "newspaper"){
            DispatchQueue.global().async { [weak self] in
                //Creaun un obejto data de una url
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            celda.IVNoticia.image = image
                        }
                    }
                }
                
            }
        }
        
        return celda
    }
    

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la celda
        tablaNoticias.register(UINib(nibName: "NoticiasCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        // Se usa el delagado para poder utilizar la tabla
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        // Se crea el string con la url de la API
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        // Se crea una variable segura del tipo URL
        if let url = URL(string: urlString) {
            // Se intenta traer los datos
            if let data = try? Data(contentsOf: url) {
                // Se llama al metodo para parsear los datos
                print("Listo para llamar a parse!")
             parse(json: data)
            }
        }


    }
    
    //Se parsean los datos para poderlos utilizar
    func parse(json: Data) {
        // Instanciacion del decodificador
        let decoder = JSONDecoder()
        print("Se llamo parse y creo decoder")
        // Variable segura para intentar decodificar los datos
        if let jsonPeticion = try? decoder.decode(Noticias.self, from: json) {
            print("Json Petitions: \(jsonPeticion.articles.count)")
            // Se guardan los articulos en una variable
            noticias = jsonPeticion.articles
            print("news: \(noticias.count)")
            // Se refresca la tabla
            tablaNoticias.reloadData()
        }
    }

    

    

}

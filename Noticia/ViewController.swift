//
//  ViewController.swift
//  Noticia
//
//  Created by Mac8 on 30/03/22.
//

import UIKit
//MARK- Estructura
struct  Noticias: Decodable, Encodable {
    var articles = [Noticia]
    
}
struct Noticia: Decodable, Encodable  {
    var title:String?
    var descripcion:String?
}

class ViewController: UIViewController{
    
    //para guardar los articulos de noticias y llenar la tabla
    //y lo inicializamos vacio
    var noticias =  [Noticias]()
   

    @IBOutlet weak var tablaNoticias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString =
            "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        if let url = URL(string:  urlString){
            if let data = try? Data(contentsOf: url){
                //la mandamos el json
                analizarJSON(json: data)
            }//if let data
        }//if let url
        //creeamos el JSON
        func analizarJSON(json: Data){
            let decodificador = JSONDecoder()
            
            if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
                print("Articulos de noticias son: \(datosDecodificados.articles.count)")
                print("Los articulos son: \(datosDecodificados.articles)")
            }
        }
    }//analizar json


}//viewControler
//MARK - METODOS DEL UITABLE

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Noticias"
        return celda
    }
    

  
}


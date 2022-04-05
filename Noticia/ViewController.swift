//
//  ViewController.swift
//  Noticia
//
//  Created by Mac8 on 30/03/22.
//
import SafariServices
import UIKit
//MARK- Estructura

struct Noticias: Decodable, Encodable {
    var articles: [Noticia]
}

struct Noticia: Decodable, Encodable  {
    var title:String?
    var descripcion:String?
    var urlToImage: String?
    var url: String?
    //agregamos para la url
    var source: Source?
    
}
//creamos la estructura
struct Source: Codable {
    var name: String?
}

//para guardar los articulos de noticias y llenar la tabla
//y lo inicializamos vacio

var articulosDeNoticias: [Noticia] = []
var urlAMandar: String?

class ViewController: UIViewController{
    var noticias =  [Noticias]()
    
   

    @IBOutlet weak var tablaNoticias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK REGISTRAR NUEVA TABLA
        //crear una tabla desde mi tabla noticias
        
        tablaNoticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString =
            "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        
        func analizarJSON(json: Data){
            print("se ejecuto analizarJSON")
            let decodificador = JSONDecoder()
            //variable segura datosDecoder
            if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
                
                //vaciar el array
               // articulosDeNoticias = datosDecodificados.articles
                
                print("Articulos de noticias son: \(datosDecodificados.articles.count)")
                print("Los articulos son: \(datosDecodificados.articles)")
                
            }
        }
        if let url = URL(string:  urlString){
            if let data = try? Data(contentsOf: url){
            //la mandamos el json
                analizarJSON(json: data)
            }
        }
      


}
    
}


//MARK - METODOS DEL UITABLE

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosDeNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                                                        //as para castear
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.tituloNoticiaLabel.text = articulosDeNoticias[indexPath.row].title
        celda.descripcionNoticiaLabel.text = articulosDeNoticias[indexPath.row].descripcion
        celda.fuenteNoticiaView.text = articulosDeNoticias[indexPath.row].source?.name
        
        //MARK crear imagen desde sitio web
        let urlImagen = articulosDeNoticias[indexPath.row].urlToImage ?? ""
        celda.imagenNoticiaLabel.cargadesdeSitioweb(direccionURL: urlImagen)
        
        return celda
    }
     
}
extension UIImageView{
    func cargadesdeSitioweb(direccionURL: String){
        guard let url = URL(string: direccionURL) else  {
            return  }
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url){
                if let imagenCargada = UIImage(data: imagenData){
                    self.image = imagenCargada
                }
            }
        }
    }
}

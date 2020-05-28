//
//  Terms&Conditions.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/26/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit

class Terms_Conditions: UIViewController {
    @IBOutlet weak var webPdf: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TERMS & CONDITIONS"

        mostrarPDF()
        habilitarZoom()

      let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
            self.navigationItem.leftBarButtonItem  = backButton
            // Do any additional setup after loading the view.
        
        
        }
        
        @objc func backFunction() {
            
            print("Back!")
            self.navigationController!.popViewController(animated: true)
            
        }
    
    func mostrarPDF() {
        
        // PASO 1: DIRECCION DEL ARVHIVO PDF
        
        let dirrecionPDF = URL(fileURLWithPath: Bundle.main.path(forResource: "XtgramsTerms", ofType: "pdf", inDirectory: "PDF")!) // inDirectory: es para ingresar en la carpeta
        
        // PASO 2: TRANSFORMAR ARCHIVO PDF A DATA
        
        let datosPDF = try? Data(contentsOf:dirrecionPDF) // SE VA A INTENTAR TRANFORMAR A UN TIPO DATA
        
        // PASO 3: MOSTRAR DATOS EN EL WEBVIEW O VISTA WEB
        
        webPdf.load(datosPDF!, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL: dirrecionPDF) // "utf-8": para abrir archivos PDF, existen otros tipos
        
    }
    
    func habilitarZoom() {
        
        webPdf.scalesPageToFit = true // FUNCIÓN PARA HABILITAR ZOOM EN PDF, POR DEFAULT ESTA EN FALSE Y ESTO NO PERMITE HACER ZOOM
    }

}

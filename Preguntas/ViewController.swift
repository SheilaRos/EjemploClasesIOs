//
//  ViewController.swift
//  Preguntas
//
//  Created by Sergi Garcia on 22/11/16.
//  Copyright © 2016 Stucom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var preguntasJava = [Pregunta]()
    var preguntasPhp = [Pregunta]()
    var preguntasSwift = [Pregunta]()
    
    var temas = ["Java", "PHP", "Swift"]
    
    var temaEscogido = ""
    var preguntaActual = Pregunta()
    var puntuacion = 0
    
    
    // Iboutlets
    @IBOutlet weak var temasPicker: UIPickerView!
    @IBOutlet weak var temaBoton: UIButton!
    @IBOutlet weak var preguntaLabel: UILabel!
    @IBOutlet weak var respuestaA: UIButton!
    @IBOutlet weak var respuestaB: UIButton!
    @IBOutlet weak var respuestaC: UIButton!
    @IBOutlet weak var respuestaD: UIButton!
    @IBOutlet weak var puntuacionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearPreguntas()
        temaEscogido = temas[0]
        temasPicker.delegate = self
        temasPicker.dataSource = self
        ocultarPregunta()
    }
    
    func ocultarPregunta() {
        preguntaLabel.alpha = 0
        respuestaA.alpha = 0
        respuestaB.alpha = 0
        respuestaC.alpha = 0
        respuestaD.alpha = 0
    }
    
    func crearPreguntas() {
        var rs = ["Swift", "Php", "Java", "Yo qué sé"]
        var p = Pregunta(pregunta: "Mejor lenguaje de programación", respuestas: rs, correcta: "Java")
        preguntasJava.append(p)
        rs = ["Windows Server", "Apache", "MySQL", "Otra vez no lo sé"]
        p = Pregunta(pregunta: "Servidor que permite ejecutar PHP", respuestas: rs, correcta: "Apache")
        preguntasPhp.append(p)
        rs = ["didReceiveMemoryWarning", "init", "new", "viewDidLoad"]
        p = Pregunta(pregunta: "Método que se ejecuta una vez cargada la vista", respuestas: rs, correcta: "viewDidLoad")
        preguntasSwift.append(p)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func escogerTema(_ sender: Any) {
        var ok = true
        restablecerBotones()
        switch temaEscogido {
        case "Java":
            if (preguntasJava.count > 0) {
             preguntaActual = preguntasJava[0]
            } else {
                ok = noHayMasPreguntas()
            }
            break
        case "PHP":
            if (preguntasPhp.count > 0) {
                preguntaActual = preguntasPhp[0]
            } else {
                ok = noHayMasPreguntas()
            }
            break
        case "Swift":
            if (preguntasSwift.count > 0) {
            preguntaActual = preguntasSwift[0]
            } else {
                ok = noHayMasPreguntas()
            }
            break
        default:
            print("error en escoger tema")
        }
        if (ok) {
            preguntaLabel.text = preguntaActual.pregunta
            respuestaA.setTitle(preguntaActual.respuestas[0], for: .normal)
            respuestaB.setTitle(preguntaActual.respuestas[1], for: .normal)
            respuestaC.setTitle(preguntaActual.respuestas[2], for: .normal)
            respuestaD.setTitle(preguntaActual.respuestas[3], for: .normal)
            temaBoton.isEnabled = false
        }
    }
    
    func noHayMasPreguntas() -> Bool {
        preguntaLabel.text = "No quedan más preguntas de este tema"
        return false
    }
    
    func restablecerBotones() {
        respuestaA.backgroundColor = UIColor.clear
        respuestaB.backgroundColor = UIColor.clear
        respuestaC.backgroundColor = UIColor.clear
        respuestaD.backgroundColor = UIColor.clear
        respuestaA.isEnabled = true
        respuestaB.isEnabled = true
        respuestaC.isEnabled = true
        respuestaD.isEnabled = true
        preguntaLabel.alpha = 1
        respuestaA.alpha = 1
        respuestaB.alpha = 1
        respuestaC.alpha = 1
        respuestaD.alpha = 1
    }
    
    func desactivarBotones() {
        respuestaA.isEnabled = false
        respuestaB.isEnabled = false
        respuestaC.isEnabled = false
        respuestaD.isEnabled = false
    }
    
    @IBAction func botonRespuesta(_ sender: UIButton) {
        if (sender.currentTitle == preguntaActual.correcta) {
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            puntuacion += 1
            puntuacionLabel.text = String(puntuacion)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        desactivarBotones()
        temaBoton.isEnabled = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temaEscogido = temas[row]
    }
    
}


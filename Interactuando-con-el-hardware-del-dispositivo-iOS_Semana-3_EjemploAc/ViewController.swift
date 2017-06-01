//
//  ViewController.swift
//  Interactuando-con-el-hardware-del-dispositivo-iOS_Semana-3_EjemploAc
//
//  Created by Juan Carlos Carbajal Ipenza on 1/06/17.
//  Copyright © 2017 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var xEtiqueta: UILabel!
    @IBOutlet weak var yEtiqueta: UILabel!
    @IBOutlet weak var zEtiqueta: UILabel!
    @IBOutlet weak var sacudida: UILabel!
    
    private let manejador = CMMotionManager()
    private let cola = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.manejador.isAccelerometerAvailable {
            self.manejador.accelerometerUpdateInterval = 1.0/10.0
            self.manejador.startAccelerometerUpdates(to: self.cola, withHandler: {
                datos, error in
                if error != nil {
                    self.manejador.stopAccelerometerUpdates()
                }
                else {
                    DispatchQueue.main.async(execute: {
                        self.xEtiqueta.text = "\(datos!.acceleration.x)"
                        self.yEtiqueta.text = "\(datos!.acceleration.y)"
                        self.zEtiqueta.text = "\(datos!.acceleration.z)"
                        if (datos!.acceleration.x > 1.6 ||
                            datos!.acceleration.y > 1.6 ||
                            datos!.acceleration.z > 1.6 ) {
                            self.sacudida.text = "Sì!!!"
                        }
                    })
                }
            })
        }
        else {
            print("Acelerómetro no disponible")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func limpiar() {
        self.sacudida.text = ""
    }

}


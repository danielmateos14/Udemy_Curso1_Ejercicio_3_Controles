//
//  ViewController.swift
//  ControlsAndTextViews
//
//  Created by Brais Moure on 22/11/2019.
//  Copyright © 2019 MoureDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//  MARK: ***************************** Outlets *************************************
    
    @IBOutlet weak var myButton: UIButton! //Boton
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myActivityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
//  MARK: ***************************** Variables *************************************
//    Array para mostrar en el picker
    private let myPickerViewValues = ["Uno", "Dos" , "Tres", "Cuatro", "Cinco"]
    
//  MARK: ***************************** ViewDidLoad *************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
// Buttons
        myButton.setTitle("Mi Botón", for: .normal) //cambia el titulo
        myButton.backgroundColor = .blue //cambia el color
        myButton.setTitleColor(.white, for: .normal) //cambia el color del titulo
        
// Pickers
        myPickerView.backgroundColor = .lightGray //cambia el fondo
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true //lo oculta
        
// PageControls
        myPageControl.numberOfPages = myPickerViewValues.count //numero de puntitos que aparecen
        myPageControl.currentPageIndicatorTintColor = .blue //cambia el color del puntito
        myPageControl.pageIndicatorTintColor = .lightGray //cambia color del punto no seleccionado
        
// SegmentedControls
        mySegmentedControl.removeAllSegments() //remover todos los elementos
        for (index, value) in myPickerViewValues.enumerated() {
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        } // se crea un for con el numero de elementos y su titulo, y se llama a la funcion
          //insert segment para que ponga el mismo numero de elementos con su nombre
        mySegmentedControl.selectedSegmentIndex = 0
        
// Sliders
        mySlider.minimumTrackTintColor = .red //cambia el color del segmento minimo
        mySlider.minimumValue = 1 //valor minimo
        mySlider.maximumValue = Float(myPickerViewValues.count) //valor maximo sera el tamaño del pickerview
        mySlider.value = 0 //valor seleccionado
        
// Steppers
        myStepper.minimumValue = 1 //Valor inicial
        myStepper.maximumValue = Double(myPickerViewValues.count)//valor maximo es el tamaño del array
        
// Switch
        mySwitch.onTintColor = .purple //color del boton
        mySwitch.isOn = false //estado inicial
        
// Progress Indicators
        myProgressView.progress = 0.2 //Valor inicial
        myActivityIndicatior.color = .orange //color del indicador
        myActivityIndicatior.startAnimating() //animacion
        myActivityIndicatior.hidesWhenStopped = true //apagado
        
// Labels
        myStepperLabel.textColor = .darkGray //color de texto
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 36) //tipo de fuente
        myStepperLabel.text = "1" //texto
        mySwitchLabel.text = "Está apagado" //texto
        
// TextFields
        myTextField.textColor = .brown //color del texto
        myTextField.placeholder = "Escribe algo" //el valor transparente que sugiere algo
        myTextField.delegate = self //delegado
        
// TextViews
        myTextView.textColor = .brown //color de texto
        //myTextView.isEditable = false // esto sirve para crear un label grande por que le
        // quitamos la edicion al texto
        myTextView.delegate = self //delegado
    }
    
    // Actions
    
//  MARK: ***************************** boton *************************************
    @IBAction func myButtonAction(_ sender: Any) {
        
//        Un if para cambiarlo de color
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        //para que se oculte el teclado al presionar el boton e indique que se ha temidado de
        // editar
        myTextView.resignFirstResponder()
    }
    
//  MARK: ***************************** Page Control *************************************
    @IBAction func myPageControlAction(_ sender: Any) {
        //extraemos el valor del pagcontrol
        let valorCurrentPage = myPageControl.currentPage
//        para que al seleccionar el indice que esta en el pagecontrol
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
//         Al cambiar de pagina, tambien se cambia el titulo del boton
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        
//        Al cambiar la pagina tambien se cambiar el segmento
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
        
        //le asignamos a todos los controles el valor del pagecontroller +1
        mySlider.value = Float(valorCurrentPage+1)
        myStepper.value = Double(valorCurrentPage+1)
        myStepperLabel.text = "\(valorCurrentPage+1)"
        //variable del progress y luego un switch con el valor del current page para ir
        //incrementando la progress en cada caso
        var progress: Float = 0
        switch valorCurrentPage{
        case 0:
            progress += 0.2
            myProgressView.progress = progress
        case 1:
            progress += 0.4
            myProgressView.progress = progress
        case 2:
            progress += 0.6
            myProgressView.progress = progress
        case 3:
            progress += 0.8
            myProgressView.progress = progress
        case 4:
            progress += 1
            myProgressView.progress = progress
        default: break
        }
    }
    
//  MARK: ***************************** segment control *************************************
    @IBAction func mySegmentControlAction(_ sender: Any) {
        // absorber valor
        let valorSegmento = mySegmentedControl.selectedSegmentIndex
//        para que al seleccionar un segmento el picker ponga el mismo
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
//        para que el seleccionar un segmento el titulo del boton cambie con ese nombre
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
//        al seleccionar un segment el mypagecontrol tambien va a cambiar de pagina
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
        //asignamos el valor del segemento extraido a todos los controles
        mySlider.value = Float(valorSegmento+1)
        myStepper.value = Double(valorSegmento+1)
        myStepperLabel.text = "\(valorSegmento+1)"
        // variable del progress para ir incrementando en cada caso
        var progress: Float = 0
        switch valorSegmento{
        case 0:
            progress += 0.2
            myProgressView.progress = progress
        case 1:
            progress += 0.4
            myProgressView.progress = progress
        case 2:
            progress += 0.6
            myProgressView.progress = progress
        case 3:
            progress += 0.8
            myProgressView.progress = progress
        case 4:
            progress += 1
            myProgressView.progress = progress
        default: break
        }
    }
    
//  MARK: ***************************** Slider *************************************
    @IBAction func mySliderAction(_ sender: Any) {
        //variable del progress para ir inccrementando
        var progress: Float = 0
        
//        El valor es de 1 a 5 y en cada caso va a pasar algo
        switch mySlider.value {
        case 1..<2:
//            Entre el 1 y menor de 2, cambiar el segmented control
            mySegmentedControl.selectedSegmentIndex = 0
            progress = 0.2
            //Cambiamos el picker en el case y ponemos la posicion 0,1,2
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            //En el pagecontrol ponemos lo mismo que en el pikcer
            myPageControl.currentPage = 0
            //creamos una variable string y le asginamos lo que tiene la
            //fila del pickerview y despues se lo ponemos al settitle del
            //boton
            let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
            myButton.setTitle(myString, for: .normal)
            //asigamos cada indice al stepper
            myStepper.value = 1
            myStepperLabel.text = "1"
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            progress = 0.4
            myPickerView.selectRow(1, inComponent: 0, animated: true)
            myPageControl.currentPage = 1
            let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
            myButton.setTitle(myString, for: .normal)
            myStepper.value = 2
            myStepperLabel.text = "2"
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progress = 0.6
            myPickerView.selectRow(2, inComponent: 0, animated: true)
            myPageControl.currentPage = 2
            let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
            myButton.setTitle(myString, for: .normal)
            myStepper.value = 3
            myStepperLabel.text = "3"
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progress = 0.8
            myPickerView.selectRow(3, inComponent: 0, animated: true)
            myPageControl.currentPage = 3
            let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
            myButton.setTitle(myString, for: .normal)
            myStepper.value = 4
            myStepperLabel.text = "4"
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progress = 1
            myPickerView.selectRow(4, inComponent: 0, animated: true)
            myPageControl.currentPage = 4
            let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
            myButton.setTitle(myString, for: .normal)
            myStepper.value = 5
            myStepperLabel.text = "5"
        }
        //Toma el valor saliendo de cada case
        myProgressView.progress = progress
    }
    
//  MARK: ***************************** Stepper *************************************
    @IBAction func myStepperAction(_ sender: Any) {
        //variable para incrementar el progress
        var progress: Float = 0
        //Extraemos el valor del stepper en una variable
        let value = myStepper.value
        //En el segmento asignamos el valor del stepper -1
        mySegmentedControl.selectedSegmentIndex = Int(value-1)
        //Se lo asginamos al myslider
        mySlider.value = Float(value)
        //Se lo asginamos al label que esta a la derecha
        myStepperLabel.text = "\(Int(value))"
        //asignamos el valor de value al picker en el row para que se mueva
        myPickerView.selectRow(Int(value-1), inComponent: 0, animated: true)
        //asigamos el valor al pagecontrol
        myPageControl.currentPage = Int(value-1)
        //creamos un string donde extraemos el string del row del picker y despes se lo ponemos
        //al title del boton
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        //el switch del value para el progressbar
        switch value{
        case 1:
            progress += 0.2
            myProgressView.progress = progress
        case 2:
            progress += 0.4
            myProgressView.progress = progress
        case 3:
            progress += 0.6
            myProgressView.progress = progress
        case 4:
            progress += 0.8
            myProgressView.progress = progress
        case 5:
            progress += 1
            myProgressView.progress = progress
        default: break
        }
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        // if para decir que si el switch esta encendido muestra el picker view y detiene
        // el activity indicator muestra la label con encendido y apagado en caso contrario
        // esconde el picker y activa la animacion
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myActivityIndicatior.stopAnimating()
            
            mySwitchLabel.text = "Está encendido"
        } else {
            myPickerView.isHidden = true
            myActivityIndicatior.startAnimating()
            
            mySwitchLabel.text = "Está apagado"
        }
    }
    
}

//  MARK: ***************************** Extension PickerView *************************************
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
//    Numero de columnas
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    Numero de filas
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
//    Cuales componente va a tener
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
//    Al seleccionar una fila que pasa
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row // al momento de seleccionar una fila se mueve el pagecontrol
        
        mySegmentedControl.selectedSegmentIndex = row //Al momento de seleccionar una fila se mueve el segment control
        //Asignamos el row +1 a todos los controles
        mySlider.value = Float(row+1)
        myStepper.value = Double(row+1)
        myStepperLabel.text = "\(row+1)"
        //variable para el progress para incrementarla
        var progress: Float = 0
        switch row{
        case 0:
            progress += 0.2
            myProgressView.progress = progress
        case 1:
            progress += 0.4
            myProgressView.progress = progress
        case 2:
            progress += 0.6
            myProgressView.progress = progress
        case 3:
            progress += 0.8
            myProgressView.progress = progress
        case 4:
            progress += 1
            myProgressView.progress = progress
        default: break
        }
    }
    
}

//  MARK: ***************************** Extension TextField *************************************
extension ViewController: UITextFieldDelegate {
    // funcion para cuando pulsas el boton return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //finaliza la edicion
        textField.resignFirstResponder()
    }
    //funcion para identificar cuando termina la edicion
    func textFieldDidEndEditing(_ textField: UITextField) {
        //le asignamos al titlulo del boton lo qe tenga el texfield
        myButton.setTitle(myTextField.text, for: .normal)
    }
    
}

//  MARK: ***************************** Extension TextView *************************************
extension ViewController: UITextViewDelegate {
    //Funcion para indicar que se ha empezado a editar el texto
    func textViewDidBeginEditing(_ textView: UITextView) {
        //al empezar a editar el textfield se oculta
        myTextField.isHidden = true
    }
    //al finalizar la edicion el textfield aparece de nuevo
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
    
}


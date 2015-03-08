//
//  SecViewCon.swift
//  locBase
//
//  Created by Rodolfo Castillo on 07/03/15.
//  Copyright (c) 2015 Rodolfo Castillo. All rights reserved.
//

import UIKit
import Foundation
import CoreBluetooth


class SecViewCon: UIViewController {
    
    var pedez: CGFloat = 1.145
    var unidades: CGFloat = 293
    var max: CGFloat = 1.145
    var ble: BLE!
    
    

    @IBOutlet weak var progBar: UILabel!
    @IBOutlet weak var backResponder: UILabel!
    
    @IBAction func event(sender: AnyObject) {
        loader()

    }
    @IBOutlet weak var daLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.progBar.frame = CGRect(x: -253, y: 407, width: 293, height: 62)
        self.daLabel.text = "Bienvenido a Esta cosa!"
        
        
        
        // Do view setup here.
    }
    
    
    @IBAction func buttonConectarBLE(sender: AnyObject) {
        //scanForPeripherals()
    }
    func loader(){
        
        if pedez >= max {
            pedez = max
        }
        var mensaje: String
        var llenado: CGFloat = (unidades)*(pedez) - 293
        var inicio: CGFloat = 41 - (unidades)
        var calTime: Double = Double(CGFloat(pedez)*5)
        var time: NSTimeInterval = calTime
        self.progBar.frame = CGRect(x: inicio, y: 407, width: 293, height: 62)
        if pedez <= 0.5 {
            self.progBar.backgroundColor = UIColor.greenColor()
            self.daLabel.text = "Te encuentras bien para manejar :)."
            mensaje = "Estoy bien"
            sms(mensaje)
        } else if pedez <= 0.7{
            self.progBar.backgroundColor = UIColor.yellowColor()
            self.daLabel.text = "Puedes manejar pero ten precaución."
            mensaje = "Estoy Mas o menos"
            sms(mensaje)
        } else if pedez >= 0.8{
            self.progBar.backgroundColor = UIColor.redColor()
            self.daLabel.text = "Legalmente ya no puedes conducir, te recomendamos pedir un taxi."
            mensaje = "pedo"
            sms(mensaje)
        } else if pedez > 1.2{
            self.backResponder.backgroundColor = UIColor.redColor()
            self.backResponder.alpha = 1.0
            self.daLabel.text = "Legalmente ya no puedes conducir, te recomendamos pedir un taxi."
            mensaje = "pedo"
            sms(mensaje)
            
        }
        // lets set the duration to 1.0 seconds
        // and in the animations block change the background color
        // to red and the x-position  of the frame
        UIView.animateWithDuration(time, animations: {
            
            
            // for the x-position I entered 320-50 (width of screen - width of the square)
            // if you want, you could just enter 270
            // but I prefer to enter the math as a reminder of what's happenings
            self.progBar.frame = CGRect(x: llenado, y: 407, width: 293, height: 62)
        })

    }
    
    
    func sms(mensaje: String) {
        
        
        var element: [String : String] = ["message": "\(mensaje)"]
        
        let req = Agent.post("https://warm-depths-9978.herokuapp.com/message")
        req.send([ "order": element])
        req.end({ (response: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
            // react to the result of your request
            println("listo")
        })
    }
    
    
    func bleDidRecieveData(data: NSString, length: Int)-> Void{
        
        var datos: [NSMutableArray]?
        for var i = 0; i < length; ++i {
            var result: UInt32 = 0
            
            var scanner : NSScanner = NSScanner.localizedScannerWithString(data) as NSScanner
            scanner.scanLocation = 0
            scanner.scanHexInt(&result)
            
            
            
        }
        
        
    }
    /*
    /*
    
    DONE
    
    -(void)bleDidReceiveData:(unsigned char *)data length:(int)length{
    
    */
    
    
    
    func scanForPeripherals()->Void{
        var susy: NSTimer!

        //if (self.ble.peripherals.count > 0){
       //     self.ble.peripherals == nil
        //}
        self.ble.findBLEPeripherals(2)
        susy = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("connectionTimer"), userInfo: nil, repeats: false)
    
    }
    
    
    /*  DONE
    
    -(void)scanForPeripherals:(id)sender
    
    */
    
    func disconnectFromPeripheral()->Void{
        if (self.ble.activePeripheral != nil){
            if (self.ble.activePeripheral.state.rawValue != 0){
                self.ble.CM.cancelPeripheralConnection(self.ble.activePeripheral)
            }
        }
    }
    
    
    /*DONE
    
    -(void)disconnectFromPeripheral{
    
    
    */
    
    func connectionTimer(timer: NSTimer)->Void{
        if self.ble.peripherals.count > 0{
            self.ble.connectPeripheral(self.ble.peripherals.objectAtIndex(0) as CBPeripheral)
        } else {
            println("Conexion Perdida")
        }
    }
    
        /* -(void)connectionTimer:(NSTimer*)timer{
        
        if(self.ble.peripherals.count > 0){
        [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
        }else{
        NSLog(@"Conexión Perdida");
        }
        }
    
    
    */
    
    
    
    /*  Done
    
    -(void)bleDidConnect
    
    */
    
    
    
    /*  DONE
    
    -(void)bleDidDisconnect
    
    */
    
    
}
    
    
    //Codigo de Mario
    
    /*
    @interface ViewController ()
    
    @end
    
    @implementation ViewController
    @synthesize rssiLabel;
    @synthesize buttonConectarBLE;
    @synthesize ble;
    
    
    - (void)viewDidLoad
    {
    [super viewDidLoad];
    
    self.ble = [[BLE alloc]init];   Done
    [self.ble controlSetup];        Done
    self.ble.delegate = self;       Done
    }
    
    - (void)didReceiveMemoryWarning
    {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }
    
    -(void)bleDidReceiveData:(unsigned char *)data length:(int)length{
    
    //NSData *d = [NSData dataWithBytes: data length:length];
    NSMutableArray *datos = [NSMutableArray arrayWithCapacity:length];
    //int enteros[length];
    //NSArray
    
    for (NSInteger i=0; i<length; i++) {
    unsigned int result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%02x",data[i]]];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];
    
    [datos addObject:[NSNumber numberWithInt:result]];
    //enteros[i] = result;
    //[datos addObject:[NSString stringWithFormat:@"%@",datos[i]]];
    }
    
    self.acelerometroLabel.text = [NSString stringWithFormat:@" de alcohol en la sangre:  %@",datos[0]];
    self.giroscopioLabel.text = [NSString stringWithFormat:@"       Puedes conducir:  %@",datos[1]];
    
    NSLog(@"tamaño: %d",length);
    NSLog(@"  data: %s",data);
    //NSLog(@"     d: %@",d);
    NSLog(@" datos: %@",datos);
    
    }
    
    
    
    -(void)bleDidUpdateRSSI:(NSNumber *)rssi{
    self.rssiLabel.text = [NSString stringWithFormat:@"RSSI: %@", rssi];
    }
    
    -(void) readRSSITimer:(NSTimer *)timer
    {
    [self.ble readRSSI];
    }
    
    #pragma mark - BLE Actions
    -(void)scanForPeripherals:(id)sender{
    
    if(self.ble.peripherals){
    self.ble.peripherals = nil;
    }
    
    [self.ble findBLEPeripherals:2];
    [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    }
    
    -(void)disconnectFromPeripheral{
    if(self.ble.activePeripheral){
    if (self.ble.activePeripheral.state) {
    [[self.ble CM] cancelPeripheralConnection:[self.ble activePeripheral]];
    
    }
    }
    }
    
    -(void)connectionTimer:(NSTimer*)timer{
    
    if(self.ble.peripherals.count > 0){
    [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
    }else{
    NSLog(@"Conexión Perdida");
    }
    }
    
    -(void)bleDidConnect{
    [self.buttonConectarBLE setTitle:@"Desconectar" forState:UIControlStateNormal];
    [self.buttonConectarBLE removeTarget:self action:@selector(scanForPeripherals:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonConectarBLE addTarget:self action:@selector(disconnectFromPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonConectarBLE setEnabled:YES];
    }
    
    -(void)bleDidDisconnect{
    self.rssiLabel.text = @"RSSI: --";
    [self.buttonConectarBLE setTitle:@"Conectar BLE" forState:UIControlStateNormal];
    [self.buttonConectarBLE removeTarget:self action:@selector(disconnectFromPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonConectarBLE addTarget:self action:@selector(scanForPeripherals:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonConectarBLE setEnabled:YES];
    
    }
    
    - (IBAction)conectarBLE:(id)sender {
    [self scanForPeripherals:self];
    }
    
    
    
    @end
    
    */
    */

}
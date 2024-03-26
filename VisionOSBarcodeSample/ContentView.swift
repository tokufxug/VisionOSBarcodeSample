//
//  ContentView.swift
//  VisionOSBarcodeSample
//
//  Created by Sadao Tokuyama on 3/26/24.
//

import SwiftUI
import RealityKit
import Vision

struct ContentView: View {
    
    @State var qrData = ""
    let qrImage = UIImage(named: "qr")
    
    var body: some View {
        VStack {
            Image(uiImage: qrImage!)
            Text(qrData)
            Button(action: {
                qrData = extractQRCode(image: qrImage!)!
                UIApplication.shared.open(URL(string: qrData)!)
            }) {
                Text("Access")
            }
        }
        .padding()
    }
    
    private func extractQRCode(image: UIImage) -> String? {
        let qrImage = image
        let cgImage = qrImage.cgImage
            
        let handler = VNImageRequestHandler(cgImage: cgImage!)
            
        let barcodeRequest = VNDetectBarcodesRequest()
        barcodeRequest.symbologies = [.qr]
        
        try?handler.perform([barcodeRequest])
            
        guard let results = barcodeRequest.results, let firstBarcode = results.first?.payloadStringValue else {
                return nil
        }
        print(firstBarcode)
        return firstBarcode
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

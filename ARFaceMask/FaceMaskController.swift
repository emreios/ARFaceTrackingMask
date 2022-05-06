//
//  FaceMaskController.swift
//  ARFaceMask
//
//  Created by Emre on 6.05.2022.
//

import UIKit
import ARKit

class FaceMaskController: UIViewController, ARSCNViewDelegate {
    
    //MARK: - Properties

    let faceScanView: ARSCNView = {
        
        let faceView = ARSCNView()
        faceView.backgroundColor = .red
        return faceView
    }()

    //MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        faceScanView.delegate = self
        
        setScanViewConstraints()
        
        guard ARFaceTrackingConfiguration.isSupported else {
            
            fatalError("Not Supported")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
            
      let scanConfigure = ARFaceTrackingConfiguration()
      faceScanView.session.run(scanConfigure)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
            
      faceScanView.session.pause()
    }
    
    //MARK: - Face Mask Render
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let camera = faceScanView.device else { return nil }
        
        let faceShape = ARSCNFaceGeometry(device: camera)
        
        let tie = SCNNode(geometry: faceShape)
        
        tie.geometry?.firstMaterial?.fillMode = .lines
        
        return tie
    }
    
    //MARK: - Face Border Tracking
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceBorders = anchor as? ARFaceAnchor, let faceGeo = node.geometry as? ARSCNFaceGeometry else { return }
        
        faceGeo.update(from: faceBorders.geometry)
    }
    
    
    //MARK: - Set Constraints
    
    fileprivate func setScanViewConstraints() {
        
        view.addSubview(faceScanView)
        faceScanView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            faceScanView.topAnchor.constraint(equalTo: view.topAnchor),
            faceScanView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            faceScanView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            faceScanView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }


}





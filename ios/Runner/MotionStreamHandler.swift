//
//  MotionStreamHandler.swift
//  Runner
//
import CoreMotion

class MotionStreamHandler: NSObject, FlutterStreamHandler {
    
    private let motionManager:CMMotionManager = CMMotionManager()
    private let threshold = 0.01
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        startDeviceMotion(events: events)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopDeviceMotion()
        return nil
    }
    
    func startDeviceMotion(events: @escaping FlutterEventSink) {
        
        if self.motionManager.isDeviceMotionAvailable {
            
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 40.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                
                
                var x = data!.attitude.pitch
                var y = data!.attitude.roll
//                var z = data!.attitude.yaw
                
                if (abs(x) < self.threshold) {x = 0}
                if (abs(y) < self.threshold) {y = 0}

                if abs(x) > 0 || abs(y) > 0 {
                    events([y, x])
                }
            }
        }
    }
    
    func stopDeviceMotion() {
        self.motionManager.stopDeviceMotionUpdates()
    }
}


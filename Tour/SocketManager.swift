

import Foundation
import SocketIO

class SocketManager: NSObject {
    
    static let socket = SocketIOClient.init(socketURL: URL(string: GetDataFromURL.URL)!, config: [.log(false), .forcePolling(true)])
    
    static func establishConnection(username:String) {
        socket.connect()
        socket.removeAllHandlers()
        
        socket.on("connect"){data in
            print("connected")
            socket.emit("join-myroom",username)
            
        }
    }
    
    static func closeConnection() {
        socket.removeAllHandlers();
        socket.disconnect()
    }
    
}

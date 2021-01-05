//
//  StarscreamWebSocketsClientStrategy.swift
//  f30
//
//  Created by David on 21/04/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFNet
import Starscream

/// A strategy for communicating with a WebSocket using Starscream
public class StarscreamWebSocketsClientStrategy: WebSocketsClientStrategyBase {
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(urlString: String) {
		super.init(urlString: urlString)
	}
	
	deinit {
		
		self.dispose()
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func getWebSocket() -> WebSocket? {
		
		return self.webSocket as? WebSocket
		
	}
	
		
	// MARK: - Override Methods
	
	public override func dispose() {
		
		guard (self.webSocket != nil) else { return }
		
		self.getWebSocket()!.disconnect(forceTimeout: 0)
		self.getWebSocket()!.delegate 	= nil
		
		self.webSocket 					= nil
		
	}
	
	public override func setupWebSocket() {
		
		if (self.webSocket != nil) {
			
		}
		
		let applicationID: 				String? = self.properties!["ApplicationID"]
		let clientRelativeMemberID: 	String? = self.properties!["ClientRelativeMemberID"]
		
		guard (applicationID != nil && clientRelativeMemberID != nil) else { return }
		
		// Create Url
		let url: 						URL? = URL(string: String(format: self.urlString!, applicationID!, "memberfeed", clientRelativeMemberID!))
		
		// Create webSocket
		self.webSocket					= WebSocket(url: url!)
		
		self.getWebSocket()!.delegate 	= self
	
		self.isWebSocketSetupYN 		= true
		
	}
	
	public override func doConnect() -> WebSocketsClientResultCode {
		
		// Check whether to setup web socket
		if (self.webSocket == nil || !self.isWebSocketSetupYN) {
			
			self.setupWebSocket()
			
		}
		
		// Check webSocket
		guard (self.webSocket != nil) else {
			
			return WebSocketsClientResultCode.Error
			
		}
		
		// Check isConnected
		guard (!self.getWebSocket()!.isConnected) else {
			
			return WebSocketsClientResultCode.ErrorAlreadyConnected
			
		}
		
		// Connect
		self.getWebSocket()!.connect()
		
		return WebSocketsClientResultCode.AwaitingResult
		
	}
	
	public override func doDisconnect() -> WebSocketsClientResultCode {
		
		if (self.webSocket == nil) {
			
			return WebSocketsClientResultCode.Error
			
		} else {
			
			guard (self.getWebSocket()!.isConnected) else {
				return WebSocketsClientResultCode.ErrorAlreadyDisconnected
			}
			
			self.getWebSocket()!.disconnect()
			
		}
		
		return WebSocketsClientResultCode.AwaitingResult
		
	}
	
	public override func doSend(messageString: String) -> WebSocketsClientResultCode {
		
		if (self.webSocket == nil) {
			
			return WebSocketsClientResultCode.Error
			
		} else {
			
			guard (self.getWebSocket()!.isConnected) else {
				return WebSocketsClientResultCode.ErrorNotConnected
			}
		
			self.getWebSocket()!.write(string: messageString)
			
		}
		
		return WebSocketsClientResultCode.DidSendMessage
		
	}
	
}


// MARK: - Extension ProtocolWebSocketsDisplayControlManagerDelegate

extension StarscreamWebSocketsClientStrategy: WebSocketDelegate {
	
	public func websocketDidConnect(socket: WebSocketClient) {
		
		self.didConnect()
		
	}
	
	public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
		
		self.didDisconnect()
		
	}
	
	public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
		
		self.didReceiveMessage(messageString: text)
		
	}
	
	public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {

	}
	
}



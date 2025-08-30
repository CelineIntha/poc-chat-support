import { Injectable } from '@angular/core';
import {ChatMessage} from '../models/chat-message';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private socket?: WebSocket;
  private listeners: ((msg: ChatMessage) => void)[] = [];

  connect() {
    this.socket = new WebSocket('ws://localhost:8080/chat');

    this.socket.onmessage = (event) => {
      try {
        const data: ChatMessage = JSON.parse(event.data);
        this.listeners.forEach(cb => cb(data));
      } catch (e) {
        console.error("Message JSON invalide :", event.data);
      }
    };
  }

  sendMessage(message: string) {
    const msg: ChatMessage = { from: 'User', content: message };
    this.socket?.send(JSON.stringify(msg));
  }

  onMessage(cb: (msg: ChatMessage) => void) {
    this.listeners.push(cb);
  }
}

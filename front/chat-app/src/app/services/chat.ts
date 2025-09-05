import { Injectable } from '@angular/core';
import { ChatMessage } from '../models/chat-message';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private socket?: WebSocket;
  private listeners: ((msg: ChatMessage) => void)[] = [];
  private openListeners: (() => void)[] = [];

  connect() {
    this.socket = new WebSocket('ws://localhost:8080/chat');

    this.socket.onopen = () => {
      console.log("WebSocket connecté !");
      this.openListeners.forEach(cb => cb());
    };

    this.socket.onmessage = (event) => {
      try {
        const data: ChatMessage = JSON.parse(event.data);
        this.listeners.forEach(cb => cb(data));
      } catch (e) {
        console.error("Message JSON invalide :", event.data);
      }
    };
  }

  sendMessage(message: ChatMessage) {
    if (this.socket?.readyState === WebSocket.OPEN) {
      this.socket.send(JSON.stringify(message));
    } else {
      console.warn("Tentative d'envoi d'un message alors que la socket n'est pas encore ouverte");
    }
  }

  onMessage(cb: (msg: ChatMessage) => void) {
    this.listeners.push(cb);
  }

  onOpen(cb: () => void) {
    this.openListeners.push(cb);
  }
}

import { Component, OnInit } from '@angular/core';
import { ChatService } from '../../services/chat';
import { ChatMessage } from '../../models/chat-message';
import { FormsModule } from '@angular/forms';
import { NgClass } from '@angular/common';
import { MatCard, MatCardActions, MatCardContent, MatCardTitle } from '@angular/material/card';
import { MatButton } from '@angular/material/button';

@Component({
  selector: 'app-chat',
  standalone: true,
  imports: [FormsModule, NgClass, MatCardTitle, MatCard, MatCardContent, MatCardActions, MatButton],
  templateUrl: './chat.html',
  styleUrl: './chat.scss'
})
export class ChatComponent implements OnInit {
  messages: ChatMessage[] = [];
  newMessage: string = '';

  currentRole: 'client' | 'support' = 'client';
  currentChatId: string = 'room-123';

  constructor(private chatService: ChatService) {}

  ngOnInit() {
    this.chatService.connect();

    this.chatService.onOpen(() => {
      this.sendJoinMessage(this.currentRole);
    });

    this.chatService.onMessage((msg) => {
      this.messages.push(msg);
    });
  }

  onRoleChange() {
    this.sendJoinMessage(this.currentRole);
  }

  private sendJoinMessage(role: 'client' | 'support') {
    const joinMsg: ChatMessage = {
      chatId: this.currentChatId,
      from: role,
      content: 'JOIN'
    };
    this.chatService.sendMessage(joinMsg);
  }

  sendMessage() {
    if (this.newMessage.trim()) {
      const msg: ChatMessage = {
        chatId: this.currentChatId,
        from: this.currentRole,
        content: this.newMessage
      };
      this.chatService.sendMessage(msg);
      this.newMessage = '';
    }
  }
}

import {Component, OnInit} from '@angular/core';
import {ChatService} from '../../services/chat';
import {FormsModule} from '@angular/forms';
import {ChatMessage} from '../../models/chat-message';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatListModule } from '@angular/material/list';

@Component({
  selector: 'app-chat',
  imports: [
    FormsModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatListModule
  ],
  templateUrl: './chat.html',
  styleUrl: './chat.scss'
})
export class ChatComponent implements OnInit {
  messages: ChatMessage[] = [];
  newMessage: string = '';

  constructor(private chatService: ChatService) {}

  ngOnInit() {
    this.chatService.connect();
    this.chatService.onMessage((msg) => {
      this.messages.push(msg);
    });
  }

  sendMessage() {
    if (this.newMessage.trim()) {
      this.chatService.sendMessage(this.newMessage);
      this.newMessage = '';
    }
  }
}

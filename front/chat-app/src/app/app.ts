import { Component, signal } from '@angular/core';
import {ChatComponent} from './features/chat/chat';

@Component({
  selector: 'app-root',
  imports: [
    ChatComponent
  ],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  protected readonly title = signal('chat-app');
}

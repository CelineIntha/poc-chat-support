export interface ChatMessage {
  chatId: string;
  from: 'client' | 'support';
  content: string;
}

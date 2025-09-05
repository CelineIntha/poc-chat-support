package com.ycyw.chat_poc.model;

public class ChatMessage {
    private String chatId;
    private String from;
    private String content;

    public ChatMessage() {}

    public ChatMessage(String chatId, String from, String content) {
        this.chatId = chatId;
        this.from = from;
        this.content = content;
    }

    public String getChatId() {
        return chatId;
    }

    public void setChatId(String chatId) {
        this.chatId = chatId;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "ChatMessage{" +
                "chatId='" + chatId + '\'' +
                ", from='" + from + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}

package com.ycyw.chat_poc.model;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoom {
    private String chatId;
    private WebSocketSession client;
    private WebSocketSession support;

    public ChatRoom(String chatId, WebSocketSession client) {
        this.chatId = chatId;
        this.client = client;
    }

    public String getChatId() {
        return chatId;
    }

    public WebSocketSession getClient() {
        return client;
    }

    public WebSocketSession getSupport() {
        return support;
    }

    public void assignSupport(WebSocketSession support) {
        this.support = support;
    }

    public boolean isSupportAssigned() {
        return support != null;
    }

    public void setClient(WebSocketSession session) {
        this.client = session;
    }
}

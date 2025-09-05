package com.ycyw.chat_poc.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ycyw.chat_poc.model.ChatMessage;
import com.ycyw.chat_poc.model.ChatRoom;
import org.springframework.lang.NonNull;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ChatHandler extends TextWebSocketHandler {

    private final Map<String, ChatRoom> chatRooms = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void handleTextMessage(@NonNull WebSocketSession session, @NonNull TextMessage message) throws Exception {
        ChatMessage chatMessage = objectMapper.readValue(message.getPayload(), ChatMessage.class);
        String chatId = chatMessage.getChatId();

        chatRooms.putIfAbsent(chatId, new ChatRoom(chatId, null));
        ChatRoom room = chatRooms.get(chatId);

        if ("client".equals(chatMessage.getFrom())) {
            if (room.getClient() == null) {
                room.setClient(session);
            }
            if (!"JOIN".equals(chatMessage.getContent())) {
                broadcast(room, chatMessage);
            }

        } else if ("support".equals(chatMessage.getFrom())) {
            if (!room.isSupportAssigned()) {
                room.assignSupport(session);
            }
            if (!"JOIN".equals(chatMessage.getContent())) {
                broadcast(room, chatMessage);
            }
        }
    }

    private void broadcast(ChatRoom room, ChatMessage chatMessage) throws Exception {
        String json = objectMapper.writeValueAsString(chatMessage);

        if (room.getClient() != null && room.getClient().isOpen()) {
            room.getClient().sendMessage(new TextMessage(json));
        }
        if (room.getSupport() != null && room.getSupport().isOpen()) {
            room.getSupport().sendMessage(new TextMessage(json));
        }
    }

    @Override
    public void afterConnectionClosed(@NonNull WebSocketSession session, @NonNull CloseStatus status) {
        chatRooms.values().forEach(room -> {
            if (room.getClient() == session) {
                room.setClient(null);
            } else if (room.getSupport() == session) {
                room.assignSupport(null);
            }
        });
    }
}

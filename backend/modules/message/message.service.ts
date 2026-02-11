import {
  createMessage,
  getMessages,
  deleteMessage,
} from "./message.repository.js";

export async function sendMessageService(
  channelId: string,
  authorId: string,
  content: string,
) {
  return createMessage({
    channelId,
    authorId,
    content,
  });
}

export async function fetchMessagesService(channelId: string) {
  return getMessages(channelId);
}

export async function deleteMessageService(messageId: string) {
  return deleteMessage(messageId);
}

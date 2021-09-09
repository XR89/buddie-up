import consumer from "./consumer";

const initChatCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatId;
    consumer.subscriptions.create({ channel: "ChatChannel", id: id }, {
      received(data) {
        // console.log(data);
        messagesContainer.insertAdjacentHTML('beforeend', data);
        const messages = document.querySelectorAll(".message");
        const currentUser = document.getElementById("messages").dataset.userId;
        messages.forEach(message => {
          if (message.dataset.senderId === currentUser) {
            message.classList.add("message-self");
          } else {
            message.classList.add("message-other");
          };
        });
      }
    });

  }
}

export { initChatCable };

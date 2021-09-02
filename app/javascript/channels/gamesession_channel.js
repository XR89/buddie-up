import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "GameSessionChannel", id: id}, {
      received(data) {
        console.log(data);
      },
    });
  }
}

export { initChatroomCable }

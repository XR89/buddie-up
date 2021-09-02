import consumer from "./consumer";

const initGameSessionCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    // consumer.subscriptions.create({ channel: "GameSessionChannel", id: id}, {
    //   received(data) {
    //     console.log(data);
    //   },
    // });
    consumer.subscriptions.create({ channel: "GameSessionChannel", id: id }, {
      received(data) {
        console.log(data);
        messagesContainer.insertAdjacentHTML('beforeend', data);
      }
    });
  }
}

export { initGameSessionCable };

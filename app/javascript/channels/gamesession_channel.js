import consumer from "./consumer";

const initGameSessionCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.gamesessionId;
    // console.log('test2');
    // consumer.subscriptions.create({ channel: "GameSessionChannel", id: id}, {
    //   received(data) {
    //     console.log(data);
    //   },
    // });
    // if else statement
    consumer.subscriptions.create({ channel: "GameSessionChannel", id: id }, {
      received(data) {
        // console.log('test');
        console.log(data);
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

export { initGameSessionCable };

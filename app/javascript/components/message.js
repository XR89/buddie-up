const message = () => {
  const form = document.querySelector('form');
  document.addEventListener('keydown', (e) => {
    const usermessage = document.getElementById('message_content').value
    if (e.code == 'Enter' && usermessage.length != 0 ) {
      form.submit();
    }
  })
}

// const usermessage = document.getElementById('usermessage');

// const submitmessage = (e) =>  {
//   e.insertAdjacentHTML("beforeend", usermessage.textarea.value)
// }

export { message };

const message = () => {
  const createmessage = document.getElementById('createmesssage');
  createmessage.addEventListener('keydown', () => {
    if (e.code == 'Enter') {
      submitmessage()
    }
  })
}

const usermessage = document.getElementById('usermessage');

const submitmessage = (e) =>  {
  e.insertAdjacentHTML("beforeend", usermessage.textarea.value)
}

export { message };

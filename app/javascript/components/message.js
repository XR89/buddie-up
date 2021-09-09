const message = () => {
  const form = document.querySelector('form');
  // document.getElementById('message_content').mouseup();
  setTimeout(() => {
    document.querySelector('message_content').focus();
  }, 300);
  document.querySelector('message_content').select();
  // console.log(document.getElementById('message_content').focus());
  // console.log(document.getElementById('message_content').select());
  document.addEventListener('keydown', (e) => {
    const usermessage = document.getElementById('message_content').value
    console.log(usermessage);
    if (e.code == 'Enter' && usermessage.length != 0 ) {
      form.submit();
    }
  });
}


export { message };

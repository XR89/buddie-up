const message = () => {
  const form = document.querySelector('form');
  console.log(form);
  // document.getElementById('message_content').mouseup();
  console.log(document.querySelector('.chat--input').focus());
  console.log(document.querySelector('.chat--input').select());

  // console.log(document.getElementById('message_content').focus());
  // console.log(document.getElementById('message_content').select());
  document.addEventListener('keydown', (e) => {
    const usermessage = document.getElementById('message_content').value
    console.log(usermessage);
    if (e.code == 'Enter' && usermessage.length != 0 ) {
      form.submit();
    }
  })
}


export { message };

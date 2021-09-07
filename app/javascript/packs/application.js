// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import "controllers"
import "channels"
import { initGameSessionCable } from '../channels/gamesession_channel';
import { dropdown } from '../components/dropdown';
import { initStarRating } from '../plugins/init_star_rating';

initStarRating();


const removeBootstrapFromSimpleForms = () => {
  let bootstrapButtons = document.querySelectorAll(".btn");
  bootstrapButtons.forEach(button => {
    button.classList.remove("btn");
  });
};

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initGameSessionCable();
  dropdown();
  removeBootstrapFromSimpleForms();
});

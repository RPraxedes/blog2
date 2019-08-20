import jQuery from 'jquery';
import popper from 'popper.js';
import Rails from '@rails/ujs';
import Turbolinks from "turbolinks";

Turbolinks.start();

window.$ = jQuery;
window.jQuery = jQuery;
window.Popper = popper;
window.Turbolinks = Turbolinks;

require('bootstrap');

Rails.start();

import {hello} from './hello';
import $ from 'jquery';

function greet_user(last_name, first_name){
  hello(last_name +""+ first_name);
}

$(document).ready(function(){
    $('button#greet-user-button').on(
        'click',
        function(){
            greet_user('Dire', 'Strait');
        }
    );
});
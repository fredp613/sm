// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require pace.min
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require jquery.infinitescroll
//= require turbolinks
//= require_tree .



var ready;
ready = function() {

  $("#flash").fadeOut(3000); 
  $(document).foundation();  
  
}

$(document).on('page:load', ready);
$(document).ready(ready);

 $(document).on("click", "#closeModal", function() {
 	$("#modal").foundation("reveal", "close");
 	return false;
 });
 

// function toggleScroll(id, selector) {
//   $element = $(document).find('#'+id)

//   $element.infinitescroll({
 
//     navSelector  : "nav.pagination",            
//                    // selector for the paged navigation (it will be hidden)
//     nextSelector : "nav.pagination a[rel=next]",    
//                    // selector for the NEXT link (to page 2)
//     // itemSelector : '"#posts" div.post',
//     itemSelector : "#"+id + " " + "div."+selector,

//     loading: {          
//           img: '../assets/loading.gif',                              
//           finished: undefined,
//           msgText: "",
//           finishedMsg: "",
//           selector: '#loader',
//           speed: 'fast'
//     }

   
//  });
// }



// function bind_infinitescroll_user_artists() {
//  $element_artist = $('#user_artists_posts')

//   $element_artist.infinitescroll({
 
//     navSelector  : "nav.pagination",            
//                    // selector for the paged navigation (it will be hidden)
//     nextSelector : "nav.pagination a[rel=next]",    
//                    // selector for the NEXT link (to page 2)
//     itemSelector : "#user_artists_posts div.artist_post",

//     loading: {          
//           img: '../assets/loading.gif',                              
//           finished: undefined,
//           msgText: "",
//           finishedMsg: "",
//           selector: '#loader',
//           speed: 'fast'
//     }

   
//  });

// }


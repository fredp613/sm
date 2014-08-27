// $(document).on('keyup', '#search_field',submitSearchForm)
// $(document).on('click', '#btnSearch',submitSearchForm)
// // $(document).on('click', '#btnClear',clearSearchForm)


// function submitSearchForm(){
  
//   var form = $('#frmSearch')
//   var action = form.attr('action');
//   var formData = form.serialize();
//   // $.get(action, formData , null, 'script');
//   form.submit();
//   history.pushState(null, document.title, action + "?" + formData); 

//   // return false; 
// }

// function clearSearchForm(){
  
//   var form = $('#frmSearch') 
//   $("#search_field").val(null); 
//   form.submit();
//   history.pushState(null, document.title, '/');

//   return false;
   
// }




$(document).on("click", ".btnFollow", function() {
  
    var $element = $(this)

    var artist_id = $element.data("artist")
    var id = $element.attr("data-id")

    if ($(this).hasClass("following_state")) {
      
      $.ajax({
            type: "DELETE",
            url: "/user_artists/"+ $element.attr("data-id"),
            dataType: "json",
            data: {"_method":"delete"},
            success: function(data) {
              $element.text("follow");
              $element.attr("class","button radius round tiny btnFollow");
              $element.removeClass("info");
              $element.removeClass("following_state");
              $element.addClass("alert");
              $element.attr("data-id", "none");
              //console.log("deleted"); 

                  $.ajax({
                        type: "GET",
                        url: "/user_artists/user_artists_count",
                        data: { user_artist: { user_id: $(this).data("user"), artist_id: artist_id } },
                        success: function(data) {
                          //console.log(data);  
                          $(".artist_count_link").html("<a href='/user_artists/artist_index'>My Artists ("+data+")</a>") 
                                                    
                        }
                          
                   });

                   $.ajax({
                        type: "GET",
                        url: "/artists/"+ $element.attr("data-artist"),                      
                        success: function(data_artist) {
                          //console.log(data_artist);

                        var elements = $('.btnFollow[data-artist='+data_artist+']')
                          elements.each(function(i, e) {
                            element = $(this)                             
                                element.text("follow");
                                element.attr("class","button radius round tiny btnFollow");
                                element.removeClass("info");
                                element.removeClass("following_state");
                                element.addClass("alert");
                                element.attr("data-id", "none");
                               //console.log(e)                              
                          });    
                                            
                                                    
                        }
                        
                   }); 




              
             }
            
       });


    } else {
////////AJAX
      $.ajax({
            type: "POST",
            url: "/user_artists",
            data: { user_artist: { user_id: $(this).data("user"), artist_id: $(this).data("artist") } },
            success: function(data) {
              
              $element.text("following");
              $element.attr("class","button radius round tiny btnFollow");
              $element.removeClass("alert");
              $element.addClass("info");
              $element.addClass("following_state");
              $element.attr("data-id", data.id);
              //console.log("saved")

                  ////////AJAX
                  $.ajax({
                        type: "GET",
                        url: "/user_artists/user_artists_count",
                        data: { user_artist: { user_id: $(this).data("user"), artist_id: $(this).data("artist") } },
                        success: function(data_user_artist) {                          
                          //console.log(data_user_artist);  
                          $(".artist_count_link").html("<a href='/user_artists/artist_index'>My Artists ("+data_user_artist+")</a>") 
                                                    
                        }
                        
                   }); 
                  ////////AJAX  
                  $.ajax({
                      type: "GET",
                      url: "/artists/"+ $element.attr("data-artist"),                      
                      success: function(data_artist) {
                        //console.log(data_artist);

                              var elements = $('.btnFollow[data-artist='+data_artist+']')
                                elements.each(function(i, e) {
                                  element = $(this)                             
                                    element.text("following");
                                    element.attr("class","button radius round tiny btnFollow");
                                    element.removeClass("alert");
                                    element.addClass("info");
                                    element.addClass("following_state");
                                    element.attr("data-id", data.id);                         
                                });    
                                            
                                                    
                        }
                        
                   }); 
                  ////////AJAX
             }
            
       });
////////AJAX
    }
    return false;
});

$(document).on("click", ".btnFavorite", function() {
  
  // var id = $(this).attr("data-content")
  var $element = $(this)
  

  if ($(this).hasClass("favorite_state")) {
    // alert("test")
    
    var id = $element.attr("data-content")
    // var $element = $(this)
    $.ajax({
          type: "DELETE",
          url: "/user_contents/"+id,
          dataType: "json",
          data: {"_method":"delete" },
          success: function(data) {
            //console.log("deleted");
            // alert(id)
            $element.text("Add to favorites");
            $element.attr("class","button radius round tiny btnFavorite");            
            // $element.attr("style", "background-color:#43AC6A;"); 
            $element.removeClass("info");
            $element.addClass("success");           
            $element.data("content", data.content_id) 
           
           
              $.ajax({
                      type: "GET",
                      url: "/user_contents/user_contents_count",
                      data: { user_content: { user_id: $element.data("user") } },                      
                      success: function(data) {
                        //console.log(data); 
                        $(".content_count_link").html("<a href='/user_contents'>My Favorites ("+data+")</a>") 
                      }
                      
                 }); 

              

          }
          
     });

  } else {
    var id = $element.attr("data-content")
    // alert(id)
    // var $element = $(this)
    $.ajax({
          type: "POST",
          url: "/user_contents",
          data: { user_content: { user_id: $element.data("user"), content_id: $element.data("content") } },
          success: function(data) {
            //console.log("saved");
            $element.text("Saved to favorites");
            $element.attr("class","button radius round tiny favorite_state btnFavorite");            
            $element.removeClass("success");
            $element.addClass("info"); 
            $element.attr("data-content", data.id)
                         
             $.ajax({
                      type: "GET",
                      url: "/user_contents/user_contents_count",
                      data: { user_content: { user_id: $element.data("user") } },
                      success: function(data_contents) {
                        // alert(data_contents)
                        //console.log(data_contents); 
                        $(".content_count_link").html("<a href='/user_contents'>My Favorites ("+data_contents+")</a>") 
                      }
                      
                 }); 

              

          }
          
     });


  }

  return false;


  

});








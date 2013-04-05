// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery.ui.core
//= require jquery.ui.slider
//= require jquery.ui.datepicker
//= require_tree .

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
  return false;
}

$(".remove_field").live("click", function() {
  $(this).prev("input[type='hidden']").val("true");
  $(this).closest(".fields").hide();
  return false;
})



function update_content() {
    console.log("running")
    source = window.content_source ? window.content_source : "google_news"
    $.getScript("textual.js?source=" + source)
    t = setTimeout(update_content, 5000)
    window.counter++;
    console.log(window.counter)
    if(window.counter > 6 || $(".box").length > 20)  {
      clearTimeout(t)
    }
    
}

function update_images() {
    console.log("running")
    source = window.content_source ? window.content_source : "pinterest"
    $.getScript("images.js?source=" + source)
    t = setTimeout(update_images, 5000)
    window.counter++;
    console.log(window.counter)
    if(window.counter > 8 || $(".box").length > 20)  {
      // $(".img_wrap").live("click", function() {
      //         var image_location = $(this).find(".large_image_url").text()
      //         var result = image_location.match(/http:\/\/\S+(\.png|\.jpg|\.gif)/g);
      //         if (result) {
      //           $("#large_image_placeholder").attr("src", image_location).hide()
      //           setTimeout($("#img_reveal").reveal(), 500)
      //         }
      //       });
     clearTimeout(t)
    }
    
}

function update_videos() {
    console.log("running")
    source = window.content_source ? window.content_source : "youtube"
    $.getScript("videos.js?source=" + source)
    t = setTimeout(update_videos, 5000)
    window.counter++;
    console.log(window.counter)
    if(window.counter > 8 || $(".box").length > 20)  {
      // $(".img_wrap").live("click", function() {
      //         var image_location = $(this).find(".large_image_url").text()
      //         var result = image_location.match(/http:\/\/\S+(\.png|\.jpg|\.gif)/g);
      //         if (result) {
      //           $("#large_image_placeholder").attr("src", image_location).hide()
      //           setTimeout($("#img_reveal").reveal(), 500)
      //         }
      //       });
     clearTimeout(t)
    }
    
}
  
$(function()  {
  if($(".poll_text").length > 0)  {
    window.counter = 0;
    setTimeout(update_content, 5000);
  }
  
  if($(".poll_images").length > 0)  {
    window.counter = 0;
    setTimeout(update_images, 5000);
  }
  
  if($(".poll_videos").length > 0)  {
    window.counter = 0;
    setTimeout(update_videos, 5000);
  }
  
})

$(function()  {
  $(".delete_button .edit_scheduled_post").hide()
  $(".box").hover(function()  {
    $(this).find(".delete_button").fadeIn("fast");
    $(this).find(".edit_scheduled_post").fadeIn("fast");
  }, function() {
    $(this).find(".delete_button").fadeOut("fast");
    $(this).find(".edit_scheduled_post").fadeOut("fast");
  })


})
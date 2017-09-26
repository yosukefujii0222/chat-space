$(function() {

  function buildHTML(message) {
    var image_box = ""
    if (message.image != null) {
      image_box = `<img src="${message.image}">`
    }
    var html = `<div class= "chat-main__body_list--message-name">${message.user_name}</div>
                <div class= "chat-main__body_list--message-time">${message.updated_at}</div>
                <div class= "clear"></div>
                <div class= "chat-main__body_list--message-body">${message.body}</div>
                <div class= "chat-main__body_list--message-image">${ image_box }</div>`;
    return html;
  }
  function auto_scroll() {
    $(".chat-main__body").animate({scrollTop:$('.scroll_target').offset().top});
  }
  function prop_abled(data) {
    $('.send-button').prop('disabled', false);
  }
  function new_form(data) {
    $('.text_content').val('');
    $('.image_content').val('');
  }
  function append_html_to_list(html) {
    $('.chat-main__body_list--message').append(html);
  }
  $('.new_message').on('submit', function(e) {
    e.preventDefault();
    var api_url = window.location.pathname;
    var formData = new FormData(this);
    $.ajax ({
      url: api_url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
    })
    .done(function(data) {
      var html = buildHTML(data);
      append_html_to_list(html);
      new_form(data);
      prop_abled(data);
      auto_scroll();
    })
    .fail(function() {
      alert('error');
    })
  });

});



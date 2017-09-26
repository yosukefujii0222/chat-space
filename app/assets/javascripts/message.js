$(function() {
  //メッセージと画像どちらもありの場合
  function body_and_image(message) {
    var html = `<div class= "chat-main__body_list--message-name">${message.user_name}</div>
                <div class= "chat-main__body_list--message-time">${message.updated_at}</div>
                <div class= "clear"></div>
                <div class= "chat-main__body_list--message-body">${message.body}</div>
                <div class= "chat-main__body_list--message-image" src="${message.image}"></div>`;
    return html;
  }
  //メッセージだけの場合
  function only_body(message) {
    var html = `<div class= "chat-main__body_list--message-name">${message.user_name}</div>
                <div class= "chat-main__body_list--message-time">${message.updated_at}</div>
                <div class= "clear"></div>
                <div class= "chat-main__body_list--message-body">${message.body}</div>`;
    return html;
  }
  function auto_scroll() {
    var scroll_target = $('.scroll_target').offset().top;
    $(".chat-main__body").animate({scrollTop:scroll_target});
    return false;
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
      if(data.image == null) {
        var html = only_body(data);
        $('.chat-main__body_list--message').append(html);
        $('.new_message').val('');
        $('.send-button').prop('disabled', false);
        auto_scroll();
      }else {
        var html = body_and_image(data);
        $('.chat-main__body_list--message').append(html);
        $('.new_message').val('');
        $('.send-button').prop('disabled', false);
        auto_scroll();
      }
    })
    .fail(function() {
      alert('error');
    })
  });

});



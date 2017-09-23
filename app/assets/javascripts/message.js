$(function() {
  function buildHTML(message) {
    var html = `<div class= "chat-main__body_list--message-name">${message.user_name}</div>
                <div class= "chat-main__body_list--message-time">${message.updated_at}</div>
                <div class= "clear"></div>
                <div class= "chat-main__body_list--message-body">${message.body}</div>
                  <% if message.image? %>
                    <%= image_tag message.image_url(:thumb) %>
                  <% end %>`
    return html;
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
      console.log(html)
      $('.chat-main__body_list--message').append(html)
      $('.new_message').val('')
    })
    .fail(function() {
      alert('error');
    })
  })
});






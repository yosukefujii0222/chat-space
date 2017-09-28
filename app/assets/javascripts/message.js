$(function() {

  function buildHTML(message) {
    //画像がある場合にimgタグを追加する
    var image_box = ""
    if (message.image != null) {
      image_box = `<img src="${message.image}">`
    }
    //表示するメッセージのHTMLのかたまり
    var html = `<div class= "chat" data-message-id="${message.id}">
                  <div class= "chat-main__body_list--message-name">${message.user_name}</div>
                  <div class= "chat-main__body_list--message-time">${message.updated_at}</div>
                  <div class= "clear"></div>
                  <div class= "chat-main__body_list--message-body">${message.body}</div>
                  <div class= "chat-main__body_list--message-image">${ image_box }</div>
                </div>`;
    return html;
  }
  //自動スクロールの関数
  function auto_scroll() {
    $(".chat-main__body").animate({scrollTop:$('.chat:last-child').offset().top});
  }
  //投稿後、SENDボタンをリフレッシュする関数
  function prop_abled(data) {
    $('.send-button').prop('disabled', false);
  }
  //投稿後にフォームをリフレッシュする関数
  function new_form(data) {
    $('.text_content').val('');
    $('.image_content').val('');
  }
  //メッセージを一覧に追加する関数
  function append_html_to_list(html) {
    $('.chat-main__body_list--message').append(html);
  }
  //SENDを押した時に発火すること
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
  //自動更新について以下に記述
  var interval = setInterval(function() {
    if (window.location.href.match(/\/groups\/\d+\/messages/)){
    $.ajax({
      url: location.href,
      dataType: 'json',
    })
    .done(function(messages) {
      console.log(messages);
      var id = $('.chat:last-child').data('message-id');
      var insertHTML = '';
      messages.forEach(function(data) {
        if (data.id > id ) {
          insertHTML += buildHTML(data);
          $('.chat-main__body_list--message').append(insertHTML);
          auto_scroll();
        }
      });
    })
    .fail(function(data) {
      alert('自動更新に失敗しました');
    });
    } else {
    clearInterval(interval);
    }}, 5 * 1000 );
});

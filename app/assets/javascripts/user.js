$(function(){
  var search_list = $('#user-search-result');
  var add_list = $('#user-listed-result');
  //インクリメンタルサーチで取得したユーザー名を表示するhtmlブロック
  function appendUser(user){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${ user.name }</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                </div>`
    return html;
  }
  //追加されたユーザー名を表示するhtmlブロック
  function listedUser(id, name){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${ name }</p>
                  <input type="hidden" name="group[user_ids][]"  value="${ id }">
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--remove" data-user-id="${ id }" data-user-name="${ name }">削除</a>
                </div>`
    return html;
  }
  //ajax以後の記述をすべて関数で記述
  function ajax(input) {
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(users) {
      $('#user-search-result').empty();
      if (users.length !== 0) {
        users.forEach(function(user){
          var html = appendUser(user);
          search_list.append(html);
        });
      }else{
        search_list.append("<div>一致するユーザーはありません</div>");
      }
    })
    .fail(function() {
      alert('検索に失敗しました');
    });
  }

  //フォームに入力をすると発火すること
  $("#user-search-field").on("keyup", function(){
    var input = $("#user-search-field").val();
    ajax(input);
  });
  //追加を押した時の挙動
  $(document).on('click', ".chat-group-user__btn--add", function(){
    var id = $(this).attr("data-user-id");
    var username = $(this).attr("data-user-name");
    $(this).parent().remove();
    var html = listedUser(id, username);
    add_list.append(html);
  });
  //削除を押した時の挙動
  $(document).on('click', ".chat-group-user__btn--remove", function(){
    $(this).parent().remove();
  });
});

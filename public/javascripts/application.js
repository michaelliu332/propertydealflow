$(function(){

  $("body").bind("click", function (e) {
    $('a.menu').parent("li").removeClass("open");
  });

  $("a.menu").click(function (e) {
    var $li = $(this).parent("li").toggleClass('open');
    return false;
  });

  $("#tag-filter").chosen();

  $('#deal_content').keyup(update_char_counter);
  $('#deal_content').keydown(update_char_counter);
  
  function update_char_counter() {
    var text = $(this).val();
    var url_regexp = /(https?:\/\/)([\da-z\.-]+)\.([a-z]{2,6}\.?)([\/\w\.-?\[\]=\$&;#~\,\'\\%]*)*\/?/g;
    var short_url_stub = 'http://bit.ly/xxxxxx';
    var max = 140;
    
    if (text.match(url_regexp)) {
      $('.links_notice').show();
      text = text.replace(url_regexp, short_url_stub);
    } else {
      $('.links_notice').hide();
    }
    
    var textLen = text.length;
    var textLeft = max - textLen;
    $('.char_counter').text(
        textLeft
    );
    if (textLeft < 0) {
      $('#deal_submit').addClass('disabled').attr('disabled', true);
    } else {
      $('#deal_submit').removeClass('disabled').attr('disabled', false);
    }
  }

  $('#deal_content').keyup();

});
function goUrl(url){
	location.href=url;
}
$(function() {
	/*链接点击事件注册*/
	$('.result-tip-close').click(function(){
		$('.result-tip').fadeOut('slow');
	});
	// 表格鼠标行色交替
	$('tr').mouseover(function() {
		$(this).addClass('on');
	});
	$('tr').mouseout(function() {
		$(this).removeClass('on');
	});
	// 默认表现交替换色的行
	$('tr:even').addClass('even');

	/* 账号下拉菜单 */
	$('.more-tip-container').hover(function() {
		$(this).addClass('more-tip-on');
		$('#account-info').show();
		$('.more-tip-corner').removeClass('more-tip-corner-down');
		$('.more-tip-corner').addClass('more-tip-corner-up');
	}, function() {
		$(this).removeClass('more-tip-on');
		$('#account-info').hide();
		$('.more-tip-corner').removeClass('more-tip-corner-up');
		$('.more-tip-corner').addClass('more-tip-corner-down');
	});
	$('#account-info').mouseover(function() {
		$('#account-info').show();
	});
	$('#account-info').mouseout(function() {
		$('#account-info').hide();
		$(this).removeClass('more-tip-on');
		$('.more-tip-corner').removeClass('more-tip-corner-up');
		$('.more-tip-corner').addClass('more-tip-corner-down');
	});
	/*后退按钮*/
	$('.back-bt').click(function(){
		history.go(-1);
	});
});
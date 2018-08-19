$('.ProfileNav-list').remove();
window.scrollTo(0,document.body.scrollHeight);
window.scrollTo(0,document.body.scrollBottom);

//bekirbedir23@gmail.com
var i=3;

	favyap= setInterval(function()
		{
	$(".FollowStatus").parents(".js-stream-item").remove();
		if(i==4000)
		{
		  	clearInterval(favyap);
		  	clearInterval(temizle);
		  	clearInterval(asagi);
		}
			
				$('.follow-text')[i].click();
	
		i++;
		 
		},10600);


	temizle= setInterval(function()
		{
	$(".FollowStatus").parents(".js-stream-item").remove();
		
		
		},30000);

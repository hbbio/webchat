import stdlib.themes.bootstrap

type message = { string author, string text }

exposed Network.network(message) room = Network.cloud("room");

function user_update(message x) {
	line =
		<div class="row line">
			<div class="span1 columns userpic" />
    		<div class="span1 columns user">{x.author}:</>
			<div class="span13 columns message">{x.text}</>
		</div>;
	#conversation =+ line;
	Dom.scroll_to_bottom(#conversation);
}

function broadcast(x) {
	Network.broadcast(x, room);
	Dom.clear_value(#entry);
}

function main() {
	author = Random.string(4);
	send = function(_) {
		broadcast({ ~author, text: Dom.get_value(#entry) });
	};	
	<div class="topbar"><div class="fill"><div class="container">
		<div id=#logo />
	</div></div></div>
	<div id=#conversation class="container" onready={
		function(_) { Network.add_callback(user_update, room); } 
	}></div>
	<div id=#footer><div class="container">
		<input id=#entry class="xlarge" onnewline={send}/>
		<div class="btn primary" onclick={send}>Post</div>
	</div></div>
}

Server.start(
	Server.http,
	[ { resources: @static_resource_directory("resources") },
	  { register: ["resources/css.css"] },
	  { title: "Chat", page: main } ]
)

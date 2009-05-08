var BarManitto = Class.create({
	initialize: function(api_key, template_bundle_id) {
		BarManitto.instance 		= this;
		this.api_key 						= api_key;
		this.template_bundle_id = template_bundle_id;
		this.button_coffee 			= $('button-coffee');
		this.button_more_tweets = $('more-tweets');
		this.setup();
	},
	
	setup: function() {
		this.setupFacebook();
		this.setupHandlers();	
		this.setupTemplates();	
	},
	
	setupFacebook: function() {
		FB_RequireFeatures(["Api","XFBML"], function() {
			FB.Facebook.init(this.api_key, '/xd_receiver.htm');					
			this.api = FB.Facebook.apiClient;
		}.bind(this));
	},
	
	setupHandlers: function() {
		this.button_coffee.observe('click', this.buttonCoffeeClickHandler.bind(this));
		this.button_more_tweets.observe('click', this.buttonMoreTweetsClickHandler.bind(this));
	},
	
	setupTemplates: function() {
		var html = '<li><a href="#" onclick="BarManitto.instance.sendCoffee(#{uid}); return false;"><span class="picture" style="background-image: url(\'#{pic_square}\')"></span><strong>#{first_name} #{last_name}</strong></a></li>';
		this.friendTpl = new Template(html);
	},
	
	buttonCoffeeClickHandler: function(event) {
		event.stop();
		if (!this.friends) FB.Connect.requireSession(this.loadFriends.bind(this));
		Effect.toggle('friend-selector', 'blind', { duration: 0.4 });
	},
	
	buttonMoreTweetsClickHandler: function(event) {
		event.stop();
		var offset = parseInt($$('#tweets .tweet:last-child')[0].id.match(/tweet\-([0-9]+)/)[1]) + 1;
		new Ajax.Updater('tweets', '/', {
			method: 'get',
			parameters: { offset: offset },
			insertion: 'bottom',
			onLoading: function() { $('more-tweets').down('a').hide();   $('more-tweets').down('img').show(); },
			onSuccess: function() { $('more-tweets').down('img').hide(); $('more-tweets').down('a').show(); },
		});
	},
	
	loadFriends: function() {	
		var user_id = this.api.get_session().uid;
		var query = 'SELECT uid, first_name, last_name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = ' + user_id + ') order by first_name';
		FB.ensureInit(function(){
			this.api.fql_query(query, this.handleFriendsLoad.bind(this));
		}.bind(this));		
	},
	
	handleFriendsLoad: function(result, ex) {
		this.friends = result;
		$('friend-selector').removeClassName('loading');
		this.friends.each(function(friend) {
			$('friend-selector').down('ul').insert(this.friendTpl.evaluate(friend));
		}.bind(this));
	},
	
	sendCoffee: function(friend_id) {
		var data = {"images":[{"href":"http://barmanitto.com", "src":"http://barmanitto.com/images/coffee.png?v=2"}]};
		new FB.Connect.showFeedDialog(this.template_bundle_id, data, [friend_id], "", null, FB.RequireConnect.promptConnect, function(result, exception) {},
		"BarManitto", {value: "Ti offro un caffè direttamente dal bar manitto!!"});
	}
});
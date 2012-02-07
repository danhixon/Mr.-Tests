{
	collection: [
		{ _id: 14, occurred_at: new Date(2012,02,03, 13, 22), group_id: null, business_id: 2, location_id: 23, _keywords: ['mountain','goats'] },
		{ _id: 15, occurred_at: new Date(2012,02,03, 22, 00), group_id: null, business_id: 2, location_id: 23, _keywords: ['mountain','hiking'] },
		{ _id: 12, occurred_at: new Date(2012,02,03, 22, 00), group_id: null, business_id: null, location_id: 22, _keywords: ['mountain','views','views'] },
		{ _id: 11, occurred_at: new Date(2012,02,03, 18, 11), group_id: null, business_id: 2, location_id: 23, _keywords: ['mountain','spring','water','hiking'] }
	],
	expectedResults: [
		{ date: new Date(2012,02,03), group_id: null, business_id: 2, location_id: 23, value: {
			'mountain': 3,
			'goats': 1,
			'hiking': 2,
			'spring': 1,
			'water': 1} },
		{ date: new Date(2012,02,03), business_id: null, location_id: 22, group_id: null, value: {'mountain': 1 ,'views': 2} },
	],
	map: function() {
		var date = new Date( this.occurred_at.getFullYear(),
                         this.occurred_at.getMonth(),
                         this.occurred_at.getDate() );
		var k = {
			date: date,
			location_id: this.location_id,
			group_id: this.group_id,
			business_id: this.business_id
		};
		var words = {};
		this._keywords.forEach(function(r) {
			if(words[r]){
				words[r] += 1
			}
			else{
				words[r] = 1;
			}
		});
		emit(k, words);
	},
	reduce: function(key, values) {
		var words = {};
		values.forEach(function(value){
		 for( var word in value ) {
        if( words[word] ) {
          words[word] += value[word];
        } else {
          words[word] = value[word];
        }
      };
		});
		return words;
	}
}

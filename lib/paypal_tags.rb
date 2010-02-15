module PaypalTags
  include Radiant::Taggable
  
  
  desc 'Creates option list of schools'
  tag 'schools' do |tag|
	content = ""
	School.find(:all, :order => :name).each do |school|
		content << "<option value='" + school.name + "'>" + school.name + "</option>\n"
	end
	content
  end
  
  
  desc 'Creates a Paypal form'
  tag 'paypal' do |tag|
  	content = "<script type='text/javascript'>
  		<!--
		var prices = [];
		var schoolsPrices = [];
  		"
  	prices = PriceOption.find(:all, :order => :value)
  	for price in prices
  		content << "prices[" + price.id.to_s + "] = '" + price.title + " - $" + price.value.to_s + "';\n"
  	end
  		
	program = tag.attr['program'] or "peewee"
	schools = School.find_all_by_program(program, :order => :name, :include => :price_options)
	schoolIndex = 0
	for school in schools
		content << "schoolsPrices[" + schoolIndex.to_s + "] = [" + school.price_option_ids.join(", ").to_s + "];\n" 	
		schoolIndex += 1
	end
	
	
  	content << "
  		function updatePrices() {
			var schoolIndex = document.payment.os1.selectedIndex;
			var schoolPrices = schoolsPrices[schoolIndex];
			
			var priceList = document.payment.os0;
			priceList.innerHTML = '';
			for (var i = 0; i < schoolPrices.length; i++) {
				var priceText = prices[schoolPrices[i]];
				//priceList.innerHTML = priceList.innerHTML + \"<option value='\" + priceText + \"'>\" + priceText + '</option>\\n';
				var el = document.createElement('option');
				el.setAttribute('value', priceText);
				//el.setAttribute('onclick', 'updateTotal();');
				var text = document.createTextNode(priceText);
				el.appendChild(text);
				priceList.appendChild(el);
			}
			
			updateTotal();
		}
		
		function updateTotal() {
			// this.form.amount.value = this.options[this.selectedIndex].innerHTML.split('$', 2)[1]
			var payform = document.payment;
			var priceSelect = payform.os0;
			if (priceSelect.childNodes.length > 0) {
				var priceSplit = priceSelect.options[priceSelect.selectedIndex].innerHTML.split('$');
				if (priceSplit.length == 2) {
					payform.amount.value = priceSplit[1];
					//payform.elements('amount').value = priceSplit[1];
				}
			}
		}
  		//-->
  		</script>
  		<form name='payment' action='https://www.paypal.com/cgi-bin/webscr' method='post'>
  			<div id='payment1'>
				<input type='hidden' name='cmd' value='_xclick' />
				<input type='hidden' name='business' value='peeweesportsandfitness@comcast.net' />
				<input type='hidden' name='currency_code' value='USD' />
				<input type='hidden' name='item_name' value='PeeWee Sports and Fitness Registration' />
				<input type='hidden' name='image_url' value='http://www.peeweesportsandfitness.com/images/logo.png' />
				<input type='hidden' name='return' value='http://www.peeweesportsandfitness.com' />
				<input type='hidden' name='cancel_return' value='http://www.peeweesportsandfitness.com/pay' />				
				<input type='hidden' name='on3' value=\"Child's Name\" />Child's Name<br /> 
				<input type='text' name='os3' maxlength='60' /><br />
				<br />
				<input type='hidden' name='on1' value='School' />School<br />
				<select name='os1'>"
	for school in schools
		content << "<option value=\"" + school.name + "\">" + school.name + "</option>\n"
	end
	content << "</select><br />
				<br />
				<a href='#' onclick=\"updatePrices(); document.getElementById('payment2').style.display = ''; document.getElementById('payment1').style.display = 'none';\">Continue</a>
			</div>
			<div id='payment2' style='display:none;'>
				<input type='hidden' name='on0' value='Duration' />Duration<br />
				<select id='prices' name='os0'>
				</select><br />
				<br />
				<input type='hidden' name='on2' value='Shirt size' />Shirt size<br />
				<select name='os2'>
					<option value='Small'>Small</option>
					<option value='Medium'>Medium</option>
					<option value='Large'>Large</option>
				</select><br />
				<br />
				<input type='hidden' name='currency_code' value='USD' />
				<input type='hidden' id='amount' name='amount' value='9'/>
				<input type='image' onclick='updateTotal();' src='https://www.paypal.com/en_US/i/btn/btn_paynowCC_LG.gif' border='0' name='submit' alt='Pay Now using Paypal' />
				<img alt='' border='0' src='https://www.paypal.com/en_US/i/scr/pixel.gif' width='1px' height='1px' />
				<a href='#' onclick=\"document.getElementById('payment1').style.display = ''; document.getElementById('payment2').style.display = 'none';\">Back</a>
			</div>
		</form>
		
		<br />
		<br />
		Having trouble?  You can print and mail the PDF registration form from <a href='/pwsf_tabloid_registration_form.pdf'>here</a>.
		"

  	
  	content
  end
end
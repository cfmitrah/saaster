
function sweetAlert(type, thisURL, textOne, textTwo, buttonOne, buttonTwo) {

	if (type == "warning") {
		dangerMode = true;
	} else {
		dangerMode = false;
	}

	if (buttonOne != '' && buttonTwo != '') {

		swal({
			title: textOne,
			text: textTwo,
			icon: type,
			buttons: [buttonOne, buttonTwo],
			dangerMode: dangerMode,
		})
		.then((willDelete) => {
			if (willDelete) {
				window.location.href = thisURL;
			};
			/* refreshThings(); */
		});

	} else {

		swal({
			title: textOne,
			text: textTwo,
			icon: type
		/* }).then(function(){
			refreshThings(); */
		});

	}

};

function refreshThings(){
	$('a.plan').each(function(i, obj) {
		$(this).text(obj.text);
		$(this).removeClass('disabled');
	});
}

// Save payment
function sendPayment() {
	var paymentModal = $('#dyn_modal-content');
	var formData = $("#sendPayment").serialize();
	var formAction = $("#sendPayment").attr("action");
	var formReturn = $("#sendPayment").data("return");
	$.ajax({
		type: "POST",
		url: formAction,
		data: formData,
		success: function (){
			paymentModal.load(formReturn);
		}
	});
}

// Delete payment
function deletePayment(paymentID) {

	var paymentModal = $('#dyn_modal-content');
	var formData = 'delete=' + paymentID;
	var formAction = $("#sendPayment").attr("action");
	var formReturn = $("#sendPayment").data("return");
	$.ajax({
		type: "POST",
		url: formAction,
		data: formData,
		success: function(){
			paymentModal.load(formReturn);
		}
	});
}

// for invoices (sysadmin)
function showResult(str) {
	if (str.length==0) {
		document.getElementById("livesearch").innerHTML="";
		return;
	}
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function() {
		if (this.readyState==4 && this.status==200) {
			document.getElementById("livesearch").innerHTML=this.responseText;
		}
	}
	xmlhttp.open("GET","/views/sysadmin/ajax_search_customer.cfm?search="+str,true);
	xmlhttp.send();
}
function intoTf(c, i) {
	var customer_name = document.getElementById("searchfield");
	customer_name.value = c;
	var customer_id = document.getElementById("customer_id");
	customer_id.value = i;
}
function hideResult() {
	document.getElementById("livesearch").innerHTML="";
	return;
}


$(document).ready(function(){

	$('#dragndrop_body').sortable({
		handle: ".move",
		start: function (event, ui) {
			if (navigator.userAgent.toLowerCase().match(/firefoxy/) && ui.helper !== undefined) {
				alert('ff');
				ui.helper.css('position', 'absolute').css('margin-top', $(window).scrollTop());
				//wire up event that changes the margin whenever the window scrolls.
				$(window).bind('scroll.sortableplaylist', function () {
					ui.helper.css('position', 'absolute').css('margin-top', $(window).scrollTop());
				});
			}
		},
		beforeStop: function (event, ui) {
			if (navigator.userAgent.toLowerCase().match(/firefoxy/) && ui.offset !== undefined) {
				$(window).unbind('scroll.sortableplaylist');
				ui.helper.css('margin-top', 0);
			}
		},
		helper: function (e, ui) {
		ui.children().each(function () {
			$(this).width($(this).width());
		});
		return ui;
		},
		scroll: true,
		stop: function (event, ui) {
			fnSaveSort();
		}
	});


	$(".hand").mouseup(function(){
		$(".hand").css( "cursor","grab");
	}).mousedown(function(){
		$(".hand").css( "cursor","grabbing");
	});


	$("#checkAll").change(function () {
		$("input:checkbox").prop('checked', $(this).prop("checked"));
	});
	$('#checkall tr').click(function(event) {
		if (event.target.type !== 'checkbox') {
			$(':checkbox', this).trigger('click');
		}
	});


	// load modal with dynamic content (general)
	$('.openPopup').on('click',function(){
		var dataURL = $(this).attr('data-href');
		$('#dyn_modal-content').load(dataURL,function(){
			$('#dynModal').modal('show');
		});
	});

	// load modal with dynamic content for payments
	$('.openPopupPayments').on('click',function(){
		var dataURL = $(this).attr('data-href');
		$('#dyn_modal-content').load(dataURL,function(){
			$('#dynModalPayments').modal('show');
			window.Litepicker && (new Litepicker({
				element: document.getElementById('payment_date'),
				buttonText: {
					previousMonth: `<i class="fas fa-angle-left" style="cursor: pointer;"></i>`,
					nextMonth: `<i class="fas fa-angle-right" style="cursor: pointer;"></i>`,
				},
			}));
		});
	});

	// Load trumbowyg editor
	$('.editor').each(function(index, element){
		var $this = $(element);
		$this.trumbowyg({
			btns: [
				['viewHTML'], ['bold', 'italic'], ['link'], ['formatting'], ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'], ['unorderedList', 'orderedList']
			]
		});
	});

	// Change plan prices
	$('.radio-toggle').toggleInput();
	$('.form-check-label').click(function() {
		if ($(this).hasClass("yearly")) {
			$(".price_box.yearly").show();
			$(".price_box.monthly").hide();
		}
		else if ($(this).hasClass("monthly")){
			$(".price_box.yearly").hide();
			$(".price_box.monthly").show();
		}
	});

	// Picture upload field
	$('.dropify').dropify();

	$("#submit_form").submit(function () {
		$("#submit_button").attr("disabled", true).addClass("not-allowed");
		return true;
	});


	//Dashboard widget sorting
	$('div.dashboard').sortable({
		handle: '.move-widget',
		tolerance: 'pointer',
		placeholder: 'widget-placeholder',
		start: function(event, ui ){
			var classes = ui.item.attr('class').split(/\s+/);
			for(var x=0; x<classes.length; x++){
			  	if (classes[x].indexOf("col") > -1){
					ui.placeholder.addClass(classes[x]);
				}
			}
			ui.placeholder.css({
				width: ui.item.innerWidth() - 30 + 1,
				height: ui.item.innerHeight() - 15 + 1,
				padding: ui.item.css("padding")
			});
	   	},
		stop: function(event, ui) {
			$.post('/dashboard-settings', {sortorder:$(this).sortable('serialize')});
		}
	}).disableSelection();

	$('.disable-widget').on('change', function(){

		var $isvisible = $(this).closest('div.card-header').find('span.isvisible');
		var $isinvisible = $(this).closest('div.card-header').find('span.isinvisible');
		var $targetWidget = $(this).closest('div.card').find('div.card-body');

		if( $(this).prop('checked') ){
			$.post('/dashboard-settings', {action:'disable', id:$(this).val(), active:1}, function(){
				$targetWidget.removeClass('widget-disabled');
				$isinvisible.hide();
				$isvisible.show();
			});
		}else{
			$.post('/dashboard-settings', {action:'disable', id:$(this).val(), active:0}, function(){
				$targetWidget.addClass('widget-disabled');
				$isvisible.hide();
				$isinvisible.show();
			});
		}
	});


	//Plans+Process overview, disable buttons when changing plan
	/* $('a.plan').on('click', function(){

		$('a.plan').each(function(i, obj) {
			$(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>&nbsp;' + obj.text);
			$(this).addClass('disabled');
		});

	}); */


	$('.plan_edit').on('click', function(){

		var plan_id = $(this).val();
		var recurring = '';

		$('.plan_recurring').each(function(){
			if( $(this).prop('checked') ){
				recurring = $(this).val();
			}
		});

		if(recurring == ''){
			$(".plan_recurring[value='monthly']").prop('checked', true);
			recurring = 'monthly';
		}

		$('#change_plan').load('/includes/plan_calc.cfm?plan_id=' + plan_id + '&recurring=' + recurring);

	});

	$('.plan_recurring').on('click', function(){

		var plan_id;
		var recurring = $(this).val();


		$('.plan_edit').each(function(){
			if( $(this).prop('checked') ){
				plan_id = $(this).val();
			}
		});

		$('#change_plan').load('/includes/plan_calc.cfm?plan_id=' + plan_id + '&recurring=' + recurring);


	});


});
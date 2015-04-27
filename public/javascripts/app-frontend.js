/**
 * Created by kuby on 15-4-1.
 */
$(function () {
  /** Frontend login **/
  $("input#frontLogin").on('click', function (e) {
    e.preventDefault();
    $("div.login-box div.bg-danger").addClass('hidden').text('');
    var form_data = $("form#frontLoginForm").serialize();
    $("img#ajaxLoader").removeClass('hidden');

    $.post('/tech/accounts/login/', form_data, function (response) {
      var obj = jQuery.parseJSON(response);
      if (typeof obj.login_error != "undefined") {
        $("div.login-box div.bg-danger").removeClass('hidden').text(obj.login_error);
        $("input#frontLogin").removeAttr('disabled');
      }
      if (obj.login_success == true) {
        window.location = obj.redirect_url;
      }
      $("img#ajaxLoader").addClass('hidden');
    });
  });
  /** Frontend register **/
  $("input#regStep1").on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $("img#ajaxLoader").removeClass('hidden');

    $("div.register-box div.bg-danger").addClass('hidden').html('');
    $("div.register-box div.bg-success").addClass('hidden').html('');
    $('div.val_error').remove();

    var username = $('input[name="username"]').val();
    var username_lower = $('input[name="username"]').val().toLowerCase();
    var username_confirm = $('input[name="username_confirm"]').val();

    var email = $('input[name="email"]').val();
    var email_confirm = $('input[name="email_confirm"]').val();

    var form_data = $("form#frontRegisterForm").serialize();
    var error_prefix = '<div class="val_error">';
    var error_suffix = '</div>';
    if (!$('input[name="over_18"]').is(':checked')) {
      $("div.accOver18").append(error_prefix + over_18_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (!$('input[name="privacy"]').is(':checked')) {
      $("div.Privacy").append(error_prefix + tac_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username == '' || username_confirm == '' || email == '' || email_confirm == '') {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(req_fields_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username.indexOf(' ') >= 0) {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(username_two_char_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username_lower == 'join' || username_lower == 'joinnow' || username_lower == 'signup' || username_lower == 'corporate' || username_lower == 'nigel' || username_lower == 'sebastian' || username_lower == 'infosignupnow' || username_lower == 'scam' || username_lower == 'scamscam' || username_lower == 'fuckyou' || username_lower == 'official' || username_lower == 'company' || username_lower == 'rouja') {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(choose_another_username_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username != username_confirm) {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(user_confirm_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (email != email_confirm) {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(email_confirm_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else {
      $.post('/tech/accounts/registerStep1/', form_data, function (response) {
        console.log(form_data);
        var obj = $.parseJSON(response);

        if (typeof obj.account_success_saved != "undefined") {
          $("div.register-box div.bg-success").removeClass('hidden').append('<h4>' + obj.account_success_saved + '</h4>');
          $("div.register-box div.VerifNotRecieved").removeClass('hidden');
          $("div.register-box div.reg-box").addClass('hidden');
          $('input[type="text"]').val('');
        }
        if (typeof obj.errors != "undefined") {
          if (typeof obj.errors.empty_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.empty_email + error_suffix);
          }
          if (typeof obj.errors.invalid_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.invalid_email + error_suffix);
          }

          if (typeof obj.errors.not_unique_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.not_unique_email + error_suffix);
          }

          if (typeof obj.errors.empty_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.empty_username + error_suffix);
          }

          if (typeof obj.errors.not_unique_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.not_unique_username + error_suffix);
          }
          if (typeof obj.errors.invalid_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.invalid_username + error_suffix);
          }
        }
        $("img#ajaxLoader").addClass('hidden');

      });
    }
    $("input#regStep1").removeAttr('disabled');

  });

  $("input#regStep2").on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $("img#ajaxLoader").removeClass('hidden');

    $("div.register-box div.bg-danger").addClass('hidden').html('');
    $("div.register-box div.bg-success").addClass('hidden').html('');
    $('div.val_error').remove();

    var form_data = $("form#frontRegFormStep2").serialize();
    var error_prefix = '<div class="val_error">';
    var error_suffix = '</div>';

    var password = $("form#frontRegFormStep2 input[name='password']").val();
    var transaction_password = $("form#frontRegFormStep2 input[name='transaction_password']").val();
    var confirm_password = $("form#frontRegFormStep2 input[name='confirm_password']").val();
    var confirm_transaction_password = $("form#frontRegFormStep2 input[name='confirm_transaction_password']").val();

    if (password === '' && confirm_password === '' && transaction_password === '' && confirm_transaction_password === '') {
      $("div.regStep2Messages div.bg-danger").removeClass('hidden').html(empty_pwd_error);
      $("img#ajaxLoader").addClass('hidden');
      $("input#regStep2").removeAttr('disabled');
    } else if (password === transaction_password) {
      $("div.regStep2Messages div.bg-danger").removeClass('hidden').html(same_pwd_error);
      $("img#ajaxLoader").addClass('hidden');
      $("input#regStep2").removeAttr('disabled');
    } else {
      $.post('/tech/accounts/registerStep2/', form_data, function (response) {
        var obj = $.parseJSON(response);

        if (typeof obj.account_success_saved != "undefined") {
          window.location = obj.redirect_url;

        }
        if (typeof obj.errors != "undefined") {
          if (typeof obj.errors.empty_password != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.empty_password + error_suffix);
          }
          if (typeof obj.errors.not_matching_password != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.not_matching_password + error_suffix);
          }
          if (typeof obj.errors.password_too_weak != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.password_too_weak + error_suffix);
          }
          if (typeof obj.errors.password_too_short != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.password_too_short + error_suffix);
          }
          if (typeof obj.errors.empty_transaction_password != "undefined") {
            $("div.accTransactionPassword").append(error_prefix + obj.errors.empty_transaction_password + error_suffix);
          }
          if (typeof obj.errors.not_matching_transaction_password != "undefined") {
            $("div.accTransactionPassword").append(error_prefix + obj.errors.not_matching_transaction_password + error_suffix);
          }
        }
        $("img#ajaxLoader").addClass('hidden');

      });
      $("input#regStep2").removeAttr('disabled');
    }

  });

  $("input#regStep3").on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $("img#ajaxLoader").removeClass('hidden');

    $("div.register-box div.bg-danger").addClass('hidden').html('');
    $("div.register-box div.bg-success").addClass('hidden').html('');
    $('div.val_error').remove();

    var form_data = $("form#frontRegFormStep3").serialize();
    var error_prefix = '<div class="val_error">';
    var error_suffix = '</div>';

    var mobile = $('input[name="mobile"]').val();
    if (mobile.length < 9) {
      $("div.accMobile").append(error_prefix + mobile_error + error_suffix);
      $("input#regStep3").removeAttr('disabled');
      $("img#ajaxLoader").addClass('hidden');
    } else {
      $.post('/tech/accounts/registerStep3/', form_data, function (response) {
        var obj = $.parseJSON(response);
        if (typeof obj.redirect_url != "undefined") {
          window.location = obj.redirect_url;
        }
        if (typeof obj.errors != "undefined") {
          if (typeof obj.errors.empty_first_name != "undefined") {
            $("div.accFirstName").append(error_prefix + obj.errors.empty_first_name + error_suffix);
          }
          if (typeof obj.errors.empty_last_name != "undefined") {
            $("div.accLastName").append(error_prefix + obj.errors.empty_last_name + error_suffix);
          }
          if (typeof obj.errors.empty_country != "undefined") {
            $("div.accCountry").append(error_prefix + obj.errors.empty_country + error_suffix);
          }
          if (typeof obj.errors.empty_mobile != "undefined") {
            $("div.accMobile").append(error_prefix + obj.errors.empty_mobile + error_suffix);
          }
          if (typeof obj.errors.invalid_mobile != "undefined") {
            $("div.accMobile").append(error_prefix + obj.errors.invalid_mobile + error_suffix);
          }
        }
        $("img#ajaxLoader").addClass('hidden');
      });
      $("input#regStep3").removeAttr('disabled');
    }
  });

  //scrollTo
  $('ul#frontMenu li a.scroll-item').on('click', function (e) {
    e.preventDefault();
    var linkHref = $(this).attr('href');
    var url = linkHref.split("#");
    var scroll_to = '';
    if (url[1] == 'top') {
      scroll_to = 'body#' + url[1];
    } else {
      scroll_to = 'div#' + url[1];
    }
    var link = $(scroll_to);
    $('body').scrollTo(link, {
      duration: 1000,
      offset: {
        top: 0
      }
    });
  });

  //Sign up newsletter
  $('input#newsletterBtn').on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $("img#ajaxLoader").removeClass('hidden');

    $("div.newsletterForm div.bg-success").addClass('hidden').html('');
    $('div.val_error').remove();

    var form_data = $("form#frontNewsletterForm").serialize();
    var error_prefix = '<div class="val_error">';
    var error_suffix = '</div>';
    if (!$('input[name="terms"]').is(':checked')) {
      //$("div.nltrTerms").append(error_prefix + tac_error + error_suffix);
      $("div.nltrPriv").append(error_prefix + tac_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $("input#newsletterBtn").removeAttr('disabled');
    } else if (!$('input[name="privacy"]').is(':checked')) {
      $("div.nltrPriv").append(error_prefix + tac_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $("input#newsletterBtn").removeAttr('disabled');
    } else {
      $.post('/tech/newsletter/signup/', form_data, function (response) {
        var obj = $.parseJSON(response);
        if (typeof obj.success_signup != 'undefined') {
          $("div.newsletterForm div.bg-success").removeClass('hidden').html(obj.success_signup);
          $("img#ajaxLoader").addClass('hidden');
          $("input#newsletterBtn").removeAttr('disabled');
          $("input[type='text']").val('');
        }
        if (typeof obj.errors != 'undefined') {
          if (typeof obj.errors.name != 'undefined') {
            $('div.nltrName').append(error_prefix + obj.errors.name + error_suffix);
          }
          if (typeof obj.errors.email != 'undefined') {
            $('div.nltrEmail').append(error_prefix + obj.errors.email + error_suffix);
          }
        }
        $("img#ajaxLoader").addClass('hidden');
        $("input#newsletterBtn").removeAttr('disabled');
      });
    }
  });

  //change video container height
  if ($("div.regContVideo").length > 0) {
    var reg_box_height = $('div.register-box').height();
    var video_height = reg_box_height - 37;
    $("div.regContVideo").css('height', reg_box_height);
  }

  //forntend counter
  if ($("div#joinedPeople").length > 0) {
    var myCounter = new flipCounter("counter", {pace: 800, auto: false});

    makeCounter(myCounter);
  }

  //Payment Form

  // Hide Inputs
  $('#registration_gift_code_input').hide();
  $('#packet_gift_code_input').hide();

  // Show Registration Gift Code Input
  $('#registration_gift_code_radio').click(function () {
    $('#registration_gift_code_input').show();
  });

  // Hide Registration Gift Code Input
  $('#registration_fee_radio').click(function () {
    $('#registration_gift_code_input').hide();
  });

  // Show Packet Gift Code Input
  $('#packet_gift_code_radio').click(function () {
    $('#packet_gift_code_input').show();
  });

  // Hide Packet Gift Code Input
  $('input[class=packet]').click(function () {
    $('#packet_gift_code_input').hide();
  });

  //registration pay with One Payment

  var packet_val = $("input[name='packet']:checked").val();
  var total_amount = $("input[name='price_" + packet_val + "']").val();
  $('span#total_amount').html(total_amount);

  $("input[name='packet']").on('change', function () {
    packet_val = $("input[name='packet']:checked").val();
    total_amount = $("input[name='price_" + packet_val + "']").val();
    $('span#total_amount').html(total_amount);

  });
  $('input#payReg').on('click', function (e) {
    e.preventDefault();
    $('div.bg-success').addClass('hidden');
    $('div.bg-success').html('');
    $('div.payErrors.bg-danger').addClass('hidden');
    $('div.payErrors.bg-danger').html('');

    var selected_packet = $('input[name="packet"]:checked').val();
    var selected_payment = $('select[name="payment_method"]').val();
    if (typeof selected_packet == 'undefined') {
      $('div.payErrors.bg-danger').removeClass('hidden');
      $('div.payErrors.bg-danger').html(select_packet);
    }else if(selected_packet==21){
      $('div.payErrors.bg-danger').removeClass('hidden');
      $('div.payErrors.bg-danger').html(select_package);
    } else if (selected_payment == '') {
      $('div.payErrors.bg-danger').removeClass('hidden');
      $('div.payErrors.bg-danger').html(select_payment_method);
    } else {
      var form_data = $('form#frontPayForm').serialize();
      if (selected_payment == 'onepayment') {
        $.post('/tech/payments/addPaymentsLog', form_data, function (response) {
          var obj = $.parseJSON(response);

          if (obj.success == true) {
            $('#onePaymentModal').modal('toggle');
            if (typeof obj.data != 'undefined') {
              $('#payLogData input[name="log_id"]').val(obj.data.id);
              $('#payLogData input[name="pl_customer_id"]').val(obj.data.customer_id);
              $('#payLogData input[name="pl_amount"]').val();
            }
          }
          if (typeof obj.errors != 'undefined') {
            $('div.payErrors.bg-danger').removeClass('hidden');
            $('div.payErrors.bg-danger').html(payment_log_error);
          }

        });
      } else if (selected_payment == 'bank') {
        $.post('/tech/payments/addPaymentsLog', form_data, function (response) {
          var obj = $.parseJSON(response);

          if (obj.success == true) {
            $('#bankModal').modal('toggle');
            if (typeof obj.data != 'undefined') {
              $('#bWForm input[name="amount"]').val(obj.data.amount);
              $('#bWForm input[name="amount_no_tax"]').val(obj.data.amount);
              $('#bWForm div.bw_payment span').html(obj.data.amount);

              var selected = $('form#bWForm select#bwCountry').val();
              var amount = $("form#bWForm input[name='amount_no_tax']").val();
              if (selected != '' && selected != 'bg') {
                var temp_amount = parseFloat(amount) * 3.5 / 100;
                var calc_amount = parseFloat(temp_amount) + parseFloat(amount);
                $("form#bWForm input[name='amount']").val(calc_amount);
                $("div.bw_payment span").html(calc_amount);
              } else {
                $("form#bWForm input[name='amount']").val(amount);
                $("div.bw_payment span").html(amount);
              }
            }
          }
          if (typeof obj.errors != 'undefined') {
            $('div.bg-danger').removeClass('hidden');
            $('div.bg-danger').html(payment_log_error);
          }

        });
      } else if (selected_payment == 'perfect_money') {
        $.post('/tech/payments/addPaymentsLog', form_data, function (response) {
          var obj = $.parseJSON(response);

          if (obj.success == true) {
            $('#perfectMoneyModal').modal('toggle');
            if (typeof obj.data != 'undefined') {

              $('#perfectMoneyPayForm input[name="PAYMENT_ID"]').val(obj.data.id);
              $('#perfectMoneyPayForm input[name="CUSTOMER"]').val(obj.data.customer_id);
              $('#perfectMoneyPayForm input[name="PACKAGE"]').val(obj.data.packet_id);
              $('#perfectMoneyPayForm input[name="PAYMENT_AMOUNT"]').val(obj.data.amount);
              $('div#pmPaymentCont span').html('').append(obj.data.amount);
            }
          }
          if (typeof obj.errors != 'undefined') {
            $('div.payErrors.bg-danger').removeClass('hidden');
            $('div.payErrors.bg-danger').html(payment_log_error);
          }

        });
      }else if(selected_payment == 'credit_card'){
        if(selected_packet==5 ||selected_packet == 6){
          $('div.payErrors.bg-danger').removeClass('hidden');
          $('div.payErrors.bg-danger').html(cc_error_packages);
        }else{
          $.post('/tech/cc_payments/calculatePrice', form_data, function (response) {
            var obj = $.parseJSON(response);
            if (typeof obj.error != 'undefined') {
              $('div.payErrors.bg-danger').removeClass('hidden');
              $('div.payErrors.bg-danger').html(obj.error);
            }
            if (typeof obj.success != 'undefined') {
              if (typeof obj.data != 'undefined') {
                $('#ccPaymentModal input[name="cc_customer_id"]').val(obj.data.customer_id);
                $('#ccPaymentModal input[name="cc_amount"]').val(obj.data.amount);
                $('#ccPaymentModal input[name="cc_amount_temp"]').val(obj.data.amount_temp);
                $('#ccPaymentModal input[name="cc_calc_fee"]').val(obj.data.calc_fee);
                $('#ccPaymentModal input[name="cc_package_id"]').val(obj.data.package_id);
                $('#ccPaymentModal input[name="cc_type"]').val(obj.data.type);
                $('#ccPaymentModal input[name="cc_description"]').val(obj.data.description);
                $('#ccPaymentModal input[name="cc_other_amount"]').val(obj.data.other_amount);
                $('#ccPaymentModal input[name="cc_currency_rate"]').val(obj.data.currency_rate);
                $('#ccPaymentModal input[name="cc_currency_code"]').val(obj.data.currency_code);
                $('div#ccPaymentContBgn span').html(obj.data.amount_bgn);
                if(obj.data.other_amount >0){
                  $('div#ccPaymentCont span.pay_amount').html(obj.data.other_amount);
                }else{
                  $('div#ccPaymentCont span.pay_amount').html(obj.data.amount);
                }
                $('div#ccPaymentCont span.pay_amount_currency').html(obj.data.currency_code);
              }
              $('#ccPaymentModal').modal('toggle');
            }
          });
        }
      }else if(selected_payment == 'china_union_pay'){
        $('div.cuError.bg-danger').addClass('hidden').html('');
        $('div.cuSuccess.bg-success').addClass('hidden').html('');
        $.post('/tech/cu_payments/calculatePrice', form_data, function (response) {
          var obj = $.parseJSON(response);
          if (typeof obj.error != 'undefined') {
            $('div.cuError.bg-danger').removeClass('hidden');
            $('div.cuError.bg-danger').html(obj.error);
          }
          if (typeof obj.data != 'undefined') {
            $("div#cuPaymentModal div#cuPaymentContEur span.pay_amount").html(obj.data.price_eur);
            $("div#cuPaymentModal div#cuPaymentContUsd span.pay_amount").html(obj.data.price_usd);

            $("form#chinaUnionForm input[name='tax']").val(obj.data.tax);
            $("form#chinaUnionForm input[name='currency_rate']").val(obj.data.currency_rate);
            $("form#chinaUnionForm input[name='price_eur']").val(obj.data.price_eur);
            $("form#chinaUnionForm input[name='price_usd']").val(obj.data.price_usd);
            $("form#chinaUnionForm input[name='package']").val(obj.data.package);
            $("form#chinaUnionForm input[name='customer_id']").val(obj.data.customer_id);
            $("form#chinaUnionForm input[name='payment_type']").val(obj.data.payment_type);

            //display modal window
            $('#cuPaymentModal').modal('toggle');
          }
        });

      }
    }
  });

  $('input[name=packet]').on('click', function () {
    if ($(this).val() != 21) {
      $('input[name=packet][value=21]').attr('name', 'packet_mod');
      $('input[name=packet_mod][value=21]').prop('checked', true);
    }
  });
  $('input[type=radio]').on('click', function () {
    if ($(this).val() == 21) {
      $(this).attr('name', 'packet');
    }
  });


  // Forgot Password - Hide Login Form
  $("a#forgot-password").on('click', function (e) {
    e.preventDefault();
    $("div.login-box div.bg-danger").empty().addClass('hidden');
    $('#loginModal').find('button.close').trigger('click');
  });

  $('button.close').click(function () {
    $("div.login-box div.bg-danger").addClass('hidden').text('');
    $("div.login-box div.bg-success").addClass('hidden').text('');
  });

  // Forgot Password
  $("input#forgPass").on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');

    $("div.login-box div.bg-danger").addClass('hidden').text('');

    var email = $('input[name="change_pass_email"]').val();
    var username = $('input[name="change_pass_username"]').val();

    $("img#ajaxLoader").removeClass('hidden');

    if (email != '' && username != '') {
      if (validateEmail(email)) {
        $.post('/tech/profile/changePasswordStep1', {email: email, username: username}, function (response) {
          var obj = $.parseJSON(response);

          if (typeof obj.error != "undefined") {
            $("div.login-box div.bg-danger").removeClass('hidden').text(obj.error);
            $("input#forgPass").removeAttr('disabled', 'disabled');
          }

          if (typeof obj.success != "undefined") {
            $("div.login-box div.bg-success").removeClass('hidden').text(obj.success);
            $("input#forgPass").removeAttr('disabled', 'disabled');
          }

          $("img#ajaxLoader").addClass('hidden');
        });
      } else {
        $("div.login-box div.bg-danger").removeClass('hidden').text('Email is not correct.');
        $("input#forgPass").removeAttr('disabled', 'disabled');
        $("img#ajaxLoader").addClass('hidden');
      }
    } else {
      $("div.login-box div.bg-danger").removeClass('hidden').text('Fill all fields.');
      $("input#forgPass").removeAttr('disabled', 'disabled');
      $("img#ajaxLoader").addClass('hidden');
    }

  });

  $("input#sendVerCodeBtn").on('click', function (e) {
    e.preventDefault();
    $("img#ajaxLoader").removeClass('hidden');
    $(this).attr('disabled', 'disabled');
    $("div#verCodeModal div.frontForms div.bg-danger").addClass('hidden');
    $("div#verCodeModal div.frontForms div.bg-success").addClass('hidden');

    var form_data = $("form#frontSendVerCodeForm").serialize();
    var username_field = $("input[name='ver_code_username']").val();

    if (username_field == '') {
      $("div#verCodeModal div.frontForms div.bg-danger").removeClass('hidden').text(req_username);
      $("img#ajaxLoader").addClass('hidden');
      $("input#sendVerCodeBtn").removeAttr('disabled');
    } else {
      $.post('/tech/accounts/sendVerEmail/', form_data, function (response) {
        var obj = jQuery.parseJSON(response);
        if (typeof obj.error != "undefined") {
          $("div#verCodeModal div.frontForms div.bg-danger").removeClass('hidden').text(obj.error);
        }
        if (typeof obj.success != "undefined") {
          $("div#verCodeModal div.frontForms div.bg-success").removeClass('hidden').text(obj.success);
        }
        $("img#ajaxLoader").addClass('hidden');
        $("input#sendVerCodeBtn").removeAttr('disabled');
      });
    }
  });

  $("select#bwCountry").on('change', function () {
    var selected = $(this).val();
    var amount = $("form#bWForm input[name='amount_no_tax']").val();
    if (selected != '' && selected != 'bg') {
      var temp_amount = parseFloat(amount) * 3.5 / 100;
      var calc_amount = parseFloat(temp_amount) + parseFloat(amount);
      $("form#bWForm input[name='amount']").val(calc_amount);
      $("div.bw_payment span").html(calc_amount);
    } else {
      $("form#bWForm input[name='amount']").val(amount);
      $("div.bw_payment span").html(amount);
    }
  });
  $("input#bWForm").on('click', function (e) {
    e.preventDefault();
    $("div#bankModal div.bg-danger").addClass('hidden').html('');
    var country = $("form#bWForm select[name='country']").val();
    var first_name = $("form#bWForm input[name='firstname']").val();
    var last_name = $("form#bWForm input[name='lastname']").val();
    var email = $("form#bWForm input[name='email']").val();
    var amount = $("form#bWForm input[name='amount']").val();
    if (country == '' || first_name == '' || last_name == '' || email == '' || amount == '') {
      $("div#bankModal div.bg-danger").removeClass('hidden').html(bw_requred_fields);
    } else if (!validateEmail(email)) {
      $("div#bankModal div.bg-danger").removeClass('hidden').html(bw_invalid_email);
    } else {
      $("form#bWForm").submit();
    }
  });

  $('input.captcha_input').val('');
  $("input#regOneStep").on('click', function (e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $("img#ajaxLoader").removeClass('hidden');

    $("div.register-box div.bg-danger").addClass('hidden').html('');
    $("div.register-box div.bg-success").addClass('hidden').html('');
    $('div.val_error').remove();
    var reg = /^[a-zA-Z0-9 ]*$/;
    var username = $('input[name="username"]').val();
    var username_lower = $('input[name="username"]').val().toLowerCase();
    var password = $("input[name='password']").val();
    var confirm_password = $("finput[name='confirm_password']").val();
    var email = $('input[name="email"]').val();
    var mobile = $('input[name="mobile"]').val();


    var form_data = $("form#frontRegFormOneStep").serialize();
    var error_prefix = '<div class="val_error">';
    var error_suffix = '</div>';
    if (!$('input[name="over_18"]').is(':checked')) {
      $("div.accOver18").append(error_prefix + over_18_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (!$('input[name="privacy"]').is(':checked')) {
      $("div.Privacy").append(error_prefix + tac_error + error_suffix);
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username.indexOf(' ') >= 0) {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(username_two_char_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if (username_lower == 'join' || username_lower == 'joinnow' || username_lower == 'signup' || username_lower == 'corporate' || username_lower == 'nigel' || username_lower == 'sebastian' || username_lower == 'infosignupnow' || username_lower == 'scam' || username_lower == 'scamscam' || username_lower == 'fuckyou' || username_lower == 'official' || username_lower == 'company' || username_lower == 'rouja') {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(choose_another_username_error);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if(!reg.test(username)){
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(username_alphabetic);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else if(username.search(/cryptoqueen/i) != -1) {
      $("div.register-box div.bg-danger").addClass('hidden').html('');
      $("div.register-box div.bg-danger").addClass('hidden').html(username_taken);
      $("div.bg-danger").removeClass('hidden');
      $("img#ajaxLoader").addClass('hidden');
      $(this).removeAttr('disabled');
    } else {
      $.post('https://www.onecoin.eu/tech/accounts/registrationOneStep/', form_data, function (response) {
        var obj = $.parseJSON(response);

        if (typeof obj.redirect_url != "undefined") {
          window.location = obj.redirect_url;
        }

        if (typeof obj.errors != "undefined") {
          if (typeof obj.errors.empty_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.empty_email + error_suffix);
          }

          if (typeof obj.errors.invalid_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.invalid_email + error_suffix);
          }

          if (typeof obj.errors.not_unique_email != "undefined") {
            $("div.accEmail").append(error_prefix + obj.errors.not_unique_email + error_suffix);
          }

          if (typeof obj.errors.empty_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.empty_username + error_suffix);
          }

          if (typeof obj.errors.not_unique_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.not_unique_username + error_suffix);
          }
          if (typeof obj.errors.invalid_username != "undefined") {
            $("div.accUsername").append(error_prefix + obj.errors.invalid_username + error_suffix);
          }
          if (typeof obj.errors.empty_password != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.empty_password + error_suffix);
          }
          if (typeof obj.errors.not_matching_password != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.not_matching_password + error_suffix);
          }
          if (typeof obj.errors.password_too_weak != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.password_too_weak + error_suffix);
          }
          if (typeof obj.errors.password_too_short != "undefined") {
            $("div.accPassword").append(error_prefix + obj.errors.password_too_short + error_suffix);
          }
          if (typeof obj.errors.empty_first_name != "undefined") {
            $("div.accFirstName").append(error_prefix + obj.errors.empty_first_name + error_suffix);
          }
          if (typeof obj.errors.empty_last_name != "undefined") {
            $("div.accLastName").append(error_prefix + obj.errors.empty_last_name + error_suffix);
          }
          if (typeof obj.errors.empty_country != "undefined") {
            $("div.accCountry").append(error_prefix + obj.errors.empty_country + error_suffix);
          }

          if (typeof obj.errors.mobile_error != "undefined") {
            $("div.accMobile").append(error_prefix + mobile_error + error_suffix);
          }
          if (typeof obj.errors.empty_mobile != "undefined") {
            $("div.accMobile").append(error_prefix + obj.errors.empty_mobile + error_suffix);
          }

          if (typeof obj.errors.invalid_mobile != "undefined") {
            $("div.accMobile").append(error_prefix + obj.errors.invalid_mobile + error_suffix);
          }
          if (typeof obj.errors.empty_captcha != "undefined") {
            $("div.accCaptcha").append(error_prefix + obj.errors.empty_captcha + error_suffix);
          }
          if (typeof obj.errors.invalid_captcha != "undefined") {
            $("div.accCaptcha").append(error_prefix + obj.errors.invalid_captcha + error_suffix);
          }
        }
        $("img#ajaxLoader").addClass('hidden');

      });
    }
    $("input#regOneStep").removeAttr('disabled');

  });

});

function makeCounter(myCounter) {
  var counterValue = myCounter.getValue();
  $.post('/tech/other/getJoinedPeople/', {value: counterValue}, function (response) {
    myCounter.setValue($.trim(response));
    setTimeout(function() {
      makeCounter(myCounter);
    }, 10000);
  });
}

function validateEmail(sEmail) {
  var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
  if (filter.test(sEmail)) {
    return true;
  } else {
    return false;
  }
}

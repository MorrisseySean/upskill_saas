/* global $, Stripe */
// Ensure document is ready 
$(document).on('turbolinks:load', function(){
    var the_form = $('#pro_form');
    var submit_button = $('#form-signup-btn');
    
    // Set the Stripe public key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    // When user clicks form submit button, prevent default behaviour
    submit_button.click(function(event){
        event.preventDefault();
        submit_button.val("Processing...").prop('disabled', true);
        
        // Collect credit card fields
        var card_num = $('#card_number').val(),
            cvc_num = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        // Validate card input fields
        var error = false;
        var error_str = "";
        if(!Stripe.card.validateCardNumber(card_num)){
            error = true;
            error_str += "Sorry, your card number is invalid.\n";
        }
        
        if(!Stripe.card.validateCVC(cvc_num)){
            error = true;
            error_str += "Sorry, your CVC is invalid.\n";
        }
        
        if(!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            error_str += "Sorry, your card expiration date is invalid.\n";
        }
        
        if(error){
            // Don't send to Stripe
            alert(error_str);
            submit_button.val("Sign Up").prop('disabled', false);
            
        } 
        else {
            // Send fields to Stripe
            Stripe.createToken({
                number: card_num,
                cvc: cvc_num,
                exp_month: expMonth,
                exp_year: expYear
                }, stripeResponseHandler);
        }
        
        return false;
    });
        
    // Recieve Stripe token
    function stripeResponseHandler(status, response){
        var token = response.id;
        
        // Inject token to hidden form fields
        the_form.append($('<input type="hidden" name="user[stripe_card_token]">').val(token));
        
        // Submit form to Rails
        the_form.get(0).submit();
        
    }
        
        
        
        
        
   
    
    
});
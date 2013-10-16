$( document ).ready(function() {
    var cep_val;

    $('form').on('focus','select,input', function(event) {
        $(event.target).parents('.controls:first').find('.hint-inline').show();
    });

    $('form').on('blur','select,input', function(event) {
        $(event.target).parents('.controls:first').find('.hint-inline').hide();
    });

    $('#elm_state_id').change(function() {
       get_cities($(this).val());
    });

    $('.postal_code').keyup(function() {
        if(cep_val != $(this).val()){
            get_address($(this));
        }
    });

    if($('.postal_code').val()) {
        get_address($('.postal_code'), true);
    } else {
        if($('#elm_state_id').val() != '') {
            get_cities($('#elm_state_id').val());
        }
    }

    $('.postal_code').click(function(){
        cep_val = $(this).val();
    });

});

function get_address( $me, no_focus ) {
    var cep = $me.val().replace('_', '');
    $('#cep_not_found').hide();

    if(cep.length < 9) {
        return false;
    }

    var postal_code = $me.val(),
        invalid     = false;

    $me.addClass('input-loading');

    if(postal_code == '') {

        invalid = true;
        $("#postal_code_error").show();
        $me.removeClass('input-loading');

    }

    if(invalid == false) {

        $.ajax({
            url: "/get_address",
            data: {postal_code: postal_code},
            dataType: 'json',
            success: function(result) {

                if(result.error){

                    $('#cep_not_found').show();
                    $('#elm_state_id').focus();
                    $('.clear_addr').val('');
                    setTimeout("$('#cep_not_found').fadeOut();", 10000);

                } else {
                    addr_format = result.address.replace(/\s+- de.+a.+/, '');
                    addr_format = result.address.replace(/\s+- até.+/, '');
                    addr_format = result.address.replace(/\s+- lado.+/, '');
                    $('#elm_address').val(addr_format);
                    $('#elm_neighborhood').val(result.neighborhood);
                    $('#elm_state_id').val(result.state_id);

                    if($('#elm_city_id').find(":contains("+result.location+")").length) {
                        $('#elm_city_id').val(result.city_id);
                    } else {
                        $('#elm_city_id').append('<option value='+result.city_id+'>'+result.location+'</option>').val(result.city_id);
                    }
                    $("#city_aux").val(result.city_id);
                    if(!no_focus) {
                        $('#elm_number').focus();
                    }

                }
            },
            complete: function() {

                $me.removeClass('input-loading');

            }
        });

    }

}

function reset_button() {

    setTimeout(function () {
        $("#check_token").button('reset');
    })

}

function get_cities(state_id) {
    var $me = $('#elm_city_id');

    if(!state_id) {
        return false;
    }

    $me.removeClass('required');
    $me.addClass('input-loading');

    $.ajax({
        url: "/get_cities",
        data: {state_id: state_id},
        dataType: 'html',
        success: function(result) {
            $("#cities").html(result);
        },
        error: function(err) {
            alert(err);
        },
        complete: function() {
            $me.removeClass('input-loading');
            $me.addClass('required');

            if($('#city_aux').val()) {
                $('#elm_city_id').val($('#city_aux').val());
            }

            $('#elm_city_id').on('change', function(){
                $('#city_aux').val($(this).val());
            });
        }
    });
}
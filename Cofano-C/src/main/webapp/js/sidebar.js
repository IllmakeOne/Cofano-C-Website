    jQuery(document).ready(function ($) {
        var path = window.location.pathname.split("/").pop();

        var target = $('nav a[href="'+path+'"]');
        target.addClass('active');

    });
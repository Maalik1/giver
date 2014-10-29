$ ->
  $('.file-field').change ->
    fileName = $(this).val().split('\\').pop()
    $('.path').val(fileName)

  $('#reward_shipping').click ->
    $('.shipping').toggle()

  $('#reward_limit').click ->
    $('.limit').toggle()
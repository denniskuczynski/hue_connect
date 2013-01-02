window.zeroFill = (num_string, width ) ->
  width -= num_string.length
  if ( width > 0 )
    return new Array( width + 1 ).join( '0' ) + num_string
  return num_string

window.toColorString = (converted_colors) ->
  r = window.zeroFill(converted_colors[0].toString(16), 2)
  g = window.zeroFill(converted_colors[1].toString(16), 2)
  b = window.zeroFill(converted_colors[2].toString(16), 2)
  "##{r}#{g}#{b}"

$ ->
  $('.color_swatch').each (index, swatch) ->
    $swatch = $(swatch)
    index = $swatch.data('index')
    hue = $("#hue_#{index}").val()
    sat = $("#sat_#{index}").val()
    bri = $("#bri_#{index}").val()
    rgb_color = window.toColorString(window.hsvToRgb( (hue/65535.0)*360.0, (sat/254.0)*100.0, (bri/254.0)*100.0 ))
    $swatch.css('background', rgb_color)
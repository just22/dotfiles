function conky_printf( format, value )
    return string.format( format , conky_parse( value ) )
end

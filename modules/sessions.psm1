function sessions{
    $sessions = $(query session)
    return @{results=$sessions;success=$true}
}

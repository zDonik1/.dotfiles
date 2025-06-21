def to-datetime [time: string] {
    if (($time | str replace -r '^(\d{4}|\d{6})$' "") == "") {
        return (date now | format date $"%Y%m%dT($time)" | into datetime)
    }
    $time | into datetime
}

def _tra [start: datetime, end: datetime, ...tags: string] {
    let start = if ($start > (date now)) { $start - 1day } else { $start }
    let end = if ($end > (date now)) { $end - 1day } else { $end }
    timew tra ($start | format date "%FT%T") - ($end | format date "%FT%T") ...$tags
}

export def yest [time: string] { (to-datetime $time) - 1day | format date "%FT%T" }

export def tra [start: string, end: string, ...tags: string] {
    _tra (to-datetime $start) (to-datetime $end) ...$tags
}

export def trafl [end: string, ...tags: string] {
    _tra (to-datetime (timew get dom.tracked.1.end)) (to-datetime $end) ...$tags
}

export def tras [start: string, rest: int, end: string] {
    let $start = to-datetime $start
    let $resttime = $start + ($rest | into duration --unit min)
    let $end = to-datetime $end
    _tra $start $resttime rest
    _tra $resttime $end sleep
}

export def twbud [] {
    let budgets = {
        jobsearch: 2hr
        journal: 1hr
        gosleep: 2hr
        "chores|errands|config": 2hr
    }

    $budgets
    | transpose category budget
    | insert current {|row|
        $row.category | split row "|"
        | each {
            timew sum $in | lines | drop
            | if ($in | is-empty) { $in | append "00:00:00"} else { $in }
            | last | str trim
            | ($in | str replace ":" "hr " | str replace ":" "min ") + "sec" 
            | into duration
        }
        | math sum
    }
    | insert left {|row| $row.budget - $row.current }
    | insert progress {|row|
        0..($row.current / $row.budget * 10 | if ($in > 10) { 10 } else { $in })
        | each { $"(ansi green)█(ansi reset)" } | skip 1 | str join
    }
    | update current { format duration hr }
    | update left { format duration hr }
}

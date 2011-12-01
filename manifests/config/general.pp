class sample::config::general {

    $file = '/etc/sample/concat.conf'

    include
        ::concat::setup

    concat{ $file:
        owner => 'root',
        group => 'root',
        mode    => '0600',
    }

}

define sample::config::general::fragment (
    $owner = 'root',
    $group = 'root',
    $mode  = '0600',
    $order,
    $content
){

    include ::sample::config::general

    # decide whether to use content or source
    if $content =~ /^puppet:\/\// {
        Concat::Fragment{
            source => $content
        }
    }
    else {
        Concat::Fragment{
            content => $content
        }
    }

    concat::fragment{$name:
        group   => $group,
        group   => $group,
        mode    => $mode,
        order   => $order,
        owner   => $owner,
        target  => $::sample::config::general::file,
    }

}

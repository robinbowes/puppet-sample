class sample::config{

    File{
        require => Class['::sample::install'],
        notify  => Class['::sample::service'],
    }

    file{

        '/etc/sample':
            ensure => directory;

        '/etc/sample/simple.conf':
            source => 'puppet:///modules/sample/simple.conf';

    }

    include ::sample::config::general

    Sample::Config::General{
        require => [
            File['/etc/sample'],
            Class['::sample::install'],
        ],
        notify  => Class['::sample::service']
    }

    sample::config::general::fragment{'header':
        order => 00,
        content => template('sample/general/header.erb')
    }

    sample::config::general::fragment{'body':
        order => 10,
        content => template('sample/general/body.erb')
    }

    sample::config::general::fragment{'footer':
        order => 20,
        content => template('sample/general/footer.erb')
    }

}

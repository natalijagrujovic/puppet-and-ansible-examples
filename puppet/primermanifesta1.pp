package { ‘nginx’:
    ensure => ‘installed’,
}
file { ‘/tmp/fajl.txt’:
        ensure => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "Ovo je sadržaj datoteke.\n",
}
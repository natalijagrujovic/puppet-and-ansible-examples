# Puppet setup
Ovde ćemo proći kroz sve korake podešavanja Puppet alata.

NAPOMENA: Kako bismo pojednostavili proces instalacije i upotrebe, koristićemo dva node-a. Na jednom ćemo instalirati Puppet Server aplikaciju, a na drugom Puppet Agent aplikaciju. U praksi možete imati i više stotina ili hiljada agent node-ova.

## Podešavanje hosts datoteka
Prvo ćemo izmeniti hosts datoteku i na server i na agent node-u.

~~~
sudo nano /etc/hosts
~~~

Na kraju svake hosts datoteke dodajemo
~~~
        IP_ADRESA_MASTER HOSTNAME_MASTER puppet
        IP_ADRESA_AGENT HOSTNAME_AGENT
~~~

## Podešavanje Puppet Servera

Sada ćemo instalirati Puppet Server aplikaciju na glavnom node-u.

Dodajemo Puppet repozitorijum
~~~
wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get update
~~~
Instaliramo Puppet Server
~~~
sudo apt-get install puppetserver
~~~

## Podešavanje Puppet Agenta
Sada ćemo instalirati Puppet Agent aplikaciju na agent node-u.

Dodajemo Puppet repozitorijum
~~~
wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get update
~~~
Instaliramo Puppet Agent
~~~
sudo apt-get install puppet-agent
~~~
Uređujemo puppet.conf datoteku na agent node-u
~~~
sudo nano /etc/puppetlabs/puppet/puppet.conf
~~~
~~~
[main]
server = HOSTNAME_MASTER
certname = HOSTNAME_AGENT
~~~

## Startovanje Puppet Server i Puppet Agent aplikacija

Prvo pokrećemo Puppet Server aplikaciju na glavnom node-u
~~~
sudo systemctl start puppetserver
sudo systemctl enable puppetserver
~~~

Zatim pokrećemo Puppet Agent aplikaciju na agent node-u
~~~
sudo systemctl start puppet
sudo systemctl enable puppet
~~~

Kada se Puppet Agent prvi put pokrene, poslaće se zahtev za sertifikat, pa na server node-u mora da se potpiše sertifikat.
~~~
sudo /opt/puppetlabs/bin/puppetserver ca sign --certname HOSTNAME_AGENT
~~~

Sada možemo preći na kreiranje i izvršavanje manifesta. Manifest ćemo kreirati na sledećoj putanji, na glavnom node-u. 
~~~
sudo nano /etc/puppetlabs/code/environments/production/manifests/primermanifesta.pp
~~~

Primer manifesta koji instalira *nginx* i kreira datoteku na agent node-u možete pogledati ovde:  [Primer manifesta](<primermanifesta1.pp>)

Manifest možemo izvršiti komandom koju pokrećemo na agent node-u
~~~ 
sudo /opt/puppetlabs/bin/puppet agent -t
~~~


# Ansible Setup
Ovde ćemo proći kroz sve korake podešavanja Ansible alata.

NAPOMENA: Potrebno je instalirati Ansible na glavnom node-u, a zatim uspostaviti SSH konekciju sa ostalim node-ovima. Kako bismo pojednostavili proces instalacije i upotrebe, koristićemo samo dva node-a.

## Instaliranje Ansible-a
Na glavnom node-u ćemo instalirati Ansible
~~~
sudo apt install ansible
~~~

## Kreiranje inventara
Kreiraćemo inventar na putanji */etc/ansible/hosts*. Tu ćemo navesti IP adresu client node-a.

Primer inventara možete pogledati ovde: [Primer inventara 1](<primerinventara1.yml>)

Ukoliko radite sa više client node-ova(npr. 3), primer inventara može izgledati i ovako: [Primer inventara 2](<primerinventara2.yml>)

## Uspostavljanje SSH konekcije
Kreiranje ključeva
~~~
ssh-keygen -t rsa
~~~
Kopiranje javnog ključa na ciljani node
~~~
ssh-copy-id username@target_ip
~~~

*Username* se odnosi na korisničko ime koje se koristi za prijavljivanje na ciljani node(server), dok *target_ip* predstavlja IP adresu ili hostname ciljnog node-a.

## Kreiranje skripte (Playbook-a)
Sada ćemo kreirati Playbook.
~~~
sudo nano primerplaybooka1.yml
~~~
Primer Playbook-a koji instalira *nginx* na ciljanu grupu node-ova možemo videti ovde: [Primer Playbook-a 1](<primerplaybooka1.yml>)

Primer Playbook-a koji kreira direktorijum na ciljanoj grupi node-ova možemo videti ovde: [Primer Playbook-a 2](<primerplaybooka2.yml>)

## Izvršavanje Playbook-a
~~~
ansible-playbook primerplaybooka1.yml
~~~
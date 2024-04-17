#!/usr/env/bin python3
# GNU General Public License v3.0
# knedl1k 2024

import csv
import random
import string
from datetime import timedelta
from faker import Faker

fake=Faker()

generated_ICAO_codes=set()
generated_kodspol_codes=set()
generated_aeroname_codes=set()
generated_registrznacka_codes=set()
taken_registrznacka_codes=set()

generated_cisloletu=list()
generated_pas_codes=set()

odlety={}
prilety={}

""" 
HELPER FUNCTIONS
"""
def generate_unique_ICAO_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=4))
        if code not in generated_ICAO_codes:
            generated_ICAO_codes.add(code)
            return code

def generate_ICAO_code():
    code = ''.join(random.choices(string.ascii_uppercase, k=4))
    return code

def generate_unique_aerokod_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=3))
        if code not in generated_kodspol_codes:
            generated_kodspol_codes.add(code)
            return code

def generate_unique_aeroname_code():
    while True:
        code=fake.company()
        if code not in generated_aeroname_codes:
            generated_aeroname_codes.add(code)
            return code

def generate_registznacka():
    while True:
        letters=string.ascii_uppercase
        numbers=string.digits
        code=''.join(random.choices(letters, k=2)) + '-' + ''.join(random.choices(letters + numbers, k=6))
        if code not in generated_registrznacka_codes:
            generated_registrznacka_codes.add(code)
            return code

def pick_registrznacka(fr):
    while True:
        code=random.choice(tuple(generated_registrznacka_codes))
        if code not in taken_registrznacka_codes:
            taken_registrznacka_codes.add(code)
            return code

def generate_cisloletu():
    code=fake.bothify(text='??####')
    generated_cisloletu.append(code)
    return code

def generate_pas():
    while True:
        code=fake.passport_number()
        if code not in generated_pas_codes:
            generated_pas_codes.add(code)
            return code

def generate_lety(n):
    for _ in range(n):
        cislo_letu=generate_cisloletu()
        odlet=fake.date_time_this_year(before_now=True, after_now=False)
        odlety[cislo_letu]=odlet
        prilet=prilet=odlet + timedelta(hours=random.randint(1, 12))
        prilety[cislo_letu]=prilet
"""
HEAD FUNCTIONS
"""
def generate_letiste_data(n):
    with open('letiste_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['ICAO_kod', 'nazev', 'mesto', 'stat']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'ICAO_kod': generate_unique_ICAO_code(),
                'nazev': fake.company(),
                'mesto': fake.city(),
                'stat': fake.country()
            })

def generate_let_data(n):
    ls=list(generated_cisloletu)
    with open('let_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['cislo_letu', 'cas_odletu', 'cas_priletu', 'ICAO_kod_prilet', 'ICAO_kod_odlet']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(n):
            #odlet=fake.date_time_this_year(before_now=True, after_now=False)
            #prilet=odlet + timedelta(hours=random.randint(1, 12))
            writer.writerow({
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]],
                'cas_priletu': prilety[ls[i]],
                'ICAO_kod_prilet': random.choice(tuple(generated_ICAO_codes)),
                'ICAO_kod_odlet': random.choice(tuple(generated_ICAO_codes))
            })

def generate_aerolinka_data(n):
    with open('aerolinka_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['kod_spolecnosti', 'nazev', 'zeme_puvodu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'kod_spolecnosti': generate_unique_aerokod_code(),
                'nazev': generate_unique_aeroname_code(),
                'zeme_puvodu': fake.country()
            })

def generate_letadlo_data(n):
    with open('letadlo_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'vlastnik']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': generate_registznacka(),
                'vlastnik': fake.company(),
            })

def generate_nakladni_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[:midpoint]
    with open('nakladni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'nosnost']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(ls),
                'nosnost': random.randint(5, 100),
            })

def generate_civilni_data(n):
    midpoint=len(generated_registrznacka_codes) // 2
    ls=list(generated_registrznacka_codes)[midpoint:]
    with open('civilni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'kapacita_pasazeru']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(ls),
                'kapacita_pasazeru': random.randint(20, 800),
            })

def generate_pasazer_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[midpoint:]
    #print("otviram soubor")
    with open('pasazer_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_pasu', 'datum_narozeni', 'prijmeni', 'registracni_znacka']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            #print("zapisuju")
            writer.writerow({
                'cislo_pasu': generate_pas(),
                'datum_narozeni': fake.passport_dob(),
                'prijmeni': fake.last_name(),
                'registracni_znacka': ls[random.randint(0, len(ls)-1)]
            })

def generate_krestnijmeno_data():
    ls=list(generated_pas_codes)
    with open('krestniJmeno_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_pasu', 'krestni_jmeno']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(len(ls)):
            jmeno=fake.first_name()
            writer.writerow({
                'cislo_pasu': ls[i],
                'krestni_jmeno': jmeno,
            })
            if(random.choices([0, 1], weights=[0.9, 0.1], k=1)[0]):
                jmeno2=fake.first_name()
                while jmeno==jmeno2:
                    jmeno2=fake.first_name()
                writer.writerow({
                'cislo_pasu': ls[i],
                'krestni_jmeno': jmeno2,
                })

def generate_zavazadlo_data(n):
    with open('zavazadlo_data.csv', 'w', newline='') as csvfile:
        fieldnames=['datum', 'cislo_letu', 'cislo_pasu', 'hmotnost']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'datum': fake.date_time_this_year(before_now=True, after_now=False),
                'cislo_letu': generated_cisloletu[random.randint(0, len(generated_cisloletu)-1)],
                'cislo_pasu': random.choice(tuple(generated_pas_codes)), 
                'hmotnost': random.randint(1, 100),
            })

def generate_leti_data(n):
    ls=list(generated_cisloletu)
    ls2=list(generated_registrznacka_codes)
    with open('leti_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'cislo_letu', 'cas_odletu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(n):
            writer.writerow({
                'registracni_znacka': ls2[i],
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]]
            })
"""
def generate_navazujeNa_data(n):
    with open('navazujeNa_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_letu', 'cas_odletu', 'navazuje']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'cislo_letu': ,
                'cas_odletu': ,
                'navazuje':
            })
"""
def generate_zajistuje_data():
    ls=list(generated_cisloletu)
    ls2=list(generated_kodspol_codes)
    with open('zajistuje_data.csv', 'w', newline='') as csvfile:
        fieldnames=['kod_spolecnosti', 'cislo_letu', 'cas_odletu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(len(ls2)):
            writer.writerow({
                'kod_spolecnosti': ls2[random.randint(0, len(ls2))],
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]]
            })


if __name__ == "__main__":
    num_letadlo=1_000
    num_pasazer=num_letadlo*10
    ''''''
    generate_letiste_data(10_000)

    generate_lety(1_200) #pregenerate combinations of odlet+cislo & prilet+cislo
    generate_let_data(num_letadlo)
    

    generate_aerolinka_data(1_000)

    generate_letadlo_data(num_letadlo)
    generate_nakladni_data(int(num_letadlo/2))
    generate_civilni_data(int(num_letadlo/2))
    taken_registrznacka_codes=set()

    generate_pasazer_data(num_pasazer)
    generate_krestnijmeno_data()
    generate_zavazadlo_data(int(num_pasazer//1.5))

    generate_leti_data(num_letadlo)

    generate_zajistuje_data()
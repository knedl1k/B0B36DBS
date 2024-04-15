#!/usr/env/bin python3
# GNU General Public License v3.0
# knedl1k 2024

import csv
import random
import string
from datetime import timedelta
from faker import Faker

fake = Faker()

generated_ICAO_codes = set()
def generate_unique_ICAO_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=4))
        if code not in generated_ICAO_codes:
            generated_ICAO_codes.add(code)
            return code

def generate_ICAO_code():
    code = ''.join(random.choices(string.ascii_uppercase, k=4))
    return code


def generate_letiste_data(n):
    with open('letiste_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['ICAO_kod', 'nazev', 'mesto', 'stat']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'ICAO_kod': generate_unique_ICAO_code(),
                'nazev': fake.company(),
                'mesto': fake.city(),
                'stat': fake.country()
            })

def generate_let_data(n):
    with open('let_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['cislo_letu', 'cas_odletu', 'cas_priletu', 'ICAO_kod_prilet', 'ICAO_kod_odlet']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            odlet = fake.date_time_this_year(before_now=True, after_now=False)
            prilet = odlet + timedelta(hours=random.randint(1, 12))
            writer.writerow({
                'cislo_letu': fake.bothify(text='??####'),
                'cas_odletu': odlet,
                'cas_priletu': prilet,
                'ICAO_kod_prilet': random.choice(tuple(generated_ICAO_codes)),
                'ICAO_kod_odlet': random.choice(tuple(generated_ICAO_codes))
            })

generated_kodspol_codes = set()
def generate_unique_kodspol_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=3))
        if code not in generated_kodspol_codes:
            generated_kodspol_codes.add(code)
            return code

def generate_aerolinka_data(n):
    with open('aerolinka_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['kod_spolecnosti', 'nazev', 'zeme_puvodu']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'kod_spolecnosti': generate_unique_kodspol_code(),
                'nazev': fake.company(),
                'zeme_puvodu': fake.country()
            })

generated_registrznacka_codes=set()
def generate_registznacka():
    while True:
        letters = string.ascii_uppercase
        numbers = string.digits
        code=''.join(random.choices(letters, k=2)) + '-' + ''.join(random.choices(letters + numbers, k=6))
        if code not in generated_registrznacka_codes:
            generated_registrznacka_codes.add(code)
            return code


def generate_letadlo_data(n):
    with open('letadlo_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'vlastnik']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': generate_registznacka(),
                'vlastnik': fake.company(),
            })

taken_generated_codes=set()

def pick_registrznacka(fr):
    while True:
        code=random.choice(tuple(generated_registrznacka_codes))
        if code not in taken_generated_codes:
            taken_generated_codes.add(code)
            return code

def generate_civilni_data(n):
    midpoint=len(generated_registrznacka_codes) // 2
    with open('civilni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'kapacita_pasazeru']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(generated_registrznacka_codes[midpoint:]),
                'kapacita_pasazeru': random.randint(20, 800),
            })
def generate_nakladni_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[:midpoint]
    with open('nakladni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'nosnost']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(ls),
                'nosnost': random.randint(5, 100),
            })

def generate_pasazer_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[midpoint:]
    with open('pasazer_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_pasu', 'datum_narozeni', 'prijmeni', 'registracni_znacka']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'cislo_pasu': fake.passport_number(),
                'datum_narozeni': fake.date_time(),
                'prijmeni': fake.last_name(),
                'registracni_znacka': pick_registrznacka(ls)
            })



if __name__ == "__main__":
    num_letadlo=100_000
    ''''''
    generate_letiste_data(10_000)
    generate_let_data(10_000)
    generate_aerolinka_data(10_000)    
    generate_letadlo_data(num_letadlo)
    
    generate_nakladni_data(int(num_letadlo/2))
    generate_civilni_data(int(num_letadlo/2))

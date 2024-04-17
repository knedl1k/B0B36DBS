#!/usr/env/bin python3
# GNU General Public License v3.0
# knedl1k 2024

def find_duplicate_strings(file_path):
    string_count = {}

    with open(file_path, 'r') as file:
        for line in file:
            words = line.strip().split()
            for word in words:
                if word in string_count:
                    string_count[word] += 1
                else:
                    string_count[word] = 1

    duplicates = {string: count for string, count in string_count.items() if count > 1}
    return duplicates

file_path = 'krestniJmeno_data.csv' 
duplicates = find_duplicate_strings(file_path)
print("Duplicate strings in the file:")
for string, count in duplicates.items():
    print(f"'{string}' appears {count} times.")


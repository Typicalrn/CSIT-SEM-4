laptops={
    'A':{'price':70000,'rating':4.5},
    'B':{'price':80000,'rating':4.2},
    'C':{'price':90000,'rating':4.9}
}

Best_laptop= None
best_utility= 0

for laptop in laptops:
    utility=laptops[laptop]['rating']*100000/laptops[laptop]['price']
    print(f"{laptop} Utility Score: {utility:.2f}")
    if utility > best_utility:
        best_utility=utility
        Best_laptop=laptop
            
print("Best Laptop:",Best_laptop)
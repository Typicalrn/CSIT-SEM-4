print("Medical Expert System")

fever = input("Do you have fever? (yes/no): ").lower()
cough = input("Do you have cough? (yes/no): ").lower()
rash = input("Do you have rash? (yes/no): ").lower()
sneezing = input("Do you have sneezing? (yes/no): ").lower()

if fever == "yes" and cough == "yes":
    print("Diagnosis: Flu")
elif fever == "yes" and rash == "yes":
    print("Diagnosis: Measles")
elif sneezing == "yes":
    print("Diagnosis: Allergy")
else:
    print("No disease identified.")
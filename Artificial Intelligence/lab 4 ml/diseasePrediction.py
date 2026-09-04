# Disease Prediction Expert System
RULES = {
    "Flu": {"fever", "cough", "body pain"},
    "Pneumonia": {"fever", "cough", "difficulty breathing"},
    "Dengue": {"headache", "fever", "body pain"},
    "Common Cold": {"sneezing", "runny nose", "cough"},
    "Food Poisoning": {"stomach pain", "vomiting", "diarrhea"},
}

def diagnose(symptoms):
    symptom_set = set(symptoms)
    return [disease for disease, required in RULES.items() if required.issubset(symptom_set)]

print("===== DISEASE EXPERT SYSTEM =====")
print("\nAvailable symptoms:")
print("\n".join(sorted({s for reqs in RULES.values() for s in reqs})))

user_input = input("\nEnter symptoms separated by comma: ")
symptoms = [s.strip().lower() for s in user_input.split(",")]
result = diagnose(symptoms)

print("\nPossible disease(s):")
if result:
    print("\n".join(f"- {d}" for d in result))
else:
    print("No matching disease found.")
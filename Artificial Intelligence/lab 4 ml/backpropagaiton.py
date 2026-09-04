from collections import Counter

data = [
    ['Youth','High','No','Fair','No'], ['Youth','High','No','Excellent','No'],
    ['Middle_aged','High','No','Fair','Yes'], ['Old','Medium','No','Fair','Yes'],
    ['Old','Low','Yes','Fair','Yes'],['Old','Medium','No','Excellent','No']
]

classes = Counter(row[4] for row in data)
total = len(data)
priors = {c: classes[c] / total for c in classes}

def cond_prob(idx, value, cls):
    subset = [row for row in data if row[4] == cls]
    if not subset:
        return 0
    return sum(1 for row in subset if row[idx] == value) / len(subset)

def predict(age, income, student, credit):
    features = [(0, age), (1, income), (2, student), (3, credit)]
    scores = {}
    for cls in classes:
        p = priors[cls]
        for idx, val in features:
            p *= cond_prob(idx, val, cls)
        scores[cls] = p
    for cls, p in scores.items():
        print(f"P({cls}) = {p}")
    return max(scores, key=scores.get)

age, income, student, credit = 'Youth', 'Medium', 'Yes', 'Fair'
result = predict(age, income, student, credit)
print(f"\nNew Person: {age}, {income}, {student}, {credit}")
print("Prediction:", result)
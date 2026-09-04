import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.naive_bayes import CategoricalNB

data = {
    'Age':    ['Youth','Youth','Middle_aged','Old','Old'],
    'Income': ['High','High','High','Medium','Low'],
    'Student':['No','No','No','Yes','Yes'],
    'Credit': ['Fair','Excellent','Fair','Fair','Fair'],
    'Buys_Computer': ['No','No','Yes','Yes','Yes']
}
df = pd.DataFrame(data)
print("Dataset:\n", df)

encoders = {col: LabelEncoder().fit(df[col]) for col in df.columns}
df_enc = df.apply(lambda col: encoders[col.name].transform(col))
print("\nEncoded Dataset:\n", df_enc)

X, y = df_enc[['Age', 'Income', 'Student', 'Credit']], df_enc['Buys_Computer']
model = CategoricalNB().fit(X, y)

new_person = pd.DataFrame({'Age': ['Youth'], 'Income': ['Medium'], 'Student': ['Yes'], 'Credit': ['Fair']})
new_enc = new_person.apply(lambda col: encoders[col.name].transform(col))

prediction = model.predict(new_enc)
result = encoders['Buys_Computer'].inverse_transform(prediction)
print("\nWill the person buy a computer?", result[0])
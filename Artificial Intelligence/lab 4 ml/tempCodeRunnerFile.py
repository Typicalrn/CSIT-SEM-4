from sklearn.linear_model import Perceptron
# Input data
X = [ [0, 0], [0, 1], [1, 0], [1, 1]]
# AND output
y_and = [0, 0, 0, 1]
# OR output
y_or = [0, 1, 1, 1]
# AND Gate
and_model = Perceptron(
    max_iter=1000,    eta0=0.1,    random_state=42
)
and_model.fit(X, y_and)
print("AND Gate:")
print(and_model.predict(X))
# OR Gate
or_model = Perceptron(
    max_iter=1000,eta0=0.1,random_state=42
)
or_model.fit(X, y_or)
print("OR Gate:")
print(or_model.predict(X))

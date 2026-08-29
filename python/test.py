class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def greet(self):
        return "Hi, I am " + self.name

kai = Student("Kai", 22)
print(kai.name)
print(kai.age)
sara = Student("Sara", 30)
print(sara.name, kai.name)
print(kai.greet())
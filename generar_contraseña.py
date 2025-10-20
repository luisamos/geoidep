from werkzeug.security import generate_password_hash, check_password_hash

hash = generate_password_hash("123", method="scrypt")
print(hash)

estado = check_password_hash(hash, "123")

print(estado)
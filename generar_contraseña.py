from werkzeug.security import generate_password_hash, check_password_hash

hash = generate_password_hash("luisamos$", method="scrypt")
print(hash)

estado = check_password_hash(hash, "luisamos$")

print(estado)
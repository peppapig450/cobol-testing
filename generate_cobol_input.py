from faker import Faker
import random

fake = Faker()
Faker.seed(69)

# Number of records to generate
num_records = 10

with open("data/EMP.DAT", "w") as file:
    for _ in range(num_records):
        emp_id = str(fake.unique.random_int(min=1, max=99999)).zfill(5) # 5-digit ID
        emp_name = fake.name().ljust(20)[:20] # Truncate/pad name to 20 chars
        emp_hours = f"{random.uniform(20.0, 50.0):06.2f}" # Hours as 6 chars (e.g., "040.00")
        emp_rate = f"{random.uniform(10.0, 75.0):06.2f}" # Rate as 6 chars (e.g., "050.00")
        
        # Combine into a fixed length record (32 chars total)
        record = f"{emp_id}{emp_name}{emp_hours}{emp_rate}"
        file.write(record + "\n")
        
print(f"Generated {num_records} records in EMP.DAT")
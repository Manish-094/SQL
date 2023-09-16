CREATE TABLE Employee(
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  birth_day DATE,
  sex CHAR(6),
  salary DECIMAL(10,2),
  super_id INT,
  branch_id INT
);


SELECT * FROM Employee;

CREATE TABLE Branch(
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(25),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES Employee(emp_id) ON DELETE SET NULL
);


select * from Branch;

CREATE TABLE Client(
  client_id INT PRIMARY KEY,
  client_name VARCHAR(25),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCEs Branch(branch_id) ON DELETE SET NULL
);


select * from Client;

CREATE TABLE Work_with(
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id,client_id),
  FOREIGN KEY(emp_id) REFERENCES Employee(emp_id) ON DELETE SET NULL,
  FOREIGN KEY(client_id) REFERENCES Client(client_id) ON DELETE SET NULL
);

CREATE TABLE branch_supplier(
  branch_id INT,
  supplier_name VARCHAR(25),
  supply_type VARCHAR(25),
  PRIMARY KEY(branch_id,supplier_name),
  FOREIGN KEY(branch_id) REFERENCES Branch(branch_id) ON DELETE SET NULL
);
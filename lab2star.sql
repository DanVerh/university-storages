CREATE TABLE IF NOT EXISTS customers (
    car_plate CHAR(8) PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
    cellphone CHAR(9),
    car VARCHAR(50) NOT NULL,
    rating INTEGER
);

CREATE TABLE IF NOT EXISTS location (
    address VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    owner VARCHAR(50) NOT NULL,
    cellphone CHAR(9) NOT NULL
);

CREATE TABLE IF NOT EXISTS works (
    work_id SERIAL PRIMARY KEY,
    kind VARCHAR(50) NOT NULL,
    avg_days INTEGER,
    price DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS repairmen (
    fullname VARCHAR(50) PRIMARY KEY,
    job VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS details (
    detail_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    car VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS service (
    service_id SERIAL PRIMARY KEY,
    work INTEGER NOT NULL,
    location VARCHAR(50) NOT NULL,
    car_plate CHAR(8) NOT NULL,
    repairman VARCHAR(50) NOT NULL,
    detail INT NOT NULL,
    price DECIMAL(10,2),
    CONSTRAINT fk_service_location FOREIGN KEY (location) REFERENCES location (address) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_service_work FOREIGN KEY (work) REFERENCES works (work_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_service_customer FOREIGN KEY (car_plate) REFERENCES customers (car_plate) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_service_repairman FOREIGN KEY (repairman) REFERENCES repairmen (fullname) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_service_detail FOREIGN KEY (detail) REFERENCES details (detail_id) ON DELETE RESTRICT ON UPDATE NO ACTION
);

COPY customers(car_plate, fullname, cellphone, car) FROM '/tmp/insert-data/customers.csv' DELIMITER ',' CSV HEADER;
COPY location(address, city) FROM '/tmp/insert-data/location.csv' DELIMITER ',' CSV HEADER;
COPY works(kind, avg_days, price) FROM '/tmp/insert-data/works.csv' DELIMITER ',' CSV HEADER;
COPY repairmen(fullname, job) FROM '/tmp/insert-data/repairmen.csv' DELIMITER ',' CSV HEADER;
COPY details(name, car, price) FROM '/tmp/insert-data/details.csv' DELIMITER ',' CSV HEADER;
COPY service(work, location, car_plate, repairman, detail, price) FROM '/tmp/insert-data/service.csv' DELIMITER ',' CSV HEADER;

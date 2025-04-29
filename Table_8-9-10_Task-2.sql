/*

TASK 2

SQL STATEMENTS

CREATING TABLES

*/

CREATE TABLE appointments (
    appointment_id NUMBER(5) PRIMARY KEY,
    patient_id NUMBER(5),
    dentist_id NUMBER(5) NOT NULL,
    service_id NUMBER(5) NOT NULL,
    appointment_date DATE NOT NULL,
    status VARCHAR2(9) NOT NULL CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL/*,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)*/
);

CREATE SEQUENCE appointment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE TRIGGER trg_appointments_ai
    BEFORE INSERT ON appointments
    FOR EACH ROW
    BEGIN
        IF :NEW.appointment_id IS NULL THEN
            SELECT appointment_seq.NEXTVAL INTO :NEW.appointment_id FROM dual;
        END IF;
    END;

CREATE TABLE payments (
    payment_id NUMBER(5) PRIMARY KEY,
    patient_id NUMBER(5) NOT NULL,
    amount NUMBER(6,2) NOT NULL,
    payment_method VARCHAR2(13) NOT NULL CHECK (payment_method IN ('Cash', 'GCash', 'Bank Transfer')),
    status VARCHAR2(8) NOT NULL CHECK (status IN('Pending', 'Paid', 'Refunded')),
    receipt_number NUMBER NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE visit_history(
    visit_history_id NUMBER(5) PRIMARY KEY,
    patient_id NUMBER(5) NOT NULL,
    dentist_id NUMBER(5) NOT NULL,
    appointment_id NUMBER(5),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE TABLE patients(
    patient_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    middle_name VARCHAR2(100),
    nickname VARCHAR2(100),
    birthdate DATE NOT NULL,
    sex VARCHAR2(6) NOT NULL CHECK (sex IN('Male', 'Female')),
    civil_status VARCHAR2(7) NOT NULL CHECK (civil_status IN('Single', 'Married')),
    religion VARCHAR2(20),
    nationality VARCHAR2(20) NOT NULL,
    home_address VARCHAR2(255) NOT NULL,
    occupation VARCHAR2(50) NOT NULL,
    dental_insurance VARCHAR2(50),
    effective_date DATE,
    telephone_number VARCHAR2(20),
    mobile_number VARCHAR2(13) NOT NULL UNIQUE,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    guardian_name VARCHAR2(250),
    guardian_occupation VARCHAR2(50),
    referred_by VARCHAR2(250),
    reason_of_dental_consultation VARCHAR2(500),
    dental_history_id NUMBER(5) NOT NULL,
    medical_history_id NUMBER(5) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (dental_history_id) REFERENCES dental_history(dental_history_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_history(medical_history_id)
);

CREATE TABLE dental_history(
    dental_history_id NUMBER(5) PRIMARY KEY,
    previous_dentist VARCHAR2(250)
    previous_dental_clinic VARCHAR2(100),
    reason_of_last_dental_visit VARCHAR2(250),
    last_dental_visit DATE,
    clicking_lock_jaw CHAR(1) CHECK (clicking_lock_jaw IN('Y', 'N')),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);


INSERT INTO appointments ()
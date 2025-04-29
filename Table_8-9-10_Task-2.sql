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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE SEQUENCE appointment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE TRIGGER appointments_trg
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

CREATE SEQUENCE payments_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE TRIGGER payments_trg
    BEFORE INSERT ON payments
    FOR EACH ROW
    BEGIN
        IF :NEW.payment_id IS NULL THEN
            SELECT payments_seq.NEXTVAL INTO :NEW.payment_id FROM dual;
        END IF;
    END;

CREATE TABLE visit_history(
    visit_history_id NUMBER(5) PRIMARY KEY,
    patient_id NUMBER(5) NOT NULL,
    dentist_id NUMBER(5) NOT NULL,
    appointment_id NUMBER(5),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE SEQUENCE visit_history_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE TRIGGER visit_history_trg
    BEFORE INSERT ON visit_history
    FOR EACH ROW
    BEGIN
        IF :NEW.visit_history_id IS NULL THEN
            SELECT visit_history_seq.NEXTVAL INTO :NEW.visit_history_id FROM dual;
        END IF;
    END;

-- Customer Table

create table customers
(
    customer_id  number(10) primary key,
    first_name   varchar2(50) not null,
    last_name    varchar2(50) not null,
    email        varchar2(100) unique,
    phone_number varchar2(20) unique,
    address      varchar2(200),
    city         varchar2(50),
    state        varchar2(50),
    postal_code  varchar2(10),
    country      varchar2(50),
    customerid   varchar2(50) unique
);

-- Finance Category Table

create table finance_category
(
    category_id   number(10) primary key,
    category_name varchar2(50) unique
);

-- Equity Shares Table

create table equity_shares
(
    equity_id          number(10) primary key,
    equity_name        varchar2(100) unique,
    equity_category_id number references finance_category (category_id),
    quantity           number         not null,
    purchase_date      date,
    purchase_price     decimal(10, 2) not null
);

-- Equity Rate

create table equity_rate
(
    rate_id       number(10) primary key,
    equity_id     number references equity_shares (equity_id),
    rate_date     date,
    closing_price decimal(10, 2)
);

-- Mutual Fund Master

create table mf_master
(
    mf_id          number(10) primary key,
    mf_name        varchar2(100) unique,
    mf_category_id number references finance_category (category_id),
    fund_house     varchar2(100) not null,
    inception_date date          not null
);

-- Mutual Fund Rates

create table mf_rates
(
    rate_id   number(10) primary key,
    mf_id     number references mf_master (mf_id),
    rate_date date           not null,
    nav       decimal(10, 2) not null
);

-- Insurance Master Table

create table insurance_master
(
    insurance_id   number(10) primary key,
    policy_number  varchar2(50)   not null unique,
    insurance_type varchar2(50),
    premium_amount decimal(10, 2) not null,
    start_date     date,
    end_date       date
);

-- Transactions Table

create table transactions
(
    transaction_id    number(10) primary key,
    transactions_date date           not null,
    transactions_type varchar2(20)   not null,
    amount            decimal(10, 2) not null,
    customer_id       number(10) references customers (customer_id),
    equity_id         number(10) references equity_shares (equity_id),
    mf_id             number(10) references mf_master (mf_id),
    insurance_id      number(10) references insurance_master (insurance_id),
    customerid        varchar2(50)
);


-- Customer Table procedure

create or replace procedure manage_customer(p_operation in varchar2, p_customer customers%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into customers
        values p_customer;
    elsif trim(lower(p_operation)) = 'update' then
        update customers
        set first_name   = trim(p_customer.first_name),
            last_name    = trim(p_customer.last_name),
            email        = trim(p_customer.email),
            phone_number = trim(p_customer.phone_number),
            address      = trim(p_customer.address),
            city         = trim(p_customer.city),
            state        = trim(p_customer.state),
            postal_code  = trim(p_customer.postal_code),
            country      = trim(p_customer.country)
        where customer_id = trim(p_customer.customer_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from customers
        where customer_id = trim(p_customer.customer_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Finance_Category table procedure

create or replace procedure manage_finance_category(p_operation in varchar2, p_category finance_category%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into finance_category
        values p_category;
    elsif trim(lower(p_operation)) = 'update' then
        update finance_category
        set category_name = trim(p_category.category_name)
        where category_id = trim(p_category.category_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from finance_category
        where category_id = trim(p_category.category_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Equity_Share table procedure

create or replace procedure manage_equity_share(p_operation in varchar2, p_equity equity_shares%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into equity_shares
        values p_equity;
    elsif trim(lower(p_operation)) = 'update' then
        update equity_shares
        set equity_name        = trim(p_equity.equity_name),
            equity_category_id = trim(p_equity.equity_category_id),
            quantity           = trim(p_equity.quantity),
            purchase_date      = trim(p_equity.purchase_date),
            purchase_price     = trim(p_equity.purchase_price)
        where equity_id = trim(p_equity.equity_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from equity_shares
        where equity_id = trim(p_equity.equity_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Equity_Rate table procedure

create or replace procedure manage_equity_rate(p_operation in varchar2, p_rate in equity_rate%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into equity_rate
        values p_rate;
    elsif trim(lower(p_operation)) = 'update' then
        update equity_rate
        set equity_id     = trim(p_rate.equity_id),
            rate_date     = trim(p_rate.rate_date),
            closing_price = trim(p_rate.closing_price)
        where rate_id = trim(p_rate.rate_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from equity_rate
        where rate_id = trim(p_rate.rate_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- MF_Master table procedure

create or replace procedure manage_mf_master(p_operation in varchar2, p_mf_master in mf_master%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into mf_master
        values p_mf_master;
    elsif trim(lower(p_operation)) = 'update' then
        update mf_master
        set mf_name        = trim(p_mf_master.mf_name),
            mf_category_id = trim(p_mf_master.mf_category_id),
            fund_house     = trim(p_mf_master.fund_house),
            inception_date = trim(p_mf_master.inception_date)
        where mf_id = trim(p_mf_master.mf_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from mf_master
        where mf_id = trim(p_mf_master.mf_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- MF_Rates table procedure

create or replace procedure manage_mf_rates(p_operation in varchar2, p_mf_rates in mf_rates%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into mf_rates
        values p_mf_rates;
    elsif trim(lower(p_operation)) = 'update' then
        update mf_rates
        set mf_id     = trim(p_mf_rates.mf_id),
            rate_date = trim(p_mf_rates.rate_date),
            nav       = trim(p_mf_rates.nav)
        where rate_id = trim(p_mf_rates.rate_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from mf_rates
        where rate_id = trim(p_mf_rates.rate_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Insurance_master table procedure

create or replace procedure manage_insurance_master(p_operation in varchar2,
                                                    p_insurance_master in insurance_master%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into insurance_master
        values p_insurance_master;
    elsif trim(lower(p_operation)) = 'update' then
        update insurance_master
        set policy_number  = trim(p_insurance_master.policy_number),
            insurance_type = trim(p_insurance_master.insurance_type),
            premium_amount = trim(p_insurance_master.premium_amount),
            start_date     = trim(p_insurance_master.start_date),
            end_date       = trim(p_insurance_master.end_date)
        where insurance_id = trim(p_insurance_master.insurance_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from insurance_master
        where insurance_id = trim(p_insurance_master.insurance_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Transaction table procedure

create or replace procedure manage_transaction(p_operation in varchar2, p_transaction in transactions%rowtype) is
begin
    if trim(lower(p_operation)) = 'insert' then
        insert into transactions
        values p_transaction;
    elsif trim(lower(p_operation)) = 'update' then
        update transactions
        set transactions_date = trim(p_transaction.transactions_date),
            transactions_type = trim(lower(p_transaction.transactions_type)),
            amount            = trim(p_transaction.amount),
            customer_id       = trim(p_transaction.customer_id),
            equity_id         = trim(p_transaction.equity_id),
            mf_id             = trim(p_transaction.mf_id),
            insurance_id      = trim(p_transaction.insurance_id)
        where transaction_id = trim(p_transaction.transaction_id);
    elsif trim(lower(p_operation)) = 'delete' then
        delete
        from transactions
        where transaction_id = trim(p_transaction.transaction_id);
    else
        DBMS_OUTPUT.PUT_LINE('Invalid operation provided. Valid operations are insert, update, and delete.');
    end if;
end;


-- Customer Table Sequence

create sequence customer_seq start with 1 increment by 1 nocache nocycle;

-- Equity_Share Table Sequence

create sequence equity_shares_seq start with 1 increment by 1 nocache nocycle;

-- Equity_Rate Table Sequence

create sequence equity_rate_seq start with 1 increment by 1 nocache nocycle;

-- Finance_Category Table Sequence

create sequence finance_category_seq start with 1 increment by 1 nocache nocycle;

-- MF_Master Table Sequence

create sequence mf_master_seq start with 1 increment by 1 nocache nocycle;

-- MF_Rates Table Sequence

create sequence mf_rates_seq start with 1 increment by 1 nocache nocycle;

-- Insurance_master Table Sequence

create sequence insurance_master_seq start with 1 increment by 1 nocache nocycle;

-- Transactions Table Sequence

create sequence transactions_seq start with 1 increment by 1 nocache nocycle;

-- Customers Table Record Entry
declare
    v_operation varchar2(10) := 'insert';
    v_customer  customers%rowtype;
begin
    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aarav';
    v_customer.last_name := 'Patel';
    v_customer.email := 'aarav.patel@example.com';
    v_customer.phone_number := '9876543210';
    v_customer.address := '123 ABC Street';
    v_customer.city := 'Mumbai';
    v_customer.state := 'Maharashtra';
    v_customer.postal_code := '400001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := CUSTOMER_SEQ.nextval;
    v_customer.first_name := 'Isha';
    v_customer.last_name := 'Sharma';
    v_customer.email := 'isha.sharma@example.com';
    v_customer.phone_number := '9876543211';
    v_customer.address := '456 XYZ Road';
    v_customer.city := 'Delhi';
    v_customer.state := 'Delhi';
    v_customer.postal_code := '110001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Rahul';
    v_customer.last_name := 'Gupta';
    v_customer.email := 'rahul.gupta@example.com';
    v_customer.phone_number := '9876543212';
    v_customer.address := '789 PQR Avenue';
    v_customer.city := 'Kolkata';
    v_customer.state := 'West Bengal';
    v_customer.postal_code := '700001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aishwarya';
    v_customer.last_name := 'Singh';
    v_customer.email := 'aishwarya.singh@example.com';
    v_customer.phone_number := '9876543213';
    v_customer.address := '567 LMN Lane';
    v_customer.city := 'Chennai';
    v_customer.state := 'Tamil Nadu';
    v_customer.postal_code := '600001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Arjun';
    v_customer.last_name := 'Verma';
    v_customer.email := 'arjun.verma@example.com';
    v_customer.phone_number := '9876543214';
    v_customer.address := '321 XYZ Street';
    v_customer.city := 'Bengaluru';
    v_customer.state := 'Karnataka';
    v_customer.postal_code := '560001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Kavya';
    v_customer.last_name := 'Joshi';
    v_customer.email := 'kavya.joshi@example.com';
    v_customer.phone_number := '9876543215';
    v_customer.address := '456 ABC Road';
    v_customer.city := 'Hyderabad';
    v_customer.state := 'Telangana';
    v_customer.postal_code := '500001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Vikram';
    v_customer.last_name := 'Malhotra';
    v_customer.email := 'vikram.malhotra@example.com';
    v_customer.phone_number := '9876543216';
    v_customer.address := '789 PQR Street';
    v_customer.city := 'Jaipur';
    v_customer.state := 'Rajasthan';
    v_customer.postal_code := '302001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Ananya';
    v_customer.last_name := 'Gandhi';
    v_customer.email := 'ananya.gandhi@example.com';
    v_customer.phone_number := '9876543217';
    v_customer.address := '567 LMN Road';
    v_customer.city := 'Ahmedabad';
    v_customer.state := 'Gujarat';
    v_customer.postal_code := '380001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Rohan';
    v_customer.last_name := 'Reddy';
    v_customer.email := 'rohan.reddy@example.com';
    v_customer.phone_number := '9876543218';
    v_customer.address := '321 XYZ Avenue';
    v_customer.city := 'Pune';
    v_customer.state := 'Maharashtra';
    v_customer.postal_code := '411001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Sanaya';
    v_customer.last_name := 'Kumar';
    v_customer.email := 'sanaya.kumar@example.com';
    v_customer.phone_number := '9876543219';
    v_customer.address := '456 ABC Lane';
    v_customer.city := 'Surat';
    v_customer.state := 'Gujarat';
    v_customer.postal_code := '395001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aditya';
    v_customer.last_name := 'Chopra';
    v_customer.email := 'aditya.chopra@example.com';
    v_customer.phone_number := '9876543220';
    v_customer.address := '789 PQR Lane';
    v_customer.city := 'Lucknow';
    v_customer.state := 'Uttar Pradesh';
    v_customer.postal_code := '226001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Sakshi';
    v_customer.last_name := 'Rao';
    v_customer.email := 'sakshi.rao@example.com';
    v_customer.phone_number := '9876543221';
    v_customer.address := '567 LMN Street';
    v_customer.city := 'Nagpur';
    v_customer.state := 'Maharashtra';
    v_customer.postal_code := '440001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Vishal';
    v_customer.last_name := 'Khanna';
    v_customer.email := 'vishal.khanna@example.com';
    v_customer.phone_number := '9876543222';
    v_customer.address := '321 XYZ Road';
    v_customer.city := 'Indore';
    v_customer.state := 'Madhya Pradesh';
    v_customer.postal_code := '452001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aditi';
    v_customer.last_name := 'Shah';
    v_customer.email := 'aditi.shah@example.com';
    v_customer.phone_number := '9876543223';
    v_customer.address := '456 ABC Street';
    v_customer.city := 'Bhopal';
    v_customer.state := 'Madhya Pradesh';
    v_customer.postal_code := '462001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Rishi';
    v_customer.last_name := 'Mehta';
    v_customer.email := 'rishi.mehta@example.com';
    v_customer.phone_number := '9876543224';
    v_customer.address := '789 PQR Road';
    v_customer.city := 'Amritsar';
    v_customer.state := 'Punjab';
    v_customer.postal_code := '143001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Diya';
    v_customer.last_name := 'Rajput';
    v_customer.email := 'diya.rajput@example.com';
    v_customer.phone_number := '9876543225';
    v_customer.address := '567 LMN Avenue';
    v_customer.city := 'Coimbatore';
    v_customer.state := 'Tamil Nadu';
    v_customer.postal_code := '641001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Arnav';
    v_customer.last_name := 'Biswas';
    v_customer.email := 'arnav.biswas@example.com';
    v_customer.phone_number := '9876543226';
    v_customer.address := '321 XYZ Lane';
    v_customer.city := 'Vadodara';
    v_customer.state := 'Gujarat';
    v_customer.postal_code := '390001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Jiya';
    v_customer.last_name := 'Chatterjee';
    v_customer.email := 'jiya.chatterjee@example.com';
    v_customer.phone_number := '9876543227';
    v_customer.address := '456 ABC Road';
    v_customer.city := 'Visakhapatnam';
    v_customer.state := 'Andhra Pradesh';
    v_customer.postal_code := '530001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Rohan';
    v_customer.last_name := 'Srivastava';
    v_customer.email := 'rohan.srivastava@example.com';
    v_customer.phone_number := '9876543228';
    v_customer.address := '789 PQR Lane';
    v_customer.city := 'Patna';
    v_customer.state := 'Bihar';
    v_customer.postal_code := '800001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Sia';
    v_customer.last_name := 'Sharma';
    v_customer.email := 'sia.sharma@example.com';
    v_customer.phone_number := '9876543229';
    v_customer.address := '567 LMN Street';
    v_customer.city := 'Kochi';
    v_customer.state := 'Kerala';
    v_customer.postal_code := '682001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aryan';
    v_customer.last_name := 'Mukherjee';
    v_customer.email := 'aryan.mukherjee@example.com';
    v_customer.phone_number := '9876543230';
    v_customer.address := '321 XYZ Road';
    v_customer.city := 'Guwahati';
    v_customer.state := 'Assam';
    v_customer.postal_code := '781001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Aanya';
    v_customer.last_name := 'Sharma';
    v_customer.email := 'aanya.sharma@example.com';
    v_customer.phone_number := '9876543231';
    v_customer.address := '456 ABC Street';
    v_customer.city := 'Jodhpur';
    v_customer.state := 'Rajasthan';
    v_customer.postal_code := '342001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Rajat';
    v_customer.last_name := 'Gupta';
    v_customer.email := 'rajat.gupta@example.com';
    v_customer.phone_number := '9876543232';
    v_customer.address := '789 PQR Avenue';
    v_customer.city := 'Raipur';
    v_customer.state := 'Chhattisgarh';
    v_customer.postal_code := '492001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Ananya';
    v_customer.last_name := 'Das';
    v_customer.email := 'ananya.das@example.com';
    v_customer.phone_number := '9876543233';
    v_customer.address := '567 LMN Lane';
    v_customer.city := 'Guwahati';
    v_customer.state := 'Assam';
    v_customer.postal_code := '781001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);

    v_customer.customer_id := customer_seq.nextval;
    v_customer.first_name := 'Kabir';
    v_customer.last_name := 'Bhatia';
    v_customer.email := 'kabir.bhatia@example.com';
    v_customer.phone_number := '9876543234';
    v_customer.address := '321 XYZ Street';
    v_customer.city := 'Agra';
    v_customer.state := 'Uttar Pradesh';
    v_customer.postal_code := '282001';
    v_customer.country := 'India';
    manage_customer(v_operation, v_customer);
end;


-- Finance_category table record entry

declare
    v_operation varchar2(10) := 'insert';
    v_category  finance_category%rowtype;
begin
    v_category.category_id := finance_category_seq.nextval;
    v_category.category_name := 'Mutual Funds';
    manage_finance_category(v_operation, v_category);

    v_category.category_id := finance_category_seq.nextval;
    v_category.category_name := 'Stocks';
    manage_finance_category(v_operation, v_category);

    v_category.category_id := finance_category_seq.nextval;
    v_category.category_name := 'Bonds';
    manage_finance_category(v_operation, v_category);

    v_category.category_id := finance_category_seq.nextval;
    v_category.category_name := 'Venture Capital';
    manage_finance_category(v_operation, v_category);

    v_category.category_id := finance_category_seq.nextval;
    v_category.category_name := 'Systematic Investment Plan (SIP)';
    manage_finance_category(v_operation, v_category);
end;


-- Equity_shares table record entry

declare
    v_operation varchar2(10) := 'insert';
    v_equity    equity_shares%rowtype;
begin
    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Reliance Industries';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 100;
    v_equity.purchase_date := TO_DATE('2021-01-05', 'YYYY-MM-DD');
    v_equity.purchase_price := 2000.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'HDFC Bank';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 50;
    v_equity.purchase_date := TO_DATE('2021-11-12', 'YYYY-MM-DD');
    v_equity.purchase_price := 1500.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Tata Motors';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 75;
    v_equity.purchase_date := TO_DATE('2021-03-20', 'YYYY-MM-DD');
    v_equity.purchase_price := 1200.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'ICICI Bank';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 80;
    v_equity.purchase_date := TO_DATE('2021-06-10', 'YYYY-MM-DD');
    v_equity.purchase_price := 1800.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'SBI';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 120;
    v_equity.purchase_date := TO_DATE('2021-08-15', 'YYYY-MM-DD');
    v_equity.purchase_price := 1000.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Hindustan Unilever';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 40;
    v_equity.purchase_date := TO_DATE('2021-04-02', 'YYYY-MM-DD');
    v_equity.purchase_price := 2500.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Infosys';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 60;
    v_equity.purchase_date := TO_DATE('2021-02-18', 'YYYY-MM-DD');
    v_equity.purchase_price := 3000.00;
    manage_equity_share(v_operation, v_equity);

    -- Equity 8
    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'ITC';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 90;
    v_equity.purchase_date := TO_DATE('2021-07-30', 'YYYY-MM-DD');
    v_equity.purchase_price := 1100.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Axis Bank';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 55;
    v_equity.purchase_date := TO_DATE('2021-12-23', 'YYYY-MM-DD');
    v_equity.purchase_price := 1700.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Bharti Airtel';
    v_equity.equity_category_id := 2;
    v_equity.quantity := 70;
    v_equity.purchase_date := TO_DATE('2021-09-08', 'YYYY-MM-DD');
    v_equity.purchase_price := 1900.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'HDFC Mutual Fund';
    v_equity.equity_category_id := 1;
    v_equity.quantity := 1000;
    v_equity.purchase_date := TO_DATE('2021-03-05', 'YYYY-MM-DD');
    v_equity.purchase_price := 25.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'SBI Mutual Fund';
    v_equity.equity_category_id := 1;
    v_equity.quantity := 500;
    v_equity.purchase_date := TO_DATE('2021-11-10', 'YYYY-MM-DD');
    v_equity.purchase_price := 30.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Aditya Birla Sun Life Mutual Fund';
    v_equity.equity_category_id := 1;
    v_equity.quantity := 800;
    v_equity.purchase_date := TO_DATE('2021-07-15', 'YYYY-MM-DD');
    v_equity.purchase_price := 28.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'ICICI Prudential Mutual Fund';
    v_equity.equity_category_id := 1;
    v_equity.quantity := 600;
    v_equity.purchase_date := TO_DATE('2021-06-20', 'YYYY-MM-DD');
    v_equity.purchase_price := 26.00;
    manage_equity_share(v_operation, v_equity);

    v_equity.equity_id := equity_shares_seq.nextval;
    v_equity.equity_name := 'Franklin Templeton Mutual Fund';
    v_equity.equity_category_id := 1;
    v_equity.quantity := 400;
    v_equity.purchase_date := TO_DATE('2021-09-30', 'YYYY-MM-DD');
    v_equity.purchase_price := 27.00;
    manage_equity_share(v_operation, v_equity);
end;


-- equity_rate table record entry
declare
    v_operation   varchar2(10) := 'insert';
    v_equity_rate equity_rate%ROWTYPE;
begin
    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 1;
    v_equity_rate.rate_date := TO_DATE('2021-01-05', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1999.50;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 1;
    v_equity_rate.rate_date := TO_DATE('2021-01-06', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 2001.20;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 1;
    v_equity_rate.rate_date := TO_DATE('2021-01-07', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1995.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 2;
    v_equity_rate.rate_date := TO_DATE('2021-11-12', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1500.75;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 2;
    v_equity_rate.rate_date := TO_DATE('2021-11-13', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1502.10;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 2;
    v_equity_rate.rate_date := TO_DATE('2021-11-14', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1600.30;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 3;
    v_equity_rate.rate_date := TO_DATE('2021-03-20', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1199.25;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 3;
    v_equity_rate.rate_date := TO_DATE('2021-03-21', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1201.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 3;
    v_equity_rate.rate_date := TO_DATE('2021-03-22', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1195.50;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 4;
    v_equity_rate.rate_date := TO_DATE('2021-06-10', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1799.90;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 4;
    v_equity_rate.rate_date := TO_DATE('2021-06-11', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1802.70;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 4;
    v_equity_rate.rate_date := TO_DATE('2021-06-12', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1850.10;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 5;
    v_equity_rate.rate_date := TO_DATE('2021-08-15', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 999.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 5;
    v_equity_rate.rate_date := TO_DATE('2021-08-16', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1002.40;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 5;
    v_equity_rate.rate_date := TO_DATE('2021-08-17', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1548.90;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 6;
    v_equity_rate.rate_date := TO_DATE('2021-04-02', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 2499.10;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 6;
    v_equity_rate.rate_date := TO_DATE('2021-04-03', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 2501.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 6;
    v_equity_rate.rate_date := TO_DATE('2021-04-04', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 2496.70;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 7;
    v_equity_rate.rate_date := TO_DATE('2021-02-18', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 2999.25;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 7;
    v_equity_rate.rate_date := TO_DATE('2021-02-19', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 3002.10;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 7;
    v_equity_rate.rate_date := TO_DATE('2021-02-20', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 3500.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 8;
    v_equity_rate.rate_date := TO_DATE('2021-07-30', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1099.50;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 8;
    v_equity_rate.rate_date := TO_DATE('2021-07-31', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1102.20;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 8;
    v_equity_rate.rate_date := TO_DATE('2021-08-01', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1095.70;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 9;
    v_equity_rate.rate_date := TO_DATE('2021-12-23', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1699.80;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 9;
    v_equity_rate.rate_date := TO_DATE('2021-12-24', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1702.40;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 9;
    v_equity_rate.rate_date := TO_DATE('2021-12-25', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1698.90;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 10;
    v_equity_rate.rate_date := TO_DATE('2021-09-08', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1899.25;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 10;
    v_equity_rate.rate_date := TO_DATE('2021-09-09', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1902.10;
    manage_equity_rate(v_operation, v_equity_rate);

    v_equity_rate.rate_id := equity_rate_seq.nextval;
    v_equity_rate.equity_id := 10;
    v_equity_rate.rate_date := TO_DATE('2021-09-10', 'YYYY-MM-DD');
    v_equity_rate.closing_price := 1895.80;
    manage_equity_rate(v_operation, v_equity_rate);

end;

-- insurance_master table record entry

declare
    v_operation varchar2(10) := 'insert';
    v_insurance insurance_master%ROWTYPE;
begin
    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL001';
    v_insurance.insurance_type := 'Life Insurance';
    v_insurance.premium_amount := '5000';
    v_insurance.start_date := to_date('2023-06-01', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-01', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL002';
    v_insurance.insurance_type := 'Health Insurance';
    v_insurance.premium_amount := '3000';
    v_insurance.start_date := to_date('2023-05-15', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-15', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL003';
    v_insurance.insurance_type := 'Car Insurance';
    v_insurance.premium_amount := '2500';
    v_insurance.start_date := to_date('2023-06-03', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-03', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL004';
    v_insurance.insurance_type := 'Home Insurance';
    v_insurance.premium_amount := '4000';
    v_insurance.start_date := to_date('2023-05-20', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-20', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL005';
    v_insurance.insurance_type := 'Travel Insurance';
    v_insurance.premium_amount := '3500';
    v_insurance.start_date := to_date('2023-06-07', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-07', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL006';
    v_insurance.insurance_type := 'Life Insurance';
    v_insurance.premium_amount := '5000';
    v_insurance.start_date := to_date('2023-06-01', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-01', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL007';
    v_insurance.insurance_type := 'Health Insurance';
    v_insurance.premium_amount := '3000';
    v_insurance.start_date := to_date('2023-05-15', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-15', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL008';
    v_insurance.insurance_type := 'Car Insurance';
    v_insurance.premium_amount := '2500';
    v_insurance.start_date := to_date('2023-06-03', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-03', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL009';
    v_insurance.insurance_type := 'Home Insurance';
    v_insurance.premium_amount := '4000';
    v_insurance.start_date := to_date('2023-05-20', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-20', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL010';
    v_insurance.insurance_type := 'Travel Insurance';
    v_insurance.premium_amount := '3500';
    v_insurance.start_date := to_date('2023-06-07', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-07', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL011';
    v_insurance.insurance_type := 'Life Insurance';
    v_insurance.premium_amount := '5000';
    v_insurance.start_date := to_date('2023-06-01', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-01', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL012';
    v_insurance.insurance_type := 'Health Insurance';
    v_insurance.premium_amount := '3000';
    v_insurance.start_date := to_date('2023-05-15', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-15', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL013';
    v_insurance.insurance_type := 'Car Insurance';
    v_insurance.premium_amount := '2500';
    v_insurance.start_date := to_date('2023-06-03', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-03', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL014';
    v_insurance.insurance_type := 'Home Insurance';
    v_insurance.premium_amount := '4000';
    v_insurance.start_date := to_date('2023-05-20', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-05-20', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);

    v_insurance.insurance_id := insurance_master_seq.nextval;
    v_insurance.policy_number := 'POL015';
    v_insurance.insurance_type := 'Travel Insurance';
    v_insurance.premium_amount := '3500';
    v_insurance.start_date := to_date('2023-06-07', 'YYYY-MM-DD');
    v_insurance.end_date := to_date('2024-06-07', 'YYYY-MM-DD');
    manage_insurance_master(v_operation, v_insurance);
end;

-- mf_master table record entry

declare
    v_operation varchar2(10) := 'insert';
    v_mf        mf_master%ROWTYPE;
begin
    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'Reliance Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'Reliance';
    v_mf.inception_date := TO_DATE('2003-12-30', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'HDFC Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'HDFC';
    v_mf.inception_date := TO_DATE('1999-06-30', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'SBI Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'SBI';
    v_mf.inception_date := TO_DATE('1987-06-29', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'Axis Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'Axis';
    v_mf.inception_date := TO_DATE('2009-01-13', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'Tata Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'Tata';
    v_mf.inception_date := TO_DATE('1995-06-30', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'Aditya Birla Sun Life Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'Aditya Birla Sun Life';
    v_mf.inception_date := TO_DATE('1994-08-23', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'ICICI Prudential Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'ICICI Prudential';
    v_mf.inception_date := TO_DATE('1993-10-13', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'Kotak Mahindra Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'Kotak Mahindra';
    v_mf.inception_date := TO_DATE('1998-06-23', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'L&T Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'L&T';
    v_mf.inception_date := TO_DATE('1997-01-03', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);

    v_mf.mf_id := mf_master_seq.nextval;
    v_mf.mf_name := 'UTI Mutual Fund';
    v_mf.mf_category_id := 1;
    v_mf.fund_house := 'UTI';
    v_mf.inception_date := TO_DATE('2003-02-03', 'YYYY-MM-DD');
    manage_mf_master(v_operation, v_mf);
end;

-- mf_rates table record entry

declare
    v_operation varchar2(10) := 'insert';
    v_mf        mf_rates%ROWTYPE;
begin
    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 1;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 2300;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 2;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 800;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 3;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 1500;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 4;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 1292;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 5;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 1256;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 6;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 1830;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 7;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 1484;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 8;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 3648;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 9;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 516;
    manage_mf_rates(v_operation, v_mf);

    v_mf.rate_id := mf_rates_seq.nextval;
    v_mf.mf_id := 10;
    v_mf.rate_date := to_date('2023-06-01', 'yyyy-mm-dd');
    v_mf.nav := 979;
    manage_mf_rates(v_operation, v_mf);
end;


-- Transaction table record entry

declare
    v_operation    varchar2(10) := 'insert';
    v_transactions transactions%ROWTYPE;
begin
    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-01-05', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 200000.00;
    v_transactions.customer_id := 1;
    v_transactions.equity_id := 1;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-11-12', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 75000.00;
    v_transactions.customer_id := 2;
    v_transactions.equity_id := 2;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-03-20', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 90000.00;
    v_transactions.customer_id := 3;
    v_transactions.equity_id := 3;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-06-10', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 144000.00;
    v_transactions.customer_id := 4;
    v_transactions.equity_id := 4;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-08-15', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 120000.00;
    v_transactions.customer_id := 5;
    v_transactions.equity_id := 5;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-04-02', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 100000.00;
    v_transactions.customer_id := 6;
    v_transactions.equity_id := 6;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-02-18', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 180000.00;
    v_transactions.customer_id := 7;
    v_transactions.equity_id := 7;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-12-23', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'buy';
    v_transactions.amount := 93500.00;
    v_transactions.customer_id := 7;
    v_transactions.equity_id := 9;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-01-06', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'sell';
    v_transactions.amount := 210520.00;
    v_transactions.customer_id := 1;
    v_transactions.equity_id := 1;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-03-22', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'sell';
    v_transactions.amount := 88500.00;
    v_transactions.customer_id := 3;
    v_transactions.equity_id := 3;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);

    v_transactions.transaction_id := transactions_seq.nextval;
    v_transactions.transactions_date := TO_DATE('2021-02-18', 'yyyy-mm-dd');
    v_transactions.transactions_type := 'sell';
    v_transactions.amount := 189540.00;
    v_transactions.customer_id := 7;
    v_transactions.equity_id := 7;
    v_transactions.mf_id := NULL;
    v_transactions.insurance_id := NULL;
    manage_transaction(v_operation, v_transactions);
end;

-- Transactionlist procedure

create or replace type transaction_record as object
(
    transaction_id    number,
    transactions_date date,
    transactions_type varchar2(50),
    amount            number,
    first_name        varchar2(50),
    last_name         varchar2(50),
    email             varchar2(100),
    phone_number      varchar2(20)
);

create or replace procedure transactionlist(
    p_customer_id in customers.customer_id%type default null,
    p_transaction_type in transactions.transactions_type%type default null,
    p_result out sys_refcursor
) is
begin
    open p_result for
        select transaction_record(
                       t.transaction_id,
                       t.transactions_date,
                       t.transactions_type,
                       t.amount,
                       c.first_name,
                       c.last_name,
                       c.email,
                       c.phone_number
                   )
        from transactions t
                 join customers c on t.customer_id = c.customer_id
        where (p_customer_id is null or c.customer_id = p_customer_id)
          and (p_transaction_type is null or t.transactions_type = p_transaction_type);
end;

var rc refcursor;
execute transactionlist(p_result=>:rc);
print rc;

-- Generate portfolio report procedure

create or replace procedure generate_portfolio_report(p_cursor out sys_refcursor) as
begin
    open p_cursor for
        select c.customer_id,
               c.first_name,
               c.last_name,
               sum(case
                       when t.transactions_type = 'buy' and t.equity_id is not null then t.amount
                       else 0
                   end) as total_investment_amount_equity,
               sum(case
                       when t.transactions_type = 'buy' and t.mf_id is not null then t.amount
                       else 0
                   end) as total_investment_amount_mf,
               sum(case
                       when t.transactions_type = 'buy' and t.insurance_id is not null then t.amount
                       else 0
                   end) as total_investment_amount_insurance,
               sum(case
                       when t.transactions_type = 'buy' then t.amount
                       else 0
                   end) as total_investment_amount
        from customers c
                 left join transactions t on c.customer_id = t.customer_id
                 left join equity_shares eq on t.equity_id = eq.equity_id
                 left join mf_master mf on t.mf_id = mf.mf_id
                 left join insurance_master im on t.insurance_id = im.insurance_id
        where t.equity_id is not null
           or t.mf_id is not null
           or t.insurance_id is not null
        group by c.customer_id,
                 c.first_name,
                 c.last_name
        order by total_investment_amount desc;
end;


var rc refcursor;
exec generate_portfolio_report(p_cursor => :rc);
print rc;

-- Get_Equity_Details Procedure

create or replace procedure get_equity_details(
    p_customer_id in number,
    p_cursor out sys_refcursor
) is
begin
    open p_cursor for
        select es.equity_name,
               es.quantity                                          as quantity,
               (t.amount / es.quantity)                             as avg_cost,
               er.closing_price                                     as last_trading_price,
               t.amount                                             as invested_amount,
               (er.closing_price - es.purchase_price) * es.quantity as profit_loss,
               ((er.closing_price - es.purchase_price) * es.quantity) / (es.purchase_price * es.quantity) *
               100                                                  as net_change
        from equity_shares es
                 join (select er.equity_id, max(er.rate_date) as max_rate_date
                       from equity_rate er
                       group by er.equity_id) er_max on er_max.equity_id = es.equity_id
                 join equity_rate er on er.equity_id = es.equity_id and er.rate_date = er_max.max_rate_date
                 left join (select equity_id
                            from transactions
                            where customer_id = p_customer_id
                              and transactions_type = 'sell') t_sell on t_sell.equity_id = es.equity_id
                 left join transactions t on t.equity_id = es.equity_id
            and t.customer_id = p_customer_id
            and t.transactions_type = 'buy'
        where t.customer_id = p_customer_id
          and t.equity_id is not null
          and t_sell.equity_id is null;
end;

var rc refcursor;
exec get_equity_details(p_customer_id => 1,p_cursor => :rc);
print rc;

-- Get_Sold_Equity_Details Procedure

create or replace procedure get_sold_equity_details(
    p_customer_id in number,
    p_cursor out sys_refcursor
) is
begin
    open p_cursor for
        select es.equity_name,
               es.quantity                                               as quantity,
               (t_buy.amount / es.quantity)                              as avg_cost,
               er_sell.closing_price                                     as last_trading_price,
               t_buy.amount                                              as invested_amount,
               (er_sell.closing_price - es.purchase_price) * es.quantity as profit_loss,
               ((er_sell.closing_price - es.purchase_price) * es.quantity) / (es.purchase_price * es.quantity) *
               100                                                       as net_change
        from equity_shares es
                 join (select equity_id
                       from transactions
                       where customer_id = p_customer_id
                         and transactions_type = 'buy') sold_equities on sold_equities.equity_id = es.equity_id
                 join (select equity_id, max(rate_date) as max_sell_date
                       from equity_rate
                       where equity_id in (select equity_id
                                           from transactions
                                           where customer_id = p_customer_id
                                             and transactions_type = 'sell')
                       group by equity_id) er_sell_max on er_sell_max.equity_id = es.equity_id
                 join equity_rate er_sell
                      on er_sell.equity_id = es.equity_id and er_sell.rate_date = er_sell_max.max_sell_date
                 join transactions t_buy on t_buy.equity_id = es.equity_id
            and t_buy.customer_id = p_customer_id
            and t_buy.transactions_type = 'buy'
        where exists (select 1
                      from transactions
                      where equity_id = es.equity_id
                        and customer_id = p_customer_id
                        and transactions_type = 'sell');
end;

var rc refcursor;
exec get_sold_equity_details(p_customer_id => 1,p_cursor => :rc);
print rc;


-- get_customer_equity_details procedure

create or replace procedure get_customer_equity_details(
    p_cursor out sys_refcursor
) is
begin
    open p_cursor for
        select c.customer_id,
               c.first_name,
               c.last_name,
               es.equity_name,
               es.quantity                                          as num_shares,
               es.purchase_price                                    as avg_cost,
               er.closing_price                                     as last_price,
               es.quantity * es.purchase_price                      as invested_amount,
               (er.closing_price - es.purchase_price) * es.quantity as profit_loss,
               round(((er.closing_price - es.purchase_price) * es.quantity) / (es.purchase_price * es.quantity) * 100,
                     2)                                             as net_change
        from customers c
                 join transactions t on c.customer_id = t.customer_id
                 join equity_shares es on t.equity_id = es.equity_id
                 join (select equity_id, max(rate_date) as max_rate_date
                       from equity_rate
                       group by equity_id) er_max on er_max.equity_id = es.equity_id
                 join equity_rate er on er.equity_id = es.equity_id and er.rate_date = er_max.max_rate_date
        where t.transactions_type = 'buy'
        group by c.customer_id, c.first_name, c.last_name, es.equity_name, es.quantity, es.purchase_price,
                 er.closing_price
        having sum(t.amount) = sum(es.quantity * es.purchase_price)
        order by c.customer_id;
end;

var rc refcursor;
exec get_customer_equity_details(p_cursor => :rc);
print rc;

create or replace view get_customer_equity_view as
select c.customer_id,
       c.first_name,
       c.last_name,
       es.equity_name,
       es.quantity                                          as num_shares,
       es.purchase_price                                    as avg_cost,
       er.closing_price                                     as last_price,
       es.quantity * es.purchase_price                      as invested_amount,
       (er.closing_price - es.purchase_price) * es.quantity as profit_loss,
       round(((er.closing_price - es.purchase_price) * es.quantity) / (es.purchase_price * es.quantity) * 100, 2) as net_change
from customers c
         join transactions t on c.customer_id = t.customer_id
         join equity_shares es on t.equity_id = es.equity_id
         join (select equity_id, max(rate_date) as max_rate_date
               from equity_rate
               group by equity_id) er_max on er_max.equity_id = es.equity_id
         join equity_rate er on er.equity_id = es.equity_id and er.rate_date = er_max.max_rate_date
where t.transactions_type = 'buy'
group by c.customer_id, c.first_name, c.last_name, es.equity_name, es.quantity, es.purchase_price, er.closing_price
having sum(t.amount) = sum(es.quantity * es.purchase_price)
order by c.customer_id;
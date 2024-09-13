-- Contact us for help: githubsupport@l1ve709.com

CREATE TABLE Sales (
    ProductName VARCHAR(50),  -- Column for the product name
    SaleYear INT,             -- Column for the year of the sale
    SaleAmount DECIMAL(10, 2) -- Column for the sale amount
);

INSERT INTO Sales (ProductName, SaleYear, SaleAmount) VALUES
('Product A', 2021, 1500.00), 
('Product B', 2021, 2300.00),
('Product A', 2022, 1800.00),
('Product B', 2022, 2500.00),
('Product C', 2023, 1700.00),
('Product A', 2023, 2000.00),
('Product B', 2023, 2100.00),
('Product C', 2024, 1950.00);

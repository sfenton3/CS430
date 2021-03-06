--Problem 6 of Chapter 4
SELECT gl.account_number, account_description
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items li
  ON gl.account_number = li.account_number
WHERE li.account_number IS NULL
ORDER BY gl.account_number;

--Problem 3 of Chapter 6
SELECT account_number, account_description
FROM general_ledger_accounts
WHERE NOT EXISTS
    (SELECT *
     FROM invoice_line_items
     WHERE invoice_line_items.account_number = general_ledger_accounts.account_number)
ORDER BY account_number;

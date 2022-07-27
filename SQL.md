# Query 1 do desafio de Banco de dados
``` sql
CREATE TABLE accounts(
    id serial PRIMARY KEY,
	agency INTEGER NOT NULL,
    account INTEGER NOT NULL
);

CREATE TABLE entries(
	id serial PRIMARY KEY,
	amount NUMERIC(20, 2) NOT NULL CHECK (amount > 0.0),
	deposit INTEGER NOT NULL REFERENCES accounts(id) ON DELETE RESTRICT,
	withdraw INTEGER NOT NULL REFERENCES accounts(id) ON DELETE RESTRICT,
    transference INTEGER NOT NULL REFERENCES accounts(id) ON DELETE RESTRICT
);

CREATE INDEX ON entries(deposit);
CREATE INDEX ON entries(withdraw);
CREATE INDEX ON entries(transference);

CREATE VIEW account_ledgers(
	account_id,
	entry_id,
	amount
) AS
	SELECT
		entries.deposit,
		entries.id,
		entries.amount
	FROM
		entries
	UNION ALL
	SELECT
		entries.withdraw,
		entries.id,
		entries.amount
	FROM
		entries
    UNION ALL
	SELECT
		entries.transference,
		entries.id,
		entries.amount
	FROM
		entries;


CREATE MATERIALIZED VIEW account_balances(
	id,
	balance
) AS
	SELECT
		accounts.id,
		COALESCE(sum(account_ledgers.amount), 0.0)
	FROM
		accounts
		LEFT OUTER JOIN account_ledgers
		ON accounts.id = account_ledgers.account_id
	GROUP BY accounts.id;

CREATE UNIQUE INDEX ON account_balances(id);

CREATE FUNCTION update_balances() RETURNS TRIGGER AS $$
BEGIN
	REFRESH MATERIALIZED VIEW account_balances;
	RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_fix_balance_entries
AFTER INSERT 
OR UPDATE OF amount, deposit, withdraw, transference 
OR DELETE OR TRUNCATE
ON entries
FOR EACH STATEMENT
EXECUTE PROCEDURE update_balances();

CREATE TRIGGER trigger_fix_balance_accounts
AFTER INSERT 
OR UPDATE OF id 
OR DELETE OR TRUNCATE
ON accounts
FOR EACH STATEMENT
EXECUTE PROCEDURE update_balances();
```

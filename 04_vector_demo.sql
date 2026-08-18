INSERT INTO truthlock_vector_memories
(subject, claim, version, status, authority, embedding)
VALUES
('SUPPLIER:NOVA', 'Supplier NOVA is approved for payments up to $50,000.', 17, 'SUPERSEDED', 'FINANCE_POLICY', '[0.95, 0.10, 0.05]'),
('SUPPLIER:NOVA', 'Supplier NOVA is suspended. All payments are prohibited.', 18, 'ACTIVE', 'SECURITY_OVERRIDE', '[0.92, 0.15, 0.08]'),
('SUPPLIER:ORION', 'Supplier ORION is approved for routine purchases.', 4, 'ACTIVE', 'FINANCE_POLICY', '[0.10, 0.90, 0.10]');

SELECT subject, claim, version, status, authority,
       embedding <=> '[0.94, 0.12, 0.06]' AS cosine_distance
FROM truthlock_vector_memories
ORDER BY embedding <=> '[0.94, 0.12, 0.06]'
LIMIT 3;

INSERT INTO truthlock_memories
(subject, claim, version, status, authority, confidence)
VALUES
('SUPPLIER:NOVA', 'Supplier NOVA is approved for payments up to $50,000.', 17, 'ACTIVE', 'FINANCE_POLICY', 0.9900);

UPDATE truthlock_memories
SET status = 'SUPERSEDED', valid_until = now()
WHERE subject = 'SUPPLIER:NOVA' AND version = 17;

INSERT INTO truthlock_memories
(subject, claim, version, status, authority, valid_from, supersedes, confidence)
SELECT 'SUPPLIER:NOVA',
       'Supplier NOVA is suspended. All payments are prohibited.',
       18, 'ACTIVE', 'SECURITY_OVERRIDE', now(), memory_id, 1.0000
FROM truthlock_memories
WHERE subject = 'SUPPLIER:NOVA' AND version = 17
ORDER BY created_at DESC
LIMIT 1;

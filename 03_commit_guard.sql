WITH current_truth AS (
    SELECT version, claim, status, authority
    FROM truthlock_memories
    WHERE subject = 'SUPPLIER:NOVA' AND status = 'ACTIVE'
    ORDER BY version DESC
    LIMIT 1
)
SELECT 'PAY $28,500 TO NOVA' AS proposed_action,
       17 AS retrieved_memory_version,
       version AS current_truth_version,
       CASE WHEN 17 = version THEN 'MEMORY VALID' ELSE 'STALE MEMORY DETECTED' END AS truthlock_result,
       CASE WHEN 17 = version THEN 'ALLOW ACTION' ELSE 'BLOCK ACTION' END AS decision,
       authority AS current_authority,
       claim AS current_truth
FROM current_truth;

INSERT INTO truthlock_executed_actions
(subject, action_type, amount, retrieved_memory_version, committed_truth_version, status)
SELECT 'SUPPLIER:NOVA', 'PAYMENT', 28500.00, 17, version, 'COMMITTED'
FROM (
    SELECT version FROM truthlock_memories
    WHERE subject = 'SUPPLIER:NOVA' AND status = 'ACTIVE'
    ORDER BY version DESC LIMIT 1
) AS current_truth
WHERE version = 17;

SELECT COUNT(*) AS executed_payments,
       CASE WHEN COUNT(*) = 0 THEN 'TRUTHLOCK BLOCKED THE UNSAFE ACTION'
            ELSE 'WARNING: ACTION WAS COMMITTED' END AS protection_result
FROM truthlock_executed_actions
WHERE subject = 'SUPPLIER:NOVA' AND action_type = 'PAYMENT' AND amount = 28500.00;

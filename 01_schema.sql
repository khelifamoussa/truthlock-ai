CREATE TABLE IF NOT EXISTS truthlock_memories (
    memory_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject STRING NOT NULL,
    claim STRING NOT NULL,
    version INT NOT NULL,
    status STRING NOT NULL,
    authority STRING NOT NULL,
    valid_from TIMESTAMPTZ NOT NULL DEFAULT now(),
    valid_until TIMESTAMPTZ NULL,
    supersedes UUID NULL,
    confidence DECIMAL(5,4) DEFAULT 1.0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS truthlock_executed_actions (
    action_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject STRING NOT NULL,
    action_type STRING NOT NULL,
    amount DECIMAL(18,2),
    retrieved_memory_version INT NOT NULL,
    committed_truth_version INT NOT NULL,
    status STRING NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS truthlock_vector_memories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject STRING NOT NULL,
    claim STRING NOT NULL,
    version INT NOT NULL,
    status STRING NOT NULL,
    authority STRING NOT NULL,
    embedding VECTOR(3) NOT NULL,
    VECTOR INDEX truthlock_memory_vector_idx (embedding vector_cosine_ops)
);

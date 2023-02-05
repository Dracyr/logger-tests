CREATE TABLE log_entries (
  time TIMESTAMPTZ NOT NULL,
  service_name TEXT NOT NULL,
  severity TEXT NOT NULL DEFAULT 'INFO',
  body TEXT NOT NULL,
  attributes JSONB DEFAULT '{}',
  resource JSONB DEFAULT '{}'
);

SELECT create_hypertable('log_entries','time');
CREATE INDEX ix_log_entries_time ON log_entries (service_name, time DESC);

ALTER TABLE log_entries SET (
  timescaledb.compress,
  timescaledb.compress_orderby = 'time DESC',
  timescaledb.compress_segmentby = 'service_name'
);

SELECT add_compression_policy('log_entries', INTERVAL '2 weeks');

SELECT add_retention_policy('log_entries', INTERVAL '3 months');

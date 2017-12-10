-include("trees.hrl").
-include("pow.hrl").

-define(PROTOCOL_VERSION, 2).

-define(GENESIS_VERSION, 2).
-define(GENESIS_HEIGHT, 0).
%% possibly the below value could be generated during the initial make process.
-define(GENESIS_ACCOUNTS, [{<<4,164,145,39,164,111,6,69,33,91,157,75,215,155,52,191,82,242,133,178,209,102,119,68,241,19,64,91,45,193,142,137,233,115,6,111,251,188,145,97,132,57,235,187,251,203,102,145,51,8,53,38,38,238,123,199,240,123,148,139,95,119,164,2,183>>,100000000000001}]).

-define(BLOCK_HEADER_HASH_BYTES, 32).
-define(TXS_HASH_BYTES, 32).
-define(STATE_HASH_BYTES, 32).

-define(ACCEPTED_FUTURE_BLOCK_TIME_SHIFT, 30 * 60 * 1000). %% 30 min

-define(STORAGE_TYPE_BLOCK,  0).
-define(STORAGE_TYPE_HEADER, 1).
-define(STORAGE_TYPE_STATE,  2).

-type(block_header_hash() :: <<_:(?BLOCK_HEADER_HASH_BYTES*8)>>).
-type(txs_hash() :: <<_:(?TXS_HASH_BYTES*8)>>).
-type(state_hash() :: <<_:(?STATE_HASH_BYTES*8)>>).

-record(block, {
          height = 0              :: height(),
          prev_hash = <<0:?BLOCK_HEADER_HASH_BYTES/unit:8>> :: block_header_hash(),
          root_hash = <<0:?STATE_HASH_BYTES/unit:8>> :: state_hash(), % Hash of all state Merkle trees included in #block.trees
          trees = #trees{}        :: trees(),
          txs_hash = <<0:?TXS_HASH_BYTES/unit:8>> :: txs_hash(),
          txs = []                :: list(),
          target = ?HIGHEST_TARGET_SCI :: aec_pow:sci_int(),
          nonce = 0               :: non_neg_integer(),
          time = 0                :: non_neg_integer(),
          version = ?PROTOCOL_VERSION :: non_neg_integer(),
          pow_evidence = no_value :: aec_pow:pow_evidence()}).
-type(block() :: #block{}).

-record(header, {
          height = 0              :: height(),
          prev_hash = <<0:?BLOCK_HEADER_HASH_BYTES/unit:8>> :: block_header_hash(),
          txs_hash = <<0:?TXS_HASH_BYTES/unit:8>> :: txs_hash(),
          root_hash = <<>>        :: binary(),
          target = ?HIGHEST_TARGET_SCI :: aec_pow:sci_int(),
          nonce = 0               :: non_neg_integer(),
          time = 0                :: non_neg_integer(),
          version = ?PROTOCOL_VERSION :: non_neg_integer(),
          pow_evidence = no_value :: aec_pow:pow_evidence()}).
-type(header() :: #header{}).

-type(header_binary() :: binary()).
-type(deterministic_header_binary() :: binary()).

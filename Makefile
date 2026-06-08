.PHONY: install test lint format ingest build train evaluate screen al inverse clean

install:
	pip install -r requirements.txt
	pip install -e .

test:
	pytest tests/ -v --cov=src

lint:
	ruff check src/ tests/ scripts/

format:
	black src/ tests/ scripts/
	ruff check --fix src/ tests/ scripts/

ingest:
	python scripts/ingest_mp.py --config configs/data/mp_default.yaml

build:
	python scripts/build_graphs.py --config configs/data/graphs_default.yaml

train:
	python scripts/train.py --config configs/experiment/cgcnn_baseline.yaml

train-baseline:
	python scripts/train_baseline.py --config configs/experiment/xgb_magpie_baseline.yaml

evaluate:
	python scripts/evaluate.py --run-id $(RUN_ID)

screen:
	python scripts/screen_candidates.py --run-id $(RUN_ID) --top-k 1000

al:
	python scripts/active_learning.py --config configs/experiment/al_bald.yaml

inverse:
	python scripts/inverse_design.py --baseline-run-id $(RUN_ID) --top-k 500

clean:
	rm -rf runs/ wandb/ outputs/ __pycache__ */__pycache__ */*/__pycache__ .pytest_cache

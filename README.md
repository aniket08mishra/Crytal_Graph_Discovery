# Crystal-Graph Materials Discovery Platform

End-to-end materials-AI platform for **formation energy regression**, **uncertainty-aware stability prediction**, and **high-throughput candidate screening** over Materials Project-scale inorganic crystals.

## Highlights

- **Graph Neural Networks**: CGCNN, MEGNet, and ALIGNN-style (angle-aware) message passing on crystal graphs built from `pymatgen` structures.
- **Baselines**: Magpie composition features → Random Forest, XGBoost, Gradient Boosting.
- **Uncertainty**: MC-Dropout and Deep Ensembles, with calibration diagnostics.
- **Stability**: Convex-hull-inspired energy-above-hull ranking and screening.
- **Active learning**: BALD / uncertainty-greedy / random acquisition with retraining loops.
- **Inverse design**: composition generator + property-conditioned screening.
- **MLOps**: YAML-driven configs (Hydra-style), Optuna HPO, Weights & Biases tracking, DVC-friendly data layout, model registry, reproducible CLI scripts, GitHub Actions CI.

## Repo layout

```
crystal-graph-discovery/
├── configs/                  # YAML experiment configs
├── src/
│   ├── data/                 # MP ingestion, splits, datasets
│   ├── features/             # Graph construction, Magpie features
│   ├── models/               # CGCNN, MEGNet, ALIGNN, baselines
│   ├── training/             # Train loop, Optuna HPO, W&B
│   ├── evaluation/           # Metrics, calibration, error-by-chemistry
│   ├── screening/            # Convex hull, candidate ranking
│   ├── active_learning/      # Acquisition + retraining loop
│   ├── inverse_design/       # Composition generator
│   └── utils/                # Seeding, logging, registry
├── scripts/                  # CLI entry points
├── notebooks/                # EDA + analysis
├── tests/                    # pytest unit tests
├── data/{raw,processed}/     # (gitignored) datasets
├── reports/                  # Evaluation reports + figures
└── .github/workflows/        # CI
```

## Quickstart

```bash
# 1. Environment
conda env create -f environment.yml
conda activate crystal-graph

# 2. Ingest Materials Project (needs MP_API_KEY)
export MP_API_KEY=...
python scripts/ingest_mp.py --config configs/data/mp_default.yaml

# 3. Build graph dataset
python scripts/build_graphs.py --config configs/data/graphs_default.yaml

# 4. Train a CGCNN
python scripts/train.py --config configs/experiment/cgcnn_baseline.yaml

# 5. Evaluate + calibration report
python scripts/evaluate.py --run-id <run_id>

# 6. Screen candidates
python scripts/screen_candidates.py --run-id <run_id> --top-k 1000

# 7. Active learning loop
python scripts/active_learning.py --config configs/experiment/al_bald.yaml
```

## Models

| Model    | Inputs                                  | Notes                              |
|----------|-----------------------------------------|------------------------------------|
| RF/XGB   | Magpie composition vector               | Strong composition-only baseline   |
| CGCNN    | Atom features + bond distances (Gaussian)| Original Xie & Grossman 2018      |
| MEGNet   | Atom + bond + global state              | Chen et al. 2019                   |
| ALIGNN   | Atom + bond + bond-angle line graph     | Choudhary & DeCost 2021            |

## Citation / references

- Xie & Grossman, *Crystal Graph Convolutional Neural Networks*, PRL 2018.
- Chen et al., *Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals*, Chem. Mater. 2019.
- Choudhary & DeCost, *Atomistic Line Graph Neural Network*, npj Comput. Mater. 2021.
- Jain et al., *The Materials Project*, APL Materials 2013.

## License

MIT. See [LICENSE](LICENSE).

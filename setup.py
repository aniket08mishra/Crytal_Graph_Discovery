from setuptools import setup, find_packages

setup(
    name="crystal_graph_discovery",
    version="0.1.0",
    description="Crystal-Graph Materials Discovery Platform",
    author="Aniket Mishra",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    python_requires=">=3.10",
)

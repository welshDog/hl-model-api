"""Train a simple TF-IDF + LogisticRegression text classifier on synthetic data.
Saves model to models/text_model.joblib
"""
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
import joblib
from pathlib import Path

SYNTHETIC = [
    ("I love this product, it works great", "positive"),
    ("Excellent service and friendly staff", "positive"),
    ("Terrible experience, will not buy again", "negative"),
    ("The item broke after one use", "negative"),
    ("Fast shipping and great quality", "positive"),
    ("Not worth the money", "negative"),
]

if __name__ == "__main__":
    texts, labels = zip(*SYNTHETIC)

    vec = TfidfVectorizer()
    clf = LogisticRegression(max_iter=1000)

    X = vec.fit_transform(texts)
    clf.fit(X, labels)

    Path("models").mkdir(exist_ok=True)
    joblib.dump({"vectorizer": vec, "classifier": clf, "labels": list(set(labels))}, "models/text_model.joblib")
    print("Saved text model to models/text_model.joblib")

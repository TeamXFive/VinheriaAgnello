import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, precision_score, classification_report, confusion_matrix
import os

def train_and_evaluate_model(data_path="data/sales_dataset.csv"):
    """
    Trains a Decision Tree model to predict sale success and evaluates it.
    """
    if not os.path.exists(data_path):
        print(f"Error: Dataset not found at {data_path}")
        return

    print(f"Loading data from {data_path}...")
    df = pd.read_csv(data_path)

    # 1. Select Input Features (X) and Target (y)
    # sale_id is dropped as it's just an identifier
    X_raw = df.drop(columns=["sale_id", "sale_success"])
    y = df["sale_success"]

    # 2. Preprocessing
    # Convert categorical variables into dummy/indicator variables (One-Hot Encoding)
    categorical_cols = ["product_category", "region", "sales_channel", "season"]
    X = pd.get_dummies(X_raw, columns=categorical_cols, drop_first=True)
    
    print("Features used for training:")
    print(list(X.columns))

    # 3. Train/Test Split
    # Using 70% of data for training and 30% for testing to ensure the model generalizes well
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
    
    print(f"\nData split: {len(X_train)} training samples, {len(X_test)} testing samples.")

    # 4. Model Selection and Training
    # We use a Decision Tree as it is highly interpretable, which is great for business insights.
    # Setting max_depth to prevent overfitting and keep the tree somewhat simple.
    model = DecisionTreeClassifier(max_depth=5, random_state=42)
    
    print("Training Decision Tree Classifier...")
    model.fit(X_train, y_train)

    # 5. Evaluation
    print("\n--- Evaluation Metrics ---")
    y_pred = model.predict(X_test)
    
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    
    print(f"Accuracy:  {accuracy:.4f} (Percentage of correct predictions overall)")
    print(f"Precision: {precision:.4f} (When predicting success, how often is it right?)")
    
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred))
    
    print("Confusion Matrix:")
    print(confusion_matrix(y_test, y_pred))
    
    # Feature Importance
    print("\n--- Feature Importances ---")
    importances = model.feature_importances_
    feature_names = X.columns
    feature_importance_df = pd.DataFrame({'Feature': feature_names, 'Importance': importances})
    feature_importance_df = feature_importance_df.sort_values(by='Importance', ascending=False)
    print(feature_importance_df.head(10).to_string(index=False))

if __name__ == "__main__":
    train_and_evaluate_model()

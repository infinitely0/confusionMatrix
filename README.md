# Confusion Matrix
Simple multiclass confusion matrix generator with statistics for classifier
evaluation.

Statistical measures available (per class and overall):
1. Accuracy
2. Precision
3. Recall
4. Specificity

Usage:

    predicted_vals = [ 0 0 0 1 1 1 2 2 2 ];
    actual_vals =    [ 0 0 1 1 1 1 1 2 2 ];
    [ conf acc prec rec spec ] = confusionMatrix(predicted_vals, actual_vals);
  
Output:

        
    Confusion matrix
    ================
    
    Actual values →		0		1		2
    Predictions ↓
    	0		2		1		0
    	1		0		3		0
    	2		0		1		2
    
    Statistical measures per class
    ==============================
    
    		Accuracy	Precision	Recall		Specificity
    Class 0		0.888889	0.666667	1.000000	0.857143
    
    Class 1		0.777778	1.000000	0.600000	1.000000
    
    Class 2		0.888889	0.666667	1.000000	0.857143
    
    Averages of measures
    ====================
    
    Accuracy: 	0.851852
    Precision: 	0.777778
    Recall: 	0.866667
    Specificity: 	0.904762


Confusion matrix and average measures returned:

    > conf
    conf =
    
       2           1           0
       0           3           0
       0           1           2
    
    > acc
    acc =    0.85185
    > prec
    prec =    0.77778
    > rec
    rec =    0.86667
    > spec
    spec =    0.90476
  


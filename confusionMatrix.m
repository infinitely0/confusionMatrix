function [confusion ...
          accuracy ...
          precision  ...
          recall ...
          specificity] = confusionMatrix(predictions, targets)
% Generate a confusion matrix for given predictions and target vectors and
% evaluate performance of classifier with several statistical measures.
%
% Usage:
%
% predicted_vals = [ 0 0 0 1 1 1 2 2 2 ];
% actual_vals =    [ 0 0 1 1 1 1 1 2 2 ];
% [ conf acc prec rec spec ] = confusionMatrix(predicted_vals, actual_vals);
%
% The first variable 'conf' stores the confusion matrix, the others are scalar
% values for evaluation of the classifier.
clc;

if (!isvector(predictions) || !isvector(targets))
  error("Predictions and targets must be vectors.")
end

if (length(predictions) != length(targets))
  error("Dimensions mismatch: input vectors not of equal length");
end

pred_set = unique(predictions);
targ_set = unique(targets);
super_set = unique([pred_set, targ_set]);
num_classes = length(super_set);

confusion = zeros(num_classes, num_classes);

for i = 1:length(predictions)
  confusion(predictions(i) + 1, targets(i) + 1) += 1;
end

% Display confusion matrix as a table
printf('\nConfusion matrix');
printf('\n================\n');

printf('\nActual values →');
printf('\t\t%d', super_set);
printf('\nPredictions ↓\n');

for i = 1:size(confusion, 1)
  printf('\t%d', super_set(i));
  for j = 1:size(confusion, 2)

    printf('\t\t%d', confusion(i, j));

  end
  printf('\n');
end

sum_accuracy = 0;
sum_precision = 0;
sum_recall = 0;
sum_specificity = 0;

% Display another table for presenting results of each class
printf('\nStatistical measures per class');
printf('\n==============================\n');

printf('\n\t\tAccuracy\tPrecision\tRecall\t\tSpecificity');
for i = 1:num_classes

  total = sum(sum(confusion));

  false_positives = sum(confusion(i, :)) - confusion(i, i);
  false_negatives = sum(confusion(:, i)) - confusion(i, i);

  true_positives = confusion(i, i);
  % True negatives equals the sum of the entire matrix, minus the row and
  % column where the class in question is involved, plus the diagonal (since
  % this is counted twice the row/column subtraction).
  true_negatives = total ...
                    - sum(confusion(i, :)) ...
                    - sum(confusion(:, i)) ...
                    + confusion(i, i);

  accuracy = (total - false_positives - false_negatives) / total;
  sum_accuracy += accuracy;

  precision = true_positives / sum(confusion(i, :));
  sum_precision += precision;

  recall = true_positives / sum(confusion(:, i));
  sum_recall += recall;

  specificity = true_negatives / (true_negatives + false_positives);
  sum_specificity += specificity;

  printf('\nClass %d\t\t%f\t%f\t%f\t%f\n', i-1, accuracy, precision, recall, specificity);
end

accuracy = sum_accuracy / num_classes;
precision = sum_precision / num_classes;
recall = sum_recall / num_classes;
specificity = sum_specificity / num_classes;

printf('\nAverages of measures');
printf('\n====================\n');
printf('\nAccuracy: \t%f', accuracy);
printf('\nPrecision: \t%f', precision);
printf('\nRecall: \t%f', recall);
printf('\nSpecificity: \t%f\n\n', specificity);

end


#export bert_model=./distilbert-base-german-cased
export bert_model=./bert-base-german-cased
export bert_model_output=tmp/PotTS-unbalanced-distilbase-german-uncased/
export dataset=../PotTS-unbalanced

if test -z "$1"; then
    echo train $bert_model_output
    python run_classifier.py \
  --bert_model=$bert_model \
  --task_name=sentiment \
  --do_train --do_eval \
  --data_dir=$dataset \
  --max_seq_length=256 \
  --train_batch_size=16 \
  --eval_batch_size=32 \
  --learning_rate=2e-5 \
  --num_train_epochs=6 \
  --output_dir=$bert_model_output
else
    echo test $bert_model_output
    python test.py \
  --bert_model=$bert_model \
  --checkpoint="$1" \
  --task_name=sentiment \
  --data_dir=$dataset \
  --max_seq_length=256 \
  --eval_batch_size=100
fi

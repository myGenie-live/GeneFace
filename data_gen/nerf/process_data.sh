#set -e;
#echo "Printing Starting time";
#date;
#export PYTHONPATH=./
#export CUDA_VISIBLE_DEVICES=0
# 1. extrac 16khz wav
#python data_util/process.py --video_id=$1 --task=1
#echo "Task 1 done"
# 2. extrac deepspeech and esperanto; 3.extract image frames 
#python data_util/process.py --video_id=$1 --task=2 &
#python data_util/process.py --video_id=$1 --task=3
#echo "Task 2 and 3 done"
# 7.detect landmarks
#python data_util/process.py --video_id=$1 --task=7
#echo "Task 7 done"
# 4.face segmentation parsing; 8.estimate head pose
python data_util/process.py --video_id=$1 --task=4 
python data_util/process.py --video_id=$1 --task=8
echo "Task 4 and 8 done"
# 4. extract background image
python data_util/process.py --video_id=$1 --task=5
echo "Task 5 done"
# 7. integrate the results into meta
python data_util/process.py --video_id=$1 --task=9
echo "Task 9 done"
# 8. calculate audio features
python data_gen/nerf/extract_hubert_mel_f0.py --video_id=$1
echo "Task audio features done"
# 9. calculate 3DMM 
python data_gen/nerf/extract_3dmm.py --video_id=$1
echo "Task face 3d features done"
# binarize the dataset into `data/binary/videos/$1/trainval_dataset.npy`
python data_gen/nerf/binarizer.py --config=egs/egs_bases/datasets/videos/$1/lm3d_radnerf.yaml
echo "Task binarizer done"
echo "Printing Ending time"
date

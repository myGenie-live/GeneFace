import sys
print(sys.path)
sys.path.insert(0,'/Projects/GeneFace')
sys.path.insert(0,'/Projects/GeneFace/utils')
sys.path.insert(0,'/Projects/GeneFace/options')
from options.test_options import TestOptions 
import pickle as pkl
# run in the <geneface> root dir!
opt = TestOptions().parse()  # get test options
opt.name='facerecon'
opt.epoch=20
opt.bfm_folder='deep_3drecon/BFM/'
opt.checkpoints_dir='deep_3drecon/checkpoints/'
print(opt)
with open("deep_3drecon/reconstructor_opt.pkl", 'wb') as f:
    pkl.dump(opt, f)

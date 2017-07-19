import numpy as np
import os
import os.path as osp

def onehot(y, n_classes=10):
    y_ = np.zeros(shape=(y.shape[0], n_classes), dtype='float32')
    y_[np.arange(y.shape[0]), y] = 1.0
    
    return y_

def unpickle(file):
    import pickle
    with open(file, 'rb') as fo:
        dict = pickle.load(fo, encoding='bytes')
    return dict

def fetch_cifar_dataset(cifar_folder='cifar-10-batches-py', channel_last=True):
    """
    Fetches CIFAR-10 dataset into provided directory.
    If channel_last flag is set, then also change of channel axis to be the last one.
    """
    #download if not exists
    if not os.path.exists(cifar_folder):
        print("cifar not found, downloading...")
        os.system("wget -q -nc http://www.cs.utoronto.ca/%7Ekriz/cifar-10-python.tar.gz")
        print("extracting...")
        os.system("tar xvzf cifar-10-python.tar.gz")
        os.system('mv cifar-10-batches-py %s' % cifar_folder)
        print("done")
        assert os.path.exists(cifar_folder)
    
    imgs = []
    labels = []
    for data_file in [ item for item in os.listdir(cifar_folder) if item.startswith('data_batch_') ]:
        data = unpickle(osp.join(cifar_folder, data_file))
        imgs.append(data[b'data'])
        labels.append(data[b'labels'])
    
    imgs = np.vstack(imgs)
    imgs = imgs.reshape(-1, 3, 32, 32)
    if channel_last:
        imgs = np.transpose(imgs, (0, 2, 3, 1))

    labels = np.hstack(labels)
    
    data_test = unpickle(osp.join(cifar_folder, 'test_batch'))
    imgs_test = data[b'data']
    labels_test = np.hstack(data[b'labels'])
    
    imgs_test = imgs_test.reshape(-1, 3, 32, 32)
    if channel_last:
        imgs_test = np.transpose(imgs_test, (0, 2, 3, 1))
    
    label_names = unpickle(osp.join(cifar_folder, 'batches.meta'))[b'label_names']
    label_names = [ label.decode('ascii') for label in label_names ]
    
    return imgs, onehot(labels), imgs_test, onehot(labels_test), label_names
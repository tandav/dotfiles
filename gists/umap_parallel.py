import pickle
import concurrent.futures
import itertools
import umap
import numpy as np
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import io
import matplotlib.image as mimg
import time
import pandas as pd
import collections

X = pd.read_pickle('input_bits.pkl').sample(4000)

def compress_dimensions(min_dist, n_neighbors):
    t = time.time()
    u = umap.UMAP(
        n_components = 2,
        min_dist     = min_dist,
        n_neighbors  = n_neighbors,
        metric       ='jaccard',
        # metric       ='hamming',
    ).fit(X)
    
    e = u.transform(X)
    
    centroid = e.mean(axis=0)
    dist = np.linalg.norm(e - centroid, axis=1)
    medoid_key = np.argmin(dist)
    medoid = e[medoid_key]
    medoid_subs = X.index[medoid_key]

    rounded_mean_centroid = X.mean(axis=0).round().astype('int8').values
    # just for plotting on 2d: (for hashing use actual rounded_mean_centroid)
    jaccards = 1 - np.count_nonzero(X & rounded_mean_centroid, axis=1) / np.count_nonzero(X | rounded_mean_centroid, axis=1)
    rounded_medoid_key = np.argmin(jaccards)
    rounded_medoid = e[medoid_key]

    centroid_by_most_common = pd.Series(data=np.zeros(X.shape[1], dtype='int8'), index=X.columns)
    sum_ = X.sum(axis=0)
    for column in centroid_by_most_common.index.get_level_values('column').unique():
        centroid_by_most_common[(column, sum_[column].idxmax())] = 1
    centroid_by_most_common = centroid_by_most_common.values
    jaccards_by_most_common = 1 - np.count_nonzero(X & centroid_by_most_common, axis=1) / np.count_nonzero(X | centroid_by_most_common, axis=1)
    medoid_by_most_common_key = np.argmin(jaccards_by_most_common)
    medoid_by_most_common = e[medoid_by_most_common_key]

    
    
    img_bytes = io.BytesIO()
    
    fig, ax = plt.subplots(figsize=(5, 5), frameon=False, dpi=100)
    fig.subplots_adjust(left=0, bottom=0, right=1, top=1, wspace=None, hspace=None)
    ax.grid(False)
    ax.axis('off')
    
    ax.scatter(*e.T, s=0.4, color='b')
    ax.plot(*centroid, 'go')
    ax.plot(*medoid, 'r+', markersize=30, markeredgewidth=2)
    ax.plot(*rounded_medoid, 'mx', markersize=30, markeredgewidth=2)
    ax.plot(*medoid_by_most_common, 'cD', markersize=5, markeredgewidth=2)


    dt_minutes = round((time.time() - t) / 60, 1)
    
    title = 'min_dist:{}   n_neighbors:{}\nn={} {} {} minutes'.format(min_dist, n_neighbors, X.shape[0], medoid_subs, dt_minutes)
    ax.text(.5, .9, title, horizontalalignment='center', transform=ax.transAxes, fontsize=18)
    #ax.set_title(title, fontsize=20)
    fig.savefig(img_bytes, format='png', dpi=100)
    img_bytes.seek(0)
    return img_bytes, dt_minutes, medoid_subs

def main():
    t = time.time()
    min_dist_range    =   0.0, 0.1, 0.25, 0.5, 0.8, 0.99
    n_neighbors_range =   2, 5, 15, 50, 100, 200
    params_space = itertools.product(min_dist_range, n_neighbors_range)

    pics = dict()
    medoids = collections.Counter()
    with concurrent.futures.ProcessPoolExecutor() as pool:
        tasks = {
            pool.submit(compress_dimensions, min_dist, n_neighbors): (min_dist, n_neighbors)
            for min_dist, n_neighbors in params_space
        }
        for task in concurrent.futures.as_completed(tasks):
            params = tasks[task]
            pic, dt_minutes, medoid = task.result()
            pics[params] = pic
            medoids[medoid] += 1
            print(params, 'done in', dt_minutes, 'minutes', 'medoid:', medoid)
    print(medoids.most_common())
    print('making final image')
    pics = [v for k, v in sorted(pics.items())]
    n_rows, n_cols = len(min_dist_range), len(n_neighbors_range)
    fig, ax = plt.subplots(n_rows, n_cols, figsize=(16, 16), frameon=False)#, sharex='col', sharey='row')
#     fig.subplots_adjust(hspace=0, wspace=0)
    fig.subplots_adjust(left=0, bottom=0, right=1, top=1, wspace=0, hspace=0)

    for i, pic in enumerate(pics, start=1):
        ax = fig.add_subplot(n_rows, n_cols, i)
        ax.imshow(mimg.imread(pic))
        ax.axis('off')
    fig.savefig('umap.png')
    print('DONE, total time:', (time.time() - t) / 60, 'minutes')

if __name__ == '__main__':
    main()

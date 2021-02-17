from TikTokApi import TikTokApi
from data_preparation import simple_dict
import pandas as pd

#reading in chosen hashtags from a csv. methodology of selction can be found in paper.
tags = pd.read_csv('/Users/ekaterinafedorova/Documents/Econ 191/Data/hashtags.csv', header=0)
#changing type object to string
tags["hashtags"] = tags["hashtags"].astype('string')

#sanity check
#print(tags.hashtags)
#print(type(tags.hashtags))

#calling instance of API
api = TikTokApi.get_instance(use_test_endpoints=True, use_selenium= False)

#count of content to pull form each tag.
c = 45

#verifyFp taken from website cookie
verify = ""

#pulling selected count of content from each tag and saving in a csv file to access in cleaning and analysis
for h in tags['hashtags']:
    hashtag_videos = api.byHashtag(h, count=c, custom_verifyFp=verify, language='en', proxy=None)
    hashtag_videos = [simple_dict(v) for v in hashtag_videos]
    hashtag_videos_df = pd.DataFrame(hashtag_videos)
    hashtag_videos_df.to_csv('/Users/ekaterinafedorova/Documents/Senior Thesis/Raw Data/{}_videos.csv'.format(h), index=False)


#defining method to select only chosen parameters from each tiktok dict taken from the API
def simple_dict(tiktok_dict):
    # Returns set of variables, when no stickers, returns "None"

    to_return = {}
    to_return['user_name'] = tiktok_dict['author']['uniqueId']
    to_return['user_id'] = tiktok_dict['author']['id']
    to_return['video_id'] = tiktok_dict['id']
    to_return['video_desc'] = tiktok_dict['desc']
    to_return['video_time'] = tiktok_dict['createTime']
    to_return['video_length'] = tiktok_dict['video']['duration']
    to_return['video_link'] = 'https://www.tiktok.com/@{}/video/{}?lang=en'.format(to_return['user_name'],
                                                                                   to_return['video_id'])
    to_return['n_likes'] = tiktok_dict['stats']['diggCount']
    to_return['n_shares'] = tiktok_dict['stats']['shareCount']
    to_return['n_comments'] = tiktok_dict['stats']['commentCount']
    to_return['n_plays'] = tiktok_dict['stats']['playCount']
    to_return['stickers'] = tiktok_dict.get('stickersOnItem', 'None')
    to_return['duet_enabled'] = tiktok_dict['duetEnabled']
    to_return['stitch_enabled'] = tiktok_dict['stitchEnabled']
    to_return['share_enabled'] = tiktok_dict['shareEnabled']
    return to_return

#returns:
#username: the username of the content creator
#user id: the unique numerical id of the content creator
#video_id: unique numerical id of content
#video_desc: caption of the tiktok. has character limit. emojis might translate poorly
#video_time: time of creation. paper uses estimate of corresponding days to bin content
#video_length: length of video in seconds. max 60
#video_link: link
#n_likes: number of likes of the content at day and time accessed
#n_shares: number of shares of the content at day and tie accessed
#n_comments: number of comments of the content at day and time accessed
#n_plays: number of plays of the content at day and time accessed
#stickers: set of stickers used in content (array of textboxes) none if no stickers used
#duet_enabled: boolean True if duet function has been enabled by content creator
#stitch_enabled: boolean true if stitch function has been enabled by content creator
#share_enabled: boolean true if share function has been enabled by content creator

require_relative "IMS"

ims = IMS.new
ims.run


# store = PStore.new("storage.pstore")
# # store.transaction do
# # 	arr = [track, track]
# # 	store["tracks"] = arr
# # 	store.commit
# # end

# store.transaction do 
# 	p store.roots
# 	s = store["tracks"][0]
# 	p s
# 	p store["aaa"]
# end
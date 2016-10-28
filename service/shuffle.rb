
#input an array, return randam k elements in an array.
def shuffle(arr,k)
  rd=Random.new
  n=arr.size
  for i in 0...k
    x=rd.rand(i...n)
    puts x
    tmp=arr[x]
    arr[x]=arr[i]
    arr[i]=tmp
  end
  arr[0...k]
end

# a=[0,1,2,3,4,5,6,7,8]
# print shuffle(a,3)

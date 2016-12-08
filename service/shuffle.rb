
# input an array, return randam k elements in an array.
def shuffle(arr, k)
    rd = Random.new
    ar = arr.clone
    n = arr.size
    k = n if k > n
    for i in 0...k
        x = rd.rand(i...n)
        tmp = ar[x]
        ar[x] = ar[i]
        ar[i] = tmp
    end
    ar[0...k]
end

# a=[0,1,2,3,4,5,6,7,8]
# print shuffle(a,3)

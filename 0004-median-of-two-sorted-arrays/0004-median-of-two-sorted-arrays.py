class Solution:
    def findMedianSortedArrays(self, nums1: list[int], nums2: list[int]) -> float:
        
        final_arr = sorted(nums1+nums2)
        len_final_arr = len(final_arr)
        
        median = int((int(len_final_arr)/2))
        
        if len_final_arr%2 == 0:
            return (final_arr[median]+final_arr[-median-1])/2
        else:
            return final_arr[int(float(median)+0.5)]
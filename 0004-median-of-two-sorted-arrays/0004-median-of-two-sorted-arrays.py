class Solution:
    def findMedianSortedArrays(self, nums1: list[int], nums2: list[int]) -> float:
        arr1 = nums1
        arr2 = nums2
        
        final_arr = sorted(arr1+arr2)
        len_final_arr = len(final_arr)
        
        median = int((int(len_final_arr)/2)-0.5)
        
        if len_final_arr%2 == 0:
            return (final_arr[median]+final_arr[-median-1])/2
        else:
            median = int((int(len_final_arr)/2)-0.5)
            return final_arr[median]
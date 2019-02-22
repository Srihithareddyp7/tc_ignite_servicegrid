package com.ignite;


import java.util.*;

public class Solution {
    public static int findShortestSubArray(int[] nums) {
        Map<Integer, Integer> left = new HashMap<>(),
                right = new HashMap(), count = new HashMap();

        for (int i = 0; i < nums.length; i++) {
            int x = nums[i];
            if (left.get(x) == null) left.put(x, i);
            right.put(x, i);
            count.put(x, count.getOrDefault(x, 0) + 1);
        }

        int ans = nums.length;
        int degree = Collections.max(count.values());
        System.out.println("nums : " + nums.length + "\n\ndegree : " + degree + "\n\ncount : " + count.size());
        for (int x: count.keySet()) {
            if (count.get(x) == degree) {
                ans = Math.min(ans, right.get(x) - left.get(x) + 1);
            }
        }
        System.out.println("\nans : " + ans);
        return ans;
    }

    public static void main(String [] args) {
        int[] intArray = new int[]{ 1,2,1,3,2};
        System.out.println(findShortestSubArray(intArray));
    }
    static class Dataset {
        private Integer min = null;
        private Integer max = null;
        private TreeSet<Integer> elements = new TreeSet<Integer>();
        private Vector<Long> products = new Vector<Long>();

        public void push(int x) {
            elements.add(x);
            if (min == null) {
                min = new Integer(x);
                max = new Integer(x);
            } else {
                if (min.intValue() > x) {
                    min = new Integer(x);
                }
                if (max.intValue() < x) {
                    max = new Integer(x);
                }
            }
            products.add(new Long(min.longValue() * max.longValue()));
        }

        public void pop(int x) {
            elements.remove(x);
            min = elements.first();
            max = elements.last();
            products.add(new Long(min.longValue() * max.longValue()));
        }

        public long[] toArray() {
            long[] la = new long[products.size()];
            Iterator<Long> itl = products.iterator();
            for (int i = 0; itl.hasNext(); i++) {
                la[i] = itl.next();
            }
            return la;
        }
    }

    public static List<Long> maxMin(List<String> operations, List<Integer> x) {
        // String[] operations = operations1.stream().mapToString(i -> i).toArray();
        // int[] x = x1.stream().mapToInt(i -> i).toArray();
        // Write your code here
        Dataset ds = new Dataset();
        for (int i = 0, fi = operations.size(); i < fi; i++) {
            if ("push".equals(operations.get(i))) {
                ds.push(x.get(i));
            } else if ("pop".equals(operations.get(i))) {
                ds.pop(x.get(i));
            }
        }
        return null ; //ds.toArray();
    }
}


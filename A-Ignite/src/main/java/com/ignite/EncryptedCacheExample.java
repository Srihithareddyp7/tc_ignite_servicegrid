//package com.ignite;
//
//import javax.cache.Cache;
//import org.apache.ignite.Ignite;
//import org.apache.ignite.IgniteCache;
//import org.apache.ignite.Ignition;
//import org.apache.ignite.cache.query.QueryCursor;
//import org.apache.ignite.cache.query.ScanQuery;
//import org.apache.ignite.configuration.CacheConfiguration;
//
//public class EncryptedCacheExample {
//    public static void main(String[] args) {
//        System.out.println(">>> Starting cluster.");
//
//        try (Ignite ignite = Ignition.start("config/configV2.0/encryption/example-encrypted-store.xml")) {
//
//            ignite.cluster().active(true);
//
//            CacheConfiguration<Long, BankAccount> ccfg = new CacheConfiguration<>("encrypted-cache");
//
//            // Enabling encryption for newly created cache.
//            ccfg.setEncryptionEnabled(true);
//
//            System.out.println(">>> Creating encrypted cache.");
//
//            IgniteCache<Long, BankAccount> cache = ignite.getOrCreateCache(ccfg);
//
//            System.out.println(">>> Populating cache with data.");
//
//            // Data in this cache will be encrypted on the disk.
//            cache.put(1L, new BankAccount("Rich account", 1_000_000L));
//            cache.put(2L, new BankAccount("Middle account", 1_000L));
//            cache.put(3L, new BankAccount("One dollar account", 1L));
//        }
//
//        // After cluster shutdown data persisted on the disk in encrypted form.
//
//        System.out.println(">>> Starting cluster again.");
//        // Starting cluster again.
//        try (Ignite ignite = Ignition.start("config/configV2.0/encryption/example-encrypted-store.xml")) {
//            ignite.cluster().active(true);
//
//            // We can obtain existing cache and load data from disk.
//            IgniteCache<Long, BankAccount> cache = ignite.getOrCreateCache("encrypted-cache");
//
//            QueryCursor<Cache.Entry<Long, BankAccount>> cursor = cache.query(new ScanQuery<>());
//
//            System.out.println(">>> Saved data:");
//
//            // Iterating through existing data.
//            for (Cache.Entry<Long, BankAccount> entry : cursor) {
//                System.out.println(">>> ID = " + entry.getKey() +
//                        ", AccountName = " + entry.getValue().accountName +
//                        ", Balance = " + entry.getValue().balance);
//            }
//
//        }
//    }
//
//    /**
//     * Test class with very secret data.
//     */
//    private static class BankAccount {
//        /**
//         * Name.
//         */
//        private String accountName;
//
//        /**
//         * Balance.
//         */
//        private long balance;
//
//        /** */
//        BankAccount(String accountName, long balance) {
//            this.accountName = accountName;
//            this.balance = balance;
//        }
//    }
//}

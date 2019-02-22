/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.ignite.servicegrid;

import org.apache.ignite.Ignite;
import org.apache.ignite.IgniteCache;
import org.apache.ignite.configuration.CacheConfiguration;
import org.apache.ignite.resources.IgniteInstanceResource;
import org.apache.ignite.services.Service;
import org.apache.ignite.services.ServiceContext;

import java.io.FileWriter;
import java.io.PrintWriter;

/**
 * Simple service which utilizes Ignite cache as a mechanism to provide
 * distributed {@link SimpleMapService} functionality.
 */
public class SimpleMapServiceImpl<K, V> implements Service, SimpleMapService<K, V> {
    public static void printToFile(String text) throws Exception{
        try (PrintWriter out = new PrintWriter(new FileWriter("output.txt", true))) {
            out.println(text);
        }
    }
    /** Serial version UID. */
    private static final long serialVersionUID = 0L;

    /** Ignite instance. */
    @IgniteInstanceResource
    private Ignite ignite;

    /** Underlying cache map. */
    private IgniteCache<K, V> cache;

    /** {@inheritDoc} */
    @Override public void put(K key, V val) {
        cache.put(key, val);
    }

    /** {@inheritDoc} */
    @Override public V get(K key) {
        return cache.get(key);
    }

    /** {@inheritDoc} */
    @Override public void clear() {
        cache.clear();
    }

    /** {@inheritDoc} */
    @Override public int size() {
        return cache.size();
    }

    /** {@inheritDoc} */
    @Override public void cancel(ServiceContext ctx){
        ignite.destroyCache(ctx.name());

        try {
            printToFile("Service was cancelled: " + ctx.name());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** {@inheritDoc} */
    @Override public void init(ServiceContext ctx) throws Exception {
        // Create a new cache for every service deployment.
        // Note that we use service name as cache name, which allows
        // for each service deployment to use its own isolated cache.
        cache = ignite.getOrCreateCache(new CacheConfiguration<K, V>(ctx.name()));

        printToFile("Service was initialized: " + ctx.name());
    }

    /** {@inheritDoc} */
    @Override public void execute(ServiceContext ctx) throws Exception {
        printToFile("Executing distributed service: " + ctx.name());
        IgniteCache<Integer, String> cache = ignite.getOrCreateCache("myCache");
        cache.put(1, "Hello");
        cache.put(2, ctx.name());

//        put(1, "Hello");
//        put(2, ctx.name());
//        System.out.println(get(1) + " " + get(2));
    }
}
---
layout: post
title:  Build a CSV in Clojure
categories: [code]
---

Converting a vector of values to a CSV in pure clojure. Not actually that interesting, just wanted the chance to try out [klipse](https://github.com/viebel/klipse).

<pre><code class="language-klipse">(ns csv-example.core
  (:require 
    [clojure.string :as string]))

(def csv
  [["name" "age" "occupation" "gender"]
   ["Peter Pan" 312 "Lost Boy" "male"]
   ["Wendy Darling" 14 "Older Sister" "female"]
   ["Captain Hook" 330 "Pirate" "male"]
   ["Tinker Bell" nil "Fairy" "female"]])

(defn clean-str [s]
  (pr-str (string/replace s "\n" "")))

(defn build-csv [xs]
  (->> xs 
    (map (fn [xs] (map #(if (string? %) (clean-str %) %) xs))) ;; quote all strings
    (map (partial string/join ",")) ;; seq of seq -> seq of strings
    (string/join "\n"))) ;; seq of string -> string

(println (build-csv csv))
</code></pre>

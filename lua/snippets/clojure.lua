local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("clojure", {
  -- Portal config snippet
  s("<portal", {
    t({
      "(require 'portal.api)",
      "(defonce portal (atom nil))",
      "(when (nil? @portal)",
      "        (reset! portal (portal.api/open {:port 8013}))",
      "        (add-tap #'portal.api/submit))"
    })
  }),

  -- Additional Clojure snippets
  s("defn", {
    t("(defn "), i(1, "name"), t(" ["), i(2, "args"), t("]"),
    t({"", "  "}), i(3, "body"), t({"", ")"})
  }),

  s("let", {
    t("(let ["), i(1, "bindings"), t("]"),
    t({"", "  "}), i(2, "body"), t({"", ")"})
  }),

  s("if", {
    t("(if "), i(1, "condition"),
    t({"", "  "}), i(2, "then"),
    t({"", "  "}), i(3, "else"), t({"", ")"})
  }),

  s("comp", fmt("(comp {})", {
    i(1, "fns")
  })),

  s("->", fmt("(-> {})", {
    i(1, "expr")
  })),

  s("->>", fmt("(->> {})", {
    i(1, "expr")
  })),

  s("defmethod", {
    t("(defmethod "), i(1, "multifn"), t(" "), i(2, "dispatch-val"), t(" ["), i(3, "args"), t("]"),
    t({"", "  "}), i(4, "body"), t({"", ")"})
  }),

  s("comment", {
    t("(comment"),
    t({"", "  "}), i(1, "body"), t({"", ")"})
  }),

  s("require", fmt("(require '[{} :as {}])", {
    i(1, "namespace"),
    i(2, "alias")
  })),

  s("ns", {
    t("(ns "), i(1, "namespace"),
    t({"", "  (:require ["}), i(2, "requires"), t("])"), 
    t({"", "  (:import ["}), i(3, "imports"), t("])"), t({"", ")"})
  }),
})
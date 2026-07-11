Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7F397E85;
	Sat, 11 Jul 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765033; cv=none; b=qHlbcmWP7YCQhmZassOs1OdKIARqMEu+5lop3eCe4kXfwswu7EBzuo1OI7nenmX8teQxCwsWpfwmXIpI44KmwLSFGMnMnD9RrA9i82+zLXv+kAPgXXpnV+Of9QIEbfEkyJifpENTRvSTvXkGsIZgXW6KDnej5+ANw/YrzJGWygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765033; c=relaxed/simple;
	bh=2i565GZEt7CtYaWPQAS6HCVyhDNjGn7E4LXA8bkXTno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMEqCZCUuUNoTwfCNgrcOeArRBulCbitgwdNgwuK2uRJS6ToVAo6s9ohC8Vkg+vAF2jmsytmDsWs0loZS6sBiJIxSG3CVrvi142CUysLZo9TmA7yVjczFQxzl80fSFxUavl8zx8DllsHv2uzhJQVLVTxLyhb1lsK5LMW/YW6WJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PpAvopWR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jqQZAQTH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PpAvopWR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jqQZAQTH"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gy4PV5BHkzMlDm;
	Sat, 11 Jul 2026 12:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCxBH8XTLqZLh53kCc2mC0OKwjriiIwFPSjZgfKY0Hs=;
	b=PpAvopWRJ+1PlJIs8Q20TuH/Tlhz++ekaj7ZKsLcvpBnPS9yqHKYWspBOBqDvGEDmiQHai
	1PSd5or8SRE6W/7vcChvLHgggtuEgYEUQCWtlYbvv3tc1UiSTCZ6AiYJKfH/wigM/C5z9L
	6AZ1dpzbXayci5es2m2E1vo9piU8mH2CRJQw0d2k48gH37dpJ2wW0Vcfa9e3ph5Mr/xPTz
	EzqwMD+LucA2yr1t//6XjaKYy0QS+0RVgqrDhWIg3fCFIoRaTclgSI4bgdZk0Ob9foeRTp
	5mP96hh2SOFfThq3oEJXlpr4hWs7eHRRPiOA2Y7KrNUMYcgQWm9cU3Eei+pl9A==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCxBH8XTLqZLh53kCc2mC0OKwjriiIwFPSjZgfKY0Hs=;
	b=jqQZAQTHz3W/0Yg1gT1D+vbBqOm/n5JWWNSutX6S3psjJRG+3PszlUBrrym/r8tDObMbIX
	2y6PF7T716fIP68Nm6fM/WRyX6b9hN8fjBnhYmV+l5KhpTEKGCcvbgQJtZcrtAPXQENYAQ
	jhQvsTJ8ABPcueXAjnfVFVMELr1kV4EsyrTPqVeRSA7fLEMU4EKJjEBSBiehxpGATYtkUq
	LoQYNJSYiWzOJP5abHZHLGxPn0/l/xX1yF4ygyY52doNEzsj0O8AwMEithDlO+37QEWScr
	uqqpWp6eqTawrRMtp3Pb8/F/QxHne86vv2wKCS3/tbBOrLjLlkvxlbLqLYlBrg==
Date: Sat, 11 Jul 2026 12:16:29 +0200
Subject: [PATCH v4 1/2] rust: clk: Add `ExclusiveClk` wrapper for
 `clk_rate_exclusive_get`
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-rate-exclusive-get-th1520-v4-1-8244a0666a71@mailbox.org>
References: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
In-Reply-To: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Brian Masney <bmasney@redhat.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783765003; l=3768;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=2i565GZEt7CtYaWPQAS6HCVyhDNjGn7E4LXA8bkXTno=;
 b=YD8iP2otPa9/+5EnZK5SMiUG+u+YWJDS4nsYJPN5E6gVR2OtDYxHwHzWBJ/fyHDvjc+cuyX67
 tpetJ3aZhHSDhRRg1nOwOOlgIlgxcAfRY+8YenNMY2D4kNfn1Hklv0h
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: a2a2aa3e636b3a76154
X-MBO-RS-META: qawtzmuw3yd8chbb6he14dj844ybn7rx

Add Rust bindings for `clk_rate_exclusive_get()` and
`clk_rate_exclusive_put()`.

`Clk::rate_exclusive_get()` consumes the `Clk<Enabled>` and returns an
`ExclusiveClk`. The matching put is issued from its Drop impl.
`ExclusiveClk` derefs to `Clk<Enabled>` so existing APIs remain
available on the locked handle.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/clk.rs | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index e677156ffd21..18e4c1fb0937 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -95,6 +95,7 @@ mod common_clk {
     use core::{
         marker::PhantomData,
         mem::ManuallyDrop,
+        ops::Deref,
         ptr, //
     };
 
@@ -682,6 +683,23 @@ pub fn disable(self) -> Clk<Prepared> {
                 _phantom: PhantomData,
             }
         }
+
+        /// Acquire exclusive control over the clock's rate.
+        ///
+        /// Consumes the [`Clk<Enabled>`] and returns an [`ExclusiveClk`] that releases
+        /// the exclusivity when dropped. While held, no other consumer may change the clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. Must not be called from
+        /// atomic context.
+        ///
+        /// [`clk_rate_exclusive_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
+        #[inline]
+        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // clk_rate_exclusive_get.
+            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_raw()) })?;
+            Ok(ExclusiveClk(self))
+        }
     }
 
     impl<T: ClkState> Clk<T> {
@@ -767,6 +785,55 @@ fn clone(&self) -> Self {
             }
         }
     }
+
+    /// A [`Clk<Enabled>`] with exclusive control over its rate.
+    ///
+    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock may change its rate.
+    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity is released automatically
+    /// when the value is dropped, after which the inner [`Clk<Enabled>`] is dropped as usual.
+    ///
+    /// # Invariants
+    ///
+    /// An [`ExclusiveClk`] instance owns a [`Clk<Enabled>`] for which `clk_rate_exclusive_get` has
+    /// been called and the matching `clk_rate_exclusive_put` has not yet been called.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     ExclusiveClk,
+    ///     Enabled //
+    /// };
+    /// use kernel::device::{
+    ///     Bound,
+    ///     Device, //
+    /// };
+    /// use kernel::error::Result;
+    ///
+    /// fn lock_rate(dev: &Device<Bound>) -> Result<ExclusiveClk> {
+    ///     let clk = Clk::<Enabled>::get(dev, None)?;
+    ///     clk.rate_exclusive_get()
+    /// }
+    /// ```
+    pub struct ExclusiveClk(Clk<Enabled>);
+
+    impl Deref for ExclusiveClk {
+        type Target = Clk<Enabled>;
+
+        fn deref(&self) -> &Clk<Enabled> {
+            &self.0
+        }
+    }
+
+    impl Drop for ExclusiveClk {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // clk_rate_exclusive_put and balances the clk_rate_exclusive_get call from
+            // Clk::rate_exclusive_get.
+            unsafe { bindings::clk_rate_exclusive_put(self.as_raw()) };
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.51.2


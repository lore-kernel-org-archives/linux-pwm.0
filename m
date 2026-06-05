Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14340B6F9;
	Fri,  5 Jun 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642866; cv=none; b=rIQCxRsQzWjwRfwjCdfl9XhqtMYc7BZdAcJUPdCKBnOo2uS2t7GGF0oOvW9cDPhJve4QIagI3L/Bp7OXgynDzz/6SPJQ+vUsueBE60T08r0z51HWjkx+xt9pYCelz88A8vyNRmOf0eWAVVX7zT9Dup03xt6HlczNugUcWpzA2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642866; c=relaxed/simple;
	bh=Eq2/FqQK+/3GGvQH1jgzjXllW8SOFixYwWstqkvt+Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKGFQSZvEUhKAZOwKee8jNH8XyBeo6WXTHRex8hiMuVsYWUm5gcDs7VJbwQdQ664cQeJS0Fl/ljUXnqDy0DjwOqrjnTRDjzNnEnNkCihYxcvfcTymNaUniOmLqEyGRTFLYabZMybP/pI9DDMjjnwg0PWkQc0MjAGNFeUWOb+2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GGaoMEEQ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=h4ZJD7pW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GGaoMEEQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h4ZJD7pW"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gWslx34H3z9v3Q;
	Fri,  5 Jun 2026 09:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpNBtlw9n2UCJW3D0hBUmygvSZ9hYaw7j0NNMC94AK4=;
	b=GGaoMEEQI3Xwgau5/KSpvAySoomQK91gLt491999CJTJ6qWIxbsGyRWlpefLN9VdkpzswO
	JGAcgDUAzmc7UgPYlp4OKVWP4tJKbFhq5wsvnqMJ6OUU3pK0gOALDBwQFrNC6szaYKMIw2
	6krzfuD35LZwtB+Qdtm5yuWQztwa6NpqaGvu4htpakZpnkGwh6M8ntZSXp2/9r5OfXQY03
	FMMKyGXZi6x7fr28Nb5AfT9rYeJI8seAq2HSlQQiIHMZGwOwKE+5JUwwHWvy9ykS7kaP15
	VRUvl/pXHMPpDyO6kFED+yZTmSRkanpNWF+zRJP6Pf3KK0NkF4iOUSH4HqUnFg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpNBtlw9n2UCJW3D0hBUmygvSZ9hYaw7j0NNMC94AK4=;
	b=h4ZJD7pWeiBrHP178TiWZuxtX1fdKlYrIYx1VcSOMs+fzU84EYqGbu5FcO9uzIEgn91tcS
	Jn5LZ2ope1hnWhoapqqxQyz/frTp8TYH0gFRD5hSu0z9fFZxcx5oZRFn2FphEN4y86L+Oz
	fr6v2oGNgsu3TatoZA7Cm9zbjwpwIShCh6Qt9G9a1z4VOqsku+joy1N4jRACQlNvi9g7hf
	Hm4rcBOOLU7Wgoqddlr3fTTyQbz00s+Hv6+R8c3LLyTgDkYXMMcQAKoqm3OQPJkzyAYRd+
	3wgGQiQ1dBDrTr66YS16GVW+Q4Hs7zg1EsKk/MLGVaCo6DkfRtOL9lXNx+T13Q==
Date: Fri, 05 Jun 2026 08:59:59 +0200
Subject: [PATCH v2 1/2] rust: clk: Add ExclusiveClk wrapper for
 clk_rate_exclusive_get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rate-exclusive-get-th1520-v2-1-695640bf7249@mailbox.org>
References: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
In-Reply-To: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780642818; l=3552;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=Eq2/FqQK+/3GGvQH1jgzjXllW8SOFixYwWstqkvt+Ks=;
 b=EnPdbF7ZbiSZsoiQzpqVV642CEH+9nF8nNVKGzxReY0KS0hzY5ErgB16n/ogDC4ZIgDHlnxRs
 3pOhFWYN/TeBhXC4PYk2qu9FhThAApgBG4qR+jGpgZpndrfq7TktHcu
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: btqxt863ejstfjtaxooubyxo1r5tg14c
X-MBO-RS-ID: 46288b54c5fc677ce46

Add Rust bindings for clk_rate_exclusive_get() and
clk_rate_exclusive_put().

Clk::rate_exclusive_get() consumes the Clk and returns an ExclusiveClk;
the matching put is issued from its Drop impl. ExclusiveClk derefs to
Clk so existing rate / prepare / enable APIs remain available on the
locked handle.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/clk.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 7abbd0767d8c..f834f4833f18 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -249,6 +249,22 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
             // [`clk_set_rate`].
             to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
         }
+
+        /// Acquire exclusive control over the clock's rate.
+        ///
+        /// Consumes the [`Clk`] and returns an [`ExclusiveClk`] that releases the exclusivity
+        /// when dropped. While held, no other consumer may change the clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. Must not be called from
+        /// atomic context.
+        ///
+        /// [`clk_rate_exclusive_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
+        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_rate_exclusive_get`].
+            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_raw()) })?;
+            Ok(ExclusiveClk(self))
+        }
     }
 
     impl Drop for Clk {
@@ -329,6 +345,50 @@ fn deref(&self) -> &Clk {
             &self.0
         }
     }
+
+    /// A [`Clk`] with exclusive control over its rate.
+    ///
+    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock may change its rate.
+    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity is released automatically
+    /// when the value is dropped, after which the inner [`Clk`] is dropped as usual.
+    ///
+    /// # Invariants
+    ///
+    /// An [`ExclusiveClk`] instance owns a [`Clk`] for which `clk_rate_exclusive_get` has been
+    /// called and the matching `clk_rate_exclusive_put` has not yet been called.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::clk::{Clk, ExclusiveClk};
+    /// use kernel::device::Device;
+    /// use kernel::error::Result;
+    ///
+    /// fn lock_rate(dev: &Device) -> Result<ExclusiveClk> {
+    ///     let clk = Clk::get(dev, None)?;
+    ///     clk.prepare_enable()?;
+    ///     clk.rate_exclusive_get()
+    /// }
+    /// ```
+    pub struct ExclusiveClk(Clk);
+
+    // Make [`ExclusiveClk`] behave like [`Clk`].
+    impl Deref for ExclusiveClk {
+        type Target = Clk;
+
+        fn deref(&self) -> &Clk {
+            &self.0
+        }
+    }
+
+    impl Drop for ExclusiveClk {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_rate_exclusive_put`] and balances the [`clk_rate_exclusive_get`] call from
+            // [`Clk::rate_exclusive_get`].
+            unsafe { bindings::clk_rate_exclusive_put(self.as_raw()) };
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.51.2


Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7903B71AE;
	Sun, 28 Jun 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677885; cv=none; b=gPGsxNCjAxAewzQ1tDW3NZ7VZU+Togn1DF9d2T2lDjjGSoRdIEytD8GhCObnZzJMdJYIEsAQGU8Y0eI1SOJ/ddj5tXosiZyvXAdRIsfx/l9b14gRUvij11qkuM0Ouvv8eb4YkWLAODD1EY3tgTW0XZgKfuSjpoK9jKWjhgKKd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677885; c=relaxed/simple;
	bh=XTt9Wb3t8dMkZzuvXmoKi5n+eeWfIrk4FFd5V+XRvs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He48bnvPn3y3gGbmdqBXl8z6n2YsxLRytRtin6YSMbXvzjJ7KnxEHwRjAhXHMbLAsdD60TRbtnuCpSrFasFZquA5SZ4wxudhRI9Q//+pBWMgLapVKWN7Rz5E52y8Ei7byizDxzHysEv36pHXyiBdWCynhHXNKYRLyvrqIG39+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FPxJ49dE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=apYC0TcZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FPxJ49dE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="apYC0TcZ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gpLLx2G9bz9tSc;
	Sun, 28 Jun 2026 22:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRjPBjPuglGnWcYt2EDxgR0fDCyPIyJQtIkqBiIfQ2Q=;
	b=FPxJ49dEGetgN/5e84HERwmCNj9+TKlfGnmNHB2x993dTS72TteObGCqkhWa8XZBTV6GHp
	gB/blLpqD7QtALe50h6loOcqmMy401LDaHXdcw4tNyM5zRf79cy+PZ8zoo+hirboW6HzE8
	Bx8M2EADwbPj0zimmIjfCWD8ULqkyKtQBSafOte3ZhIcKO9PSy0IhHEwQY/Hl028beVGlI
	6TOA6yuLlgD5hothDMykDg3LOMRo5rGoaycbh5Yqmb4KbavGmz8JieSNOx7OtPa3kmGW3z
	VMurq//K64ty6RHwucVGyGnenuX9EOTiRrsXH8jmkLec4BeY++n6E+q3gX57gw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=apYC0TcZ;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRjPBjPuglGnWcYt2EDxgR0fDCyPIyJQtIkqBiIfQ2Q=;
	b=apYC0TcZfZHw73DlxsMfV7sdGIZieeciDhp8qEIkQwEznLamPEybETpMuq8YsepP1BhS1P
	+zbk4AAcAu36MGbl0HK/UrkNV+wjs+/waIIpf8mhqtuD++C16nMj5Gl6SetLLj4G+kktsb
	WRkLPybaZM4VdRKBd+XzLfcow1uYSc2HfiJWTyjuE2bHkYogp758ABT7QNdBx4DU/bJvoV
	U/s/8a3prfMWxFjhU+K1xQGMqwV6zjZM7D2YC13IOE5QfP3z/9Ii5QbS8zek206JfSgguo
	u0Z5BDcNgARTg1EBC5I5+FaHo3dlsFjSQMn5jrOZJd1nP84twUG+3yDjkzQjDQ==
Date: Sun, 28 Jun 2026 22:17:30 +0200
Subject: [PATCH v3 2/2] pwm: th1520: Lock clock rate with
 clk_rate_exclusive_get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-rate-exclusive-get-th1520-v3-2-c7ca3ebcf60f@mailbox.org>
References: <20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org>
In-Reply-To: <20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782677860; l=1864;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=XTt9Wb3t8dMkZzuvXmoKi5n+eeWfIrk4FFd5V+XRvs8=;
 b=w5HEi6rilfUCETusSD51fB8jWGnN9098rDsP3lrQyWJzNupIqTBA+PY88VZmgt21lBjME+2K7
 32EsHv5Uxi1C122ip+EZkgnvYzI6pUIrzeiK7eAdGYUtTI/ohaIOw/F
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: b30f71789f64a967c2b
X-MBO-RS-META: 6p3fhh7ejax8dtf73i364e4ahzjzwsut
X-Rspamd-Queue-Id: 4gpLLx2G9bz9tSc

The driver derives period and duty cycle from the clock rate read at
probe, so a later rate change would silently miscompute waveforms.
Switch to the new ExclusiveClk wrapper to hold the rate for the lifetime
of the driver data and drop the corresponding TODO.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/pwm/pwm_th1520.rs | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 343a1178c5e7..8f9d3fa39200 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -22,8 +22,16 @@
 
 use core::ops::Deref;
 use kernel::{
-    clk::{Clk, Enabled},
-    device::{Bound, Core, Device},
+    clk::{
+        Clk,
+        Enabled,
+        ExclusiveClk, //
+    },
+    device::{
+        Bound,
+        Core,
+        Device, //
+    },
     devres,
     io::{
         mem::IoMem,
@@ -93,7 +101,7 @@ struct Th1520WfHw {
 struct Th1520PwmDriverData {
     #[pin]
     iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
-    clk: Clk<Enabled>,
+    clk: ExclusiveClk,
 }
 
 impl pwm::PwmOps for Th1520PwmDriverData {
@@ -319,10 +327,8 @@ fn probe(
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
         let clk = Clk::<Enabled>::get(dev, None)?;
+        let clk = clk.rate_exclusive_get()?;
 
-        // TODO: Get exclusive ownership of the clock to prevent rate changes.
-        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
-        // This should be updated once it is implemented.
         let rate_hz = clk.rate().as_hz();
         if rate_hz == 0 {
             dev_err!(dev, "Clock rate is zero\n");

-- 
2.51.2


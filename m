Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277239A045;
	Sat, 11 Jul 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765034; cv=none; b=BGhSQxgc0JlsLFa+7L7wol4D3QWGRFJkBZb/MQJszHXAhFtWRT7wdVbvUgvD1vRD0TKoR3Z9ky0elzSltDVYHy5RmKVFiEEKOhpV6JJdUWTjtIr1DZ/F0onD9ird3Kjs3RNOkitZaC62xserAFivffOsFnJxuRWBbcELJt60t0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765034; c=relaxed/simple;
	bh=XTt9Wb3t8dMkZzuvXmoKi5n+eeWfIrk4FFd5V+XRvs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAf0xl6AF/IsiIEKXp62b3azpRay7hUEALJgBJQtpc2+uSkWJ8jYzljqEACzH66Wy95QPY6hLv43M/o2xb7PAPzDV6HhCO2qQkimKKEBfmE6dzto9x3o/LCpRZHxmnCc2ZNIp8r/1lucb1TNKFqjyNT3Lmi0O44l9VRr2y1PrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JfbgCxB9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q70adOaI; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JfbgCxB9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q70adOaI"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gy4Pb4bqTzMlFv;
	Sat, 11 Jul 2026 12:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRjPBjPuglGnWcYt2EDxgR0fDCyPIyJQtIkqBiIfQ2Q=;
	b=JfbgCxB9TRUQa2kRRu6/cJGU0wPjcmv7fX55qqEmbHZ0ZBPsmvahGxERdI3w8yHgLceIw/
	v3WIO+frbIBOxtCnc882BIRJtf6A+PRthCeNqjvmfUP7ueRDcxnYYxEuIcJtNG7JmhD+QK
	wRK7ct47rQoNnK5r0sBtjXF106cTsV7uPDxh5F2r1JYXfuohK26BmOLzxYqCY8SoVDpGrX
	HBojyS7/Eg4VFqHmRQlvKX+DzTljQ52TC3OpPEZ/Cthg9BMF6pquBDCG/f7awW6w1LsQ/J
	fx6lTEQnJpaKU9EgJIpAFeRr8ziEwSICtESWDb36pUS3Oo5ENoYDO6A9XSQDDw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRjPBjPuglGnWcYt2EDxgR0fDCyPIyJQtIkqBiIfQ2Q=;
	b=q70adOaIXLu0oeDkLv60N190Se0roRpqKdZ65Koz+f/N4vmnnBmjXKqMg5d0umux/Urlam
	sIl0OPc4e4dW/omhOsgG5BaazlM1UGO2u10Boy7Fmk400mNdbbQlLsf4ovRMFFm8i8Krvr
	cAYeJ/bStSQt+HfsysQEZ8OhOwXsp+OzmG1vuE6rF73pM5h9l7bxDKHd5oPIpdAsk8oL3P
	UFMUyKvLomcPDcO33xP0pvpZESKWdO9fmmB0YOhLK0jCW1aoFCpgmdFMjfKzLSUnwhNefR
	KaPmy71mCxx+yjtUl45uEAmRmPReMsWrpg4x5LJaRPiXhLLQ8wp+ghSQ1iT/eA==
Date: Sat, 11 Jul 2026 12:16:30 +0200
Subject: [PATCH v4 2/2] pwm: th1520: Lock clock rate with
 clk_rate_exclusive_get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-rate-exclusive-get-th1520-v4-2-8244a0666a71@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783765003; l=1864;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=XTt9Wb3t8dMkZzuvXmoKi5n+eeWfIrk4FFd5V+XRvs8=;
 b=WvdYOvOJeyFL1eIjD68+q/wUtv03eytEyxUw7mCbEVVNZnghVv3RC/d32QX6gAzQhzT91VZV+
 1dPp67NmmvQB3aPwHyICcmbvq/5iFCpDGSCjr5QxraWFOMRDMVvRr/1
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: c60d8243f9904d1ba72
X-MBO-RS-META: yus6awgdopfyu6x8nzir3j1jsbja9zx7

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


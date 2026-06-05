Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162A12C534;
	Fri,  5 Jun 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643060; cv=none; b=DiiivO+6LEX5xBOwKhCXdhK/VrhlWseKavWHTmftxYQzgJBCXYxyv8paUFwSi01n62MWk7IYvZqibm5aOcm18PFjczCRxqEc1L4Xv3sQyqKSGgYuBw9yirdPdzgSGdYtUK3I2gMXXEWyBnpDAi/QtPiDtWsHzsONgYjSfuK72JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643060; c=relaxed/simple;
	bh=S9iY6KDO0Rjw6QzufoKdMfedvC55eNxqwfN5qPA2+QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RuImR2BpsHv1rmeyPX9hkyU5vfzIKmmkDsHBYnXSxmQj08yOi9fipFZZpD8MpjwolyGuo2w+NwyzID2/6EwUmISz93Ffh3zE2RAdCd+gzpHK6eWFIoBt7p0RJtkr7XSQc7CyLWXsytvGy07r6DtFIeWuNzh0K3QC0f40ujWKztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dJvWzT5x; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jmYkGJjR; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dJvWzT5x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jmYkGJjR"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gWsqj1lnJz9vJR;
	Fri,  5 Jun 2026 09:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780643057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+mai7VLyYCKblUWMi7AhqferG5Xrd5QbJI+z3xIF9Qg=;
	b=dJvWzT5xeKOTkOm4ZDBrIcSFqax18gMFuDZ1c5kr5hP7xe9GZRMvdoZDsDBAdItxdme+lH
	ZJEFoGYm3z61qIla8Q8w7DR9xl1aMt0UFZjdYQD99UVQqdy/kRRLakW8T1de+9S0a8xPxj
	6Y9XUM0iNAMZ5fPcHw7esfBJlZVV/p4djuZhL4z3X7i0Uo67sceydYESvN3lGTKZSQtP+s
	UOTEY/MsemvGLJ6Ml7OtxK8+wwukykd9KcQ41a47b9JGnncUgdXd8lpwf/8SNZM0z+jpMS
	3OpQNgLcpLIfMOlhGjJfjYu47cVzBJsMcuIEm48jpZyN8pqsva6ymLnwXDu4yA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jmYkGJjR;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780643055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+mai7VLyYCKblUWMi7AhqferG5Xrd5QbJI+z3xIF9Qg=;
	b=jmYkGJjRrA51RBH6OMpOCbxJTAUFzbxaluOkWfq27OH39VbDa2+5jRf54GC2TAoRto5dGa
	GmAShbXLEMrpFKmW5Qc/hpA/bmMw6fBMSpMOz7+OsCHgq3eorQurMx8d20ypCzL7BtG2hM
	Ga9nlYcsJmPtcmvHOsXvmck4lhsSzs1WDiICSzRYauT6nul6+tXfKpIPr3mbWDQ7IAlqIO
	8rIbISUMlZTih3RQ52/5R+4g1weA6999MSbOtqNSpDWPbasSx+BurKDn8JfhJDexyDYAJa
	sxR5PX8ywb29qCK7EtKemz6ilvbivN33CGTLu/Y32equRjK7a7a/ZRdSD1UYPA==
Date: Fri, 05 Jun 2026 09:03:59 +0200
Subject: [PATCH v2] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-pwm-th1520-fix-v2-1-5921e3a595f7@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ6DIBAAv2L23G2AitGe+o/GAwjKJlUMGGpj+
 Hup9x5nkpkDog1kI9yrA4JNFMkvBcSlgsGpZbJIpjAIJhomBcf1PePmuBQMR9qxtbWUstXa3Di
 UaA226HP47As7ipsPn/Of+M/+XSWOHM3YDaaTjVG6fsyKXtrvVx8m6HPOX6+EHYeuAAAA
X-Change-ID: 20260521-pwm-th1520-fix-8e45558bbd31
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780643046; l=2776;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=S9iY6KDO0Rjw6QzufoKdMfedvC55eNxqwfN5qPA2+QU=;
 b=jXnPJydMlCrJtVaM2PfRd/LC4zd+fb598vSl6m86kVDingEeufK8FWKhPTmuJRO4khnYKqvA+
 7MUjKIgwgYKCKUaorb40SCFll2zNRmJQ8UGDCEHKuvBnzPmLV9i8cFr
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: hb8pa7gc3qkeu5jpt6i1ur9soi4ut6xh
X-MBO-RS-ID: a70b030992298b0d317
X-Rspamd-Queue-Id: 4gWsqj1lnJz9vJR

The cycle register is always u32, so cycles_to_ns() can take a u32
instead of a u64. With that narrowing, cycles * NSEC_PER_SEC is at most
u32::MAX * 1e9 (~4.3e18), which fits in u64 without overflow. The
saturating arithmetic is therefore no longer needed, and the ceiling
division can use Rust's u64::div_ceil() directly instead of the
open-coded numerator/denominator form.

This also drops the TODO referring to a future
mul_u64_u64_div_u64_roundup kernel helper, which is no longer required.

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v2:
- Rebase on pwm/for-next
- Add Reviewed-by trailers
- Link to v1: https://lore.kernel.org/r/20260521-pwm-th1520-fix-v1-1-df9cd956dab4@mailbox.org
---
 drivers/pwm/pwm_th1520.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..933c1ec59c2a 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -67,16 +67,10 @@ fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
     ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
 }
 
-fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
+fn cycles_to_ns(cycles: u32, rate_hz: u64) -> u64 {
     const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
 
-    // TODO: Replace with a kernel helper like `mul_u64_u64_div_u64_roundup`
-    // once available in Rust.
-    let numerator = cycles
-        .saturating_mul(NSEC_PER_SEC_U64)
-        .saturating_add(rate_hz - 1);
-
-    numerator / rate_hz
+    (u64::from(cycles) * NSEC_PER_SEC_U64).div_ceil(rate_hz)
 }
 
 /// Hardware-specific waveform representation for TH1520.
@@ -192,15 +186,15 @@ fn round_waveform_fromhw(
             return Ok(());
         }
 
-        wf.period_length_ns = cycles_to_ns(u64::from(wfhw.period_cycles), rate_hz);
+        wf.period_length_ns = cycles_to_ns(wfhw.period_cycles, rate_hz);
 
-        let duty_cycles = u64::from(wfhw.duty_cycles);
+        let duty_cycles = wfhw.duty_cycles;
 
         if (wfhw.ctrl_val & TH1520_PWM_FPOUT) != 0 {
             wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
             wf.duty_offset_ns = 0;
         } else {
-            let period_cycles = u64::from(wfhw.period_cycles);
+            let period_cycles = wfhw.period_cycles;
             let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
 
             // For an inverted signal, `duty_length_ns` is the high time (period - low_time).

---
base-commit: 5b5e33c44a491d5b5e019f527e028bd567a226fa
change-id: 20260521-pwm-th1520-fix-8e45558bbd31

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


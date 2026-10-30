Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325771;
	b=Od/9pD4eUZB8xCwek6cpeFIsepqGudY7kis2GaMx9m14bfXJIb0Ww3fB7QlujR/zUJac
	 /dBdLZPa2XFGZfJVaC+x2S92/jgAp9N0WQd2jnWfbZYnd9maGfBHqlhylE4FUtp4Z1RJq
	 0eX1ccFPfPnzZ4EV+a7xD1lKXWu31ZJ83BJSqgNnRjL815cMa4bz2k2Xo2GOUmz0dBS0l
	 HP9OXoZfLpTmPHLlGGYS/c2OnLDX6We+ZubzlF4K39Jz1SFWravjpZ6/gNi8/GkFNKM2v
	 nT5/RCq839Js6FUyoLsMsi3trjhpI+bJpE8Y95XGXJ1mQyCcfF68Hk5A2SsdODxIUiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325771;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=8FSUHia2EBT1gZ6mpOdD7icS633gtzPTs1MVNfteiHk=;
	b=QOpAlYHQZarz57yhuHq4TJ1GVQEcdqATSFiQfdY5eVk/KliPMJorpCgnL5+uIar/fpzl
	 qi/wvpBOTGzskK1LDSMMSpkmbNDfJsTSL0Zp6XUOMrGr1HK85x0qt0VuxhS4KaE4gRW+r
	 lQwzgqAivMce2MnEIwS0wm/IOdXprw1jMbx5JPlC/vyg+DmM1bL4prSkhhAuj4W649w9Y
	 GJV385Bn7u5xGmSXCofLG+MxP+NxGxXbtLG1W09Es5BVzu6mILq+YlrO9jCx/9q/j5A1z
	 PN1qMNP/zdhshMfS/SDqI5kxEvxsdKMC4ZD2xeqHIdPAyyxcTjx2coEftoAC+uW6qMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=dDQI278T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o3SLpNXW;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CF606A31C
	for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2026 02:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=dDQI278T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o3SLpNXW
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CD19EC0588
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 22:02:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 22:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793325769; x=
	1793412169; bh=8FSUHia2EBT1gZ6mpOdD7icS633gtzPTs1MVNfteiHk=; b=d
	DQI278Tk35huSP22Rxg/GL5OHIwGT7GUJumrZxQZytpuVOy35O2JNFl54M6a285l
	EeVfDxkE5MuN6zSn1m9jaIugZylzebrx2YccWtIyWcYVG/Eh9jgdw3tm9dmf2xrX
	PYqNf5WjV/VMbDyFyA5uV1W06C/jUi+qkY2pCxK1ftNbfnTcoMzcjTsyBsDCYpLu
	QAH/zd+D9FwqaOe2hIBaSr8NumZtlBObPt6ivcxa84mk6WWopiBe9nDuEeFbLqNB
	KBT/YKBVzAqd4Gs+C1yOJsaI4SS6P+tn2uHBaVYdV4j+Ye0MLOgmYgXkJ8syMcLI
	G+mKh5PFdcw17Zu6UNbPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793325769; x=1793412169; bh=8
	FSUHia2EBT1gZ6mpOdD7icS633gtzPTs1MVNfteiHk=; b=o3SLpNXWxwlsOAqse
	bZPtOjsvpeO+Bt+8GtISstRS1YBsh0ZM5BD8I8Dwpu/hHmCzY+SVPxh+Zo2p5XSP
	LDtjAEGL7sVDbLFO/+A49w4ZbIz2ig20YuGd9O+D2fugJrzyB5mDEhsPqLuAtzpO
	VemF5HsaK3ctf0b0EchitO7lUrV+jFAlYl+qvdAjlYeiT5XCh1ArA8Uqt7Hs57c6
	4I78q5NQ5Dhnrc9ta51dQzNoLfNHCAocP6CJ+M86xosM7hVt/typBbVdAmYSSD/0
	FtsSljZ9A/AXjnNQTXGZnpkTkAifTuETfD9fh7vFTVlfE6OwiejrAk6Cs9R7myF/
	5ddQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793325769; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XkeSMvHrOGA6+AtGFUpp2FP4dwubGHzmJVJ4AzkI5I2wZl1
	SJvr9z06pOvYXrJOsY3qDN7dVQRV084hvA8Asfs5onRzECNr3zn94vu+aRTzE/Qb
	unu+Xg0fOowIB5zKKHY5JH1LCY2E9ZJ1tAyW1/SGP24m7n643DCmczZ+8UGu8N8x
	RIxxCRt376YrUsE23r6fspZULrHGQinepZVwr4PbipR30wHzUGmCUuORflRuCyDk
	06AAc6a8ysA+9tXmgNC4g5hA2XGPcQA/RzAlI5VT0rajofjomnZd4GoIIlO4TLin
	3puuFWljLklY55RWdI88QRZcyFyJeHn9XoE43Gw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tRNRS8CP3XmcoeTAGMaam1BQZy1cpW07dXxF6Ce3hkI=:0xOZxCHC3pzu8FXs6nAbzg+LHJNb5fZqbGeOkedS3bM=;
X-ME-Sender: <xms:yfrjapizhEaG7GeWnYbGELGXKxceBmnjhW4nlfV6am16DW7_VuGSFA>
    <xme:yfrjavoOxLX_ZG6u604B8yXA1F8jGN-7i45H7TS46jLprYiy-ZSoffUw8GsfmmmEf
    33UQwjVF_WIaic0-JqtiDH3Lf5v8HeIblPGvnYAxpntVcniTl2UN3bV>
X-ME-Received: <xmr:yfrjatLhKIvFPsZZMADjGbGOAlR5JyXM-5mvFatXwDmeOqAcAN4Lkhlk5i9hWzgv3y-gQqJhJ1wrJ9xGrDg>
X-ME-Proxy-Cause: dmFkZTEVTXDrw+a/ZnnDdAjar6rXxTxYY9fIUdO+d9pbGqZkClU9xD1X9nF+Wo7rIZ+4vR
    /smsFdDh+872K80vScbcBxAvt0KBIRi5vqKaomzRbKh1yMb94byQ3BB6d2tMElRqiKk3eR
    K/Du9ywpxh0upliIYQSKHr7IiRXNoaEcem5HKUJD0YpdCFF2/kmJHBalhCYDjGdgtWTVbi
    HcCvGqov0AK404rI8+9k+VDgb2bkVeOfvgVA1pWqcKc90MPvFCkIcwTFK9X2f84cOjfl60
    9Qr4HwLcsvVHM5FbrFSSYURaOtS/S3cYlynh/uun1A675PxfgvEsvurvQ+FjrmTwNyictt
    IcpyKUhQ+rFLM3K00QR6de9HqyW5O5p27fE+xku+y6WBT9mJJQzpmLcaMz1kalfdw5QbnJ
    6SJzpfdROOoF8NGvCEP1LyvXa9wFGOIE+SQjD3BEnpfnwysfILVuzJNMXGOhgUm3tbVPn0
    1SflSrBUepVo6O2uE0aaws+GptaQeODMlxLWAURFl9yTHYwHkcpFbh/rdXO2FQFOHNVMtF
    8Ywk/JHDHh73uUU1IBjX6fdX7/a97s0GfWhxb0sgcpCIB+DtNBDjQ1z0ydDo7yjJcRxjZ3
    hHL+KYx8oGFHTznJ7VN29oxvIg704WyB10wyYo6kf9BPaNBLGT4HqRknC/tQ
X-ME-Proxy: <xmx:yfrjakt59ArTh4dT3bSpM1evMhz-JJClAbrAGHnW4X-XotRcsuZeTg>
    <xmx:yfrjalujL_jNW7P8_BiSH2MB6UURBRtAvisYzgHCMO3sL6e72B5Xpg>
    <xmx:yfrjajVDQf3pdVV_DV_vN1gaPzJ0lrHFK8zA4UJGKMa15XVDrZMtRQ>
    <xmx:yfrjamVMM7o8Cl03kEs8IBIBwv_YU4gN0WBs7zRV8mKbMBrwsxPHvw>
    <xmx:yfrjalMe6cc6qi-vmMRA36EZkWMk1tc7Hukk-oUwrboicDslToFIFt3j>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 22:02:44 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: fustini@kernel.org,
	guoren@kernel.org,
	ojeda@kernel.org,
	ukleinek@kernel.org,
	wefu@redhat.com
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	chenhan0017.work@gmail.com,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	linux-riscv@lists.infradead.org,
	lossin@kernel.org,
	m.wilczynski@samsung.com,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v3 1/2] rust: math: add div64_u64() and div64_u64_round_up()
Date: Fri, 30 Oct 2026 11:02:08 +0900
Message-ID: <20261030020209.3833766-2-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030020209.3833766-1-tomo@flapping.org>
References: <20261030020209.3833766-1-tomo@flapping.org>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

On 32-bit architectures, dividing a u64 by a u64 with the `/` operator
makes the compiler emit a call to a compiler runtime function, such as
__aeabi_uldivmod() on arm. The kernel does not provide these functions,
so the build fails when Rust code that is also built for 32-bit
architectures uses `/` on u64.

C code uses the helpers in include/linux/math64.h instead. Add a math
module with Rust versions of two of them:

- div64_u64(), the same as div64_u64() in C.
- div64_u64_round_up(), the same as DIV64_U64_ROUND_UP() in C.

On 64-bit architectures, both use `/`. On 32-bit architectures,
div64_u64() calls the C function. Both panic if the divisor is zero,
as `/` does.

Assisted-by: LLM
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/lib.rs  |  1 +
 rust/kernel/math.rs | 71 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 rust/kernel/math.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..482fef8be2e8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -100,6 +100,7 @@
 pub mod kunit;
 pub mod list;
 pub mod maple_tree;
+pub mod math;
 pub mod mem;
 pub mod miscdevice;
 pub mod mm;
diff --git a/rust/kernel/math.rs b/rust/kernel/math.rs
new file mode 100644
index 000000000000..395816639af8
--- /dev/null
+++ b/rust/kernel/math.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Integer arithmetic helpers.
+//!
+//! C header: [`include/linux/math64.h`](srctree/include/linux/math64.h).
+
+/// Divides a [`u64`] dividend by a [`u64`] divisor, rounding down.
+///
+/// On 32-bit architectures, `/` on [`u64`] needs a function that the kernel does
+/// not provide. Use this function in code that is also built for 32-bit
+/// architectures.
+///
+/// # Panics
+///
+/// Panics if `divisor` is zero.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::math::div64_u64;
+///
+/// assert_eq!(div64_u64(7, 2), 3);
+/// assert_eq!(div64_u64(u64::MAX, 1 << 32), u64::from(u32::MAX));
+/// ```
+#[inline]
+pub fn div64_u64(dividend: u64, divisor: u64) -> u64 {
+    if divisor == 0 {
+        panic!("attempt to divide by zero");
+    }
+
+    #[cfg(CONFIG_64BIT)]
+    {
+        dividend / divisor
+    }
+
+    #[cfg(not(CONFIG_64BIT))]
+    {
+        // SAFETY: `div64_u64()` requires a non-zero `divisor`, which is
+        // checked above.
+        unsafe { bindings::div64_u64(dividend, divisor) }
+    }
+}
+
+/// Divides a [`u64`] dividend by a [`u64`] divisor, rounding up.
+///
+/// # Panics
+///
+/// Panics if `divisor` is zero.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::math::div64_u64_round_up;
+///
+/// assert_eq!(div64_u64_round_up(7, 2), 4);
+/// assert_eq!(div64_u64_round_up(6, 2), 3);
+/// assert_eq!(div64_u64_round_up(u64::MAX, 2), 1 << 63);
+/// ```
+#[inline]
+pub fn div64_u64_round_up(dividend: u64, divisor: u64) -> u64 {
+    let quotient = div64_u64(dividend, divisor);
+
+    // `quotient * divisor` is not greater than `dividend`, so this does not
+    // overflow.
+    if dividend - quotient * divisor == 0 {
+        quotient
+    } else {
+        // A non-zero remainder means `divisor >= 2`, so this does not overflow.
+        quotient + 1
+    }
+}
-- 
2.43.0


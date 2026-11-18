Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042296;
	b=cSxz9KyaPsASgJT+MKItnfKGbGysyb+QkxeDOVae7a0ITsX5+vmnTnypAEFgL0/XbLJC
	 FZcKFWJqAYeNzpVMj/hbKXeFWCwENv+pKgeKdeIvZdYFcbxSYkLW3o0vXEbgSARHV8oCG
	 pc7KEvr54tJCnd7lha2BrFf89On272sHYt+MylQDMtXpmo8q3gxCC5MeMJldOsITF9yKs
	 TowwvDp0ByZY0vUz7RQZ3K6x3MrGhu+csVIvphjc63oYhwy6I1ch+Ag5Vfq+IrLwbe96x
	 DcbFMH23+WyFuu5ZbrwgrHaaK4+BL4VQUdmur+X3WzN2bFdtKnBBmH459QVEqmRwh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042296;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=CHzVwGG6EOgLEWwhSfn573Ka0YCiRiZ/KUZGFq0q2uU=;
	b=rHr9ly/luACaTJxJoslqTBMT4q+3s8tle+7l14DuctbqQSbrRupyhDPzDb8Jy8TFLeAx
	 66lhlEuFW9TWl1zDz7qq2JESa39XpdQ9rsjKJe2Hvbx50I3PTzmRcOXhSj0O63RGOeadR
	 c2RRM7VLIldmvQqnXTf0rs2LFqexz/urWqGRmX3YYAAyTWEe22sEZMe0gpreDFeFc38Pu
	 tddNMY3kw5VOCuogUDRKV2p++2b5UmRbBslFUqGttxB1PAd/0TOHzQ4ubr2+FjT32/2F0
	 kPLy4t70XtHRi56pOw0/i5ukpqX/kwT/QQIC89oefHTmL3dGwiSQd72EcKCt0ZWkOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=dbAPXr+V;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nU5mqbhX;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17210606A32A
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 22:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17210606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=dbAPXr+V;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nU5mqbhX
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CA0A1D000DE
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 17:51:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 17:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795042291; x=
	1795128691; bh=CHzVwGG6EOgLEWwhSfn573Ka0YCiRiZ/KUZGFq0q2uU=; b=d
	bAPXr+V16hwvzzHEWDyVayv//Ko2IT8SUG/uUoHA8slt2eXLlvdow5gPi5XohLhX
	XmE6Xc35ixwxFLYotelDQULqbf8/+Dp1Wn6fMFB+rPmVi7gG1KYIMuezDJe/iu54
	86wPshwnG/mrEjXtppP2Chvnq8pJi/SfLlEt3S6oQjCL17BD+Z2vACITkvgYl5Cp
	1TTU2b84qtWKSiydsdhbKVbd/Y6yQMSksbRtLAWiOJxXsVeLWavJ3tl8pWhfbadz
	cg5gEYaat9gpGiut+o+BOXNFp61QUKb04dRoHMd2bO6AvduyAeijL3YP1lLqCNfV
	jG5WyimY4bIJ4N9k7Uw9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795042291; x=1795128691; bh=C
	HzVwGG6EOgLEWwhSfn573Ka0YCiRiZ/KUZGFq0q2uU=; b=nU5mqbhXPz+FF+U6c
	c6SqUQdU0KVAuZtWxFmYFedrj2SxsxyJbpYe6MGBE0CzMz7MsXhaZwUvjWgwqyTF
	AB6u/bzURv1vgmRU/bZgzHVhAljTaet6WxfrqBiGyVmSKNXBH9hYPmsmd0WWeHXC
	luISYZXC3pinPZR+wHFKcau2qQtYC8rXTtedYEFdJcvyhdlqDiQTf67b6Ed0tPI3
	S6uOA55AvRzKOpeuvfYnltXhFkEuZIUrvRApn0mxihQY/PltRChNioA53rnWed1J
	+9rQsuzcXU5EDboIkz3hMP7tV/cfvOmrWqLkq/5bbZ6vyn8uq/+fOhLyOyJaoIBg
	lA4YQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795042291; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Gg4XzG4fjF9CCF1zSp/w27FEdxxM5zgOfRnn510g2gqamCB
	mQb5qfih7iRYMa8cHPkdb/cUe3CtBQ6mGo6u7ttbTLQXbP/9Jj4bMrdGQyTIY7ER
	2LZRSQsLhKwz7P6s4UNL2dojk6cDuo7IMOJIPrpy+Fd/EiwX6RtXzcs4pzQ+b3K5
	OZ6EbOPNNgM9Y1CV5SSx+H8JT38n7LnCzl6df+mHxGihQ/zQN70gauc9AXBE8zMF
	RUSTlXHH3gB3neDXuRkn9hOMDWDmEPveMmlefTsq3fkS9nCrCuTMj18YANzq2ZZd
	HSmQ2DslBKEwqF2uOgaF5PtvB08skVPnW4dftEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rg7VLTODDVm8P3xaJwWih08zaozJnwLl8gzIUGnx8Ww=:JKfe7yYjlm6+R+J2TWcpCGn48NNGeYzocWI8DyJRjWw=;
X-ME-Sender: <xms:8yv-asRhcwoUrSvW66DpZ1At04R3j1RBtk_UDGjvAbnDjyO1OumtGA>
    <xme:8yv-atSdaJz631UGYnAiISgFP2A6SQcVAtvVE4hmpXrLLqsE6z-WeDuAwDW1Lrwf_
    BmHdcyC2gZS5jod0FNA5pSKM0ASaP0T2SbcW2eaZxD8hdXJ6ZBBE45U>
X-ME-Received: <xmr:8yv-aiVS2bPpQASi6D8p1OiNRegi8_N5zvFze7VoBx0pJVtTSLi0ciL8yyoy_DIjuYmj4z9GVuMWGypPKM8>
X-ME-Proxy-Cause: dmFkZTEnoGXV/KCC4fAh8bvdJTDrx0jo+nARus1TsdK2RBjKug2lyOm5Bb3JJQSdnvSxOj
    XeoDBJmIqD7sP5hvh1Qf++WMqZDzuyVPMdH8dhRRgFQ05ZxoHemq8iorrGW+WLMhkknqSQ
    Pu2Zma46JFM/1ZxkZ4rzcaedLGGxHcsyGACo8YRKNiSNC6ywxc0TbT1qh/fBnAFl2AfRdO
    AdlUzUrXXL5MExF5Xi3lItbHYF6Dga8deBdMPK7N2V4m6GHUiTgavkEGqr+FW4mVAHnFVD
    2Oa+67bFlue6KgoctrlorgyzYe14kLapbwgWSwEx5q+3R/TEUDzIK2asXxqvUjz2fT6sYv
    hsjoKg6ETVmeO5IjaqmkrTWrcAgyFSKNgtpFWvrqsUejt/rskWWG1qp9YHSvb1g3qjiGna
    Wyuv2bNB4mDjYZ5pI3IJVSJNcDtB/qwVU58itosWL/dGnDUaFliXR0dY1cuo7S5E+z2FjC
    pFslq6XW3G/BLyEZ6psKfBkP13ZkknV+4oK+rdg3s6oOx95kF95gOCpE9B9U5CnteAXYzo
    yy71BO3Pc+S0dal/zzdTXZ3ORel9NXV+cQQXx88B/aLYSiuabi5DNYRNwXhQdgFCgvDijX
    xcHP8WX1qU51XnqmJ8slxLPXg/2EuPPEmzGsL4EDGKgpKZevaLt2kFkPZj4A
X-ME-Proxy: <xmx:8yv-ai3Ua3HclMVR6_YNbYYktqA5l7h8AdNTF3zEC7gHJsnHixYfNQ>
    <xmx:8yv-ap-4Vs1anQUMcZKZGcjeYASPDtOHJte32pyue7Q1_F-Vq1fvdQ>
    <xmx:8yv-aoeGi8Q5CZts1lUfBtDCqQuzf-AfWJEc72x6ZCw5ExEfEdvCxQ>
    <xmx:8yv-al5hXC2-5GaZ2-bqoGhHFvi7x0Af_FDySBAf2eCjdZbZZIuXfw>
    <xmx:8yv-aqZdPpmlnvh2XcsoNCLNrnnGbyvRNNnEl9_xo19yiA0ecXjl10DD>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:51:26 -0500 (EST)
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
Subject: [PATCH v4 1/2] rust: math: add div64_u64() and div64_u64_round_up()
Date: Thu, 19 Nov 2026 07:48:25 +0900
Message-ID: <20261118224826.2491684-2-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118224826.2491684-1-tomo@flapping.org>
References: <20261118224826.2491684-1-tomo@flapping.org>
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

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/lib.rs  |  1 +
 rust/kernel/math.rs | 73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
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
index 000000000000..909afcf8dfa2
--- /dev/null
+++ b/rust/kernel/math.rs
@@ -0,0 +1,73 @@
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
+#[track_caller]
+#[inline]
+pub fn div64_u64(dividend: u64, divisor: u64) -> u64 {
+    #[cfg(CONFIG_64BIT)]
+    {
+        dividend / divisor
+    }
+
+    #[cfg(not(CONFIG_64BIT))]
+    {
+        if divisor == 0 {
+            panic!("attempt to divide by zero");
+        }
+
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
+#[track_caller]
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


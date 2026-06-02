Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBA1DA60D;
	Tue,  2 Jun 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410626; cv=none; b=O0H3uFvLRFNA59sywgIFyHlE9X6X/DnmsOB1aOjarkqypstDJTHXPeOi/i7cutqcOSt8KfiwPYKvbC90UreYCc8gIrNyUl4o1H+yrlobqqnpKWmB0VGjX37DMRDT4oe5/cvmOC6IV0ghw+Sd2kb/njzu78dZrLlf56bV97q1D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410626; c=relaxed/simple;
	bh=16i/JJjNhoMN1c1Ms7nybdLc81QMezO68mt+246DxSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7NzJyIsbfJb9leu2OIcd/5XjZZCZda+RAXtKEOxNc0ppYzcI8+GYvnXGv3jHq/tG/1rAlrO6R1VUUynA6oES9uycqNkQz2gw2TuW+c8npimZ+tthMKDeRC1hRijty/jhLxsMIJ5pA+L/cQPvR0NBzM7WUwDZkxq4P0FIcdOXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com; spf=pass smtp.mailfrom=privacyrequired.com; dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b=FAoBtotV; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="FAoBtotV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
	s=stigmate; t=1780410619;
	bh=6TKcjPnH0nC1FrF6sUHUFL2v1lRBfi1+s/MSYZAUc40=;
	h=From:To:Cc:Subject:Date:From;
	b=FAoBtotVFVugE4ZqRUGdbc1U50XhYOIsxJMvVfIaa1j4lY/0QOWH44C0Ih+6jth6M
	 dayy6jErXtVxhoAZo3648e9zrIrpA0I/q9IVbBSQMfWxdr23KWu/SJl8/K7jPRo6nJ
	 kWOhPqdy6dRf8ah51sWH0WJzWURCVhFnOg626QXo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gVCsl6PH7z11MR;
	Tue, 02 Jun 2026 14:30:19 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gVCsk3BrBz11Ll;
	Tue, 02 Jun 2026 14:30:18 +0000 (UTC)
From: Francis Laniel <laniel_francis@privacyrequired.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Tue,  2 Jun 2026 17:30:00 +0300
Message-ID: <20260602143002.38390-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Suggested-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/kernel/pwm.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 6c9d667009ef..3427b7d93a03 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -494,9 +494,7 @@ pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
 /// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
 /// expected by the kernel.
 pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
-    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
-    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
-    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
+    let mut ops: bindings::pwm_ops = pin_init::zeroed();
 
     ops.request = Some(Adapter::<T>::request_callback);
     ops.capture = Some(Adapter::<T>::capture_callback);
-- 
2.47.3


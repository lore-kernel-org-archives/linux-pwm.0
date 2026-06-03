Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F103E1696;
	Wed,  3 Jun 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502972; cv=none; b=n4YA30/zBr7FNanPKGMIC8+7QDOuG3EtkNU/Kr9t8yj0wA/J6tQ1wkHNgbTIvRXaSJkPLOlSiwBf0GzSrXX3E/RiUGgViOJW0PT90XyTEjWnsMsWLWISKWpbXbhEFbHsanZz5fPzPVNt6QMz3Epue3ssrqOGpQT82zelOaCpYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502972; c=relaxed/simple;
	bh=WORJHmS5AbdBJkAua/xhYAI6MCvg14NUZOBqKp8uMp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeyWIp6DTnLXanrGNfILmJBQVQR3BudwT8xaAo9KbKNnURWS4pfIm0PQiYx2Gye253cY2L8pDEAIvYqlLo9UYB2wmsJ+ZhWT3D1rlqFFkGCfyfIJ7kIhoAeAztwXeppYEOBT2M6bKfov0VElBDoNQ/1yQrZzHvUpftRuYQ4GVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com; spf=pass smtp.mailfrom=privacyrequired.com; dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b=cVj6ILnx; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="cVj6ILnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
	s=stigmate; t=1780502960;
	bh=N1j58YIfvL75mFmNhYJnpjVAlyOHaTOSZqO4NHOEnxg=;
	h=From:To:Cc:Subject:Date:From;
	b=cVj6ILnxSUpKRczSVc9h6sUuK5/bQLE5KkeodFmQ6H5aBcDeplEV5SS7NaRFFlE67
	 +Pijwm8bosfXWnYFwpVoDtylrQ1oSUJD7a11Gk4DBoKxdlg1PirXV+SJlHbBjZ6tBa
	 RUQnmO0mC+TrR9P5Ess7fSI8jonHgcTEKrA5sPcI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gVt1X1H0lz115F;
	Wed, 03 Jun 2026 16:09:20 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gVt1V6CFyz1154;
	Wed, 03 Jun 2026 16:09:18 +0000 (UTC)
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
Subject: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Wed,  3 Jun 2026 19:09:09 +0300
Message-ID: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
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

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1189
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
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


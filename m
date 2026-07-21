Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9D437866;
	Tue, 21 Jul 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620503; cv=none; b=Og6wFZBFuItmcfdkV2hcQRu46dXevUxm45mEvbMoZ3I51aGPsXZs+nW6HGhV/vj5kWxR4lF9UEMqi8zLhGl/Ka0xkiDr4CA2m4iMWJQIP213pZHgOqxbCQkJX3PQT1FTMiERaSlIQmr0JT9oXYC6xM5kPkOoDqV8OgsJPEmspb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620503; c=relaxed/simple;
	bh=zgZCx6f5e3YjORwGtUiplRAdJu2Oq+Ptz5Q5lkQjVRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SsrGZJA77fL7QgE6qa3QcBZKwvqcjI0AekmSlP4L/Js1DEF1RGJEUSANQBKgFsjFzIWWe7J3ZroxGhHA10Xs6BA5Pp9qugwc75S10kZ0pSrEQEhzGecq2CCFr3IQsMaifRD2LpkRADklthTSAJFoKtoAL4YtxIj5wjTKErJlROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=JOvvoTsN; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="JOvvoTsN"
Received: from [192.168.1.103] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4h48fl04yFz2x99;
	Tue, 21 Jul 2026 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1784620176;
	bh=iks/xDPE0d1M9emSWbUSSzGi+JoBRcg8Z3T2an+YYQc=;
	h=From:Date:Subject:To:Cc:From;
	b=JOvvoTsNQLQcVEwVHpsEkmzeom4o/PDhpWUgfmtxNz4W7e4OSDSdqcbryL9enKVxM
	 6Tf6fuyDVh57CZq4GJBVR+lRkKOuUgY+8PoHpUTC07nPi3i/nHKoiqpnuMxAHPrmvO
	 FbMkOzzPmvGqJPqU2dEcufxzI+BJWT+JXowY8LfIpHapKoS90QfGTydVbKz8EWPRdw
	 QCH96qS36v1rww5iHYZuHCW3BchhyMwhQnY9GNZlpQlvBUKfem5BkRGkyMy6f/33p+
	 X9l85E+fs0t+H+M1hQs+mP5Iry7kO/xVov6jGkOA+gF78KnosX7xJkEzLt8YMgQoJT
	 UaEFMheewbpzQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Tue, 21 Jul 2026 00:49:27 -0700
Subject: [PATCH v2] pwm: th1520: use vertical import style
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-pwm-rust-vert-imp-v2-1-9f91547f5e07@gurudas.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZgWAqgr72FY0HaAmgBNp60aw
 t0F3Lt8yfvvL8DkLTHcsgU8Jct2njbITxnooZ16Qms2hlzklahFie41oo8cMJEPaEeH5bUtjLw
 oI3QH28556uz7aD6aH3NUT9JhD+3GYDnM/nOcJrl7//pJosS6LIxSna5EJe999NG0fDaUoFnX9
 Qu559A7xgAAAA==
X-Change-ID: 20260705-pwm-rust-vert-imp-59a3d18bd0cf
To: Michal Wilczynski <m.wilczynski@samsung.com>, 
 Link Mauve <linkmauve@linkmauve.fr>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 llvm@lists.linux.dev, Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
vertical import style") and found a few more locations that could
benefit from this cleanup. No functional changes.

Separating out patches per-subsystem as per the review feedback in [0].

Tested via:

    $ make LLVM=1 rustfmtcheck || echo "fail"
    $

[0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
---
Changes in v2:
- Link Mauve: Removed empty terminal comment from middle of imports
- Link to v1: https://patch.msgid.link/20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev

To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Drew Fustini <fustini@kernel.org>
To: Guo Ren <guoren@kernel.org>
To: Fu Wei <wefu@redhat.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Tamir Duberstein <tamird@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
To: Onur Özkan <work@onurozkan.dev>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev
---
 drivers/pwm/pwm_th1520.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3e3fa51ccef9..543bd8dea846 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -23,15 +23,21 @@
 use core::ops::Deref;
 use kernel::{
     clk::Clk,
-    device::{Bound, Core, Device},
+    device::{
+        Bound,
+        Core,
+        Device, //
+    },
     devres,
     io::{
         mem::IoMem,
         Io, //
     },
-    of, platform,
+    of,
+    platform,
     prelude::*,
-    pwm, time,
+    pwm,
+    time, //
 };
 
 const TH1520_MAX_PWM_NUM: u32 = 6;

---
base-commit: 1a4920940ebfd8d907858abd8f8dd09b13752946
change-id: 20260705-pwm-rust-vert-imp-59a3d18bd0cf

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>


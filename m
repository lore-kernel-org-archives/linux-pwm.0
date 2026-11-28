Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795836033;
	b=B950r0qQH2AXGuZpIfU1dsnoSZYwLixX9G+kqS/8wCUVjGXqiZ840/Mhwx8HkESGjlLP
	 y7UCQ+WJJ8hql5M7h7tHqdecrozEIT1zIV64K5cAHo715GkYmwWoOmEN/LcqPXz3ZLWIn
	 LXp06OFXBaYWgCp1yNXrU45Xdilfj6VTKj5bqmTcYPbLdLtP0w3339+tqwJXEtdWQxjaW
	 07pU3MqgLGf40XWK25ttw025N+0paWzq20mLptXP4SroDJba1ZXo4yP3sdZEk5DdYlJpD
	 U6JLS9xTJwyc5+Ycs82aN4h2ggE9zAGOyXAyb+DkUuOormeYpvbpSXVmcx6Qw9hSHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795836033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YxeDnJT9qgAKa6RUhP0MRuNZNGp/0+2Z4aItwnCVnOg=;
	b=adcHv1FmMtVMWCT1qmDevfxz89PR4gjRVByPdfk4wq3NLaR+l3lDFhDQ2NgWxN1IjvU7
	 zrf4OhCqhVGSsYUlldMPl98plUa73OY39qwLB8hglrftCniFjAnVPnFZK7ti7CpnGTCw8
	 1Erhumc82sz2TlfvvAKuwekkisXg82wwXXnS2XFTf1lJUnQd5qZe5MBbcDVV8l3Um9vZE
	 92hUdFKeCsLkXs4QOKJuxB9EpKr4vi4xbpgf2DCN1ksmDafC6po4MbK+DSAIZMY2vChYg
	 ooMPUT27uwzmT3oOoVrTbhygcqUqXZ5CMGGYAS7zJdurkJyuBjXqRArAOTr/MJ8OKvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	dkim=pass header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b="RH/oXc7b";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F156606A31E
	for <linux-pwm@vger.kernel.org>; Sat, 28 Nov 2026 03:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F156606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=RH/oXc7b
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so7044229eec.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 19:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1795836031; x=1796440831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxeDnJT9qgAKa6RUhP0MRuNZNGp/0+2Z4aItwnCVnOg=;
        b=RH/oXc7bsfHNfPpx0xNG0WmvgH5uPT8JW5FiwtUwY6Jwih5Akc3K2HNCHpRrYTsUWP
         Ra7yol/hbrorRv4o/xRF42r/FkbujVMDGCnL4kMoDq8PSNYlwSpnQYBedOGfrIRhEab2
         +VhnaFgRtQ8M95EIF0DUNMh5SBrxRpa3ExCwaEToeKd+y//Cxe7nl6IUh4eYvC2FQnrW
         nYpi259ysszb2sipJDjD99NaYHOa/RUtLWCT0iHVncUbfOPqeeo7ELuwb2jCaRcYXZu/
         h3zaYposb8Oo0k6qh/OylqMrCfNny99Vse6KHWDzAv7ff9Q1i4jwfyerwctVyPRNixqB
         ivLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795836031; x=1796440831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YxeDnJT9qgAKa6RUhP0MRuNZNGp/0+2Z4aItwnCVnOg=;
        b=pDT56xFkm/7jQ8G3mc4gwaSDl8D2mUlJvT2TzmyPAnREWlWls0zuBRGFZix5DafrUC
         /7I4pJ1aT99HKqF8COn0vIwbybGo90nIXA8fgA/2xoJ2XWW5Zd7O5VmyDW4h6qWrZ0nf
         X3nJN9Shs70GLdAhyglOIyj7ZcSmrVWXAPwvBK0dOHSk7IxbXwPM0LqeH/v89gLJrMt5
         8DAcfifuRhEwGYOJITbMl9u0n6W75UfStn0RX8htndqYBaoKfGtyEjoVV1sd1wEmp2im
         V7eaqTH+Qf/NAjeWx2cTB4mAaDfQIf6WpoPEdFzsDDyKUnG1JBoc7060Qqq8CQ4jI1RQ
         FdnQ==
X-Forwarded-Encrypted: i=1; AL+hErGkgDl/gJrx+5anpRbxkYJFMAgJ1jZSMPf4yHmTUjTO/i5HxIiOOvS/0BWnIREFWg+MsAyuv/3ncqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ifY74oRcs7CwbO9zc2tgVUt2Uhi/OtWcOLnO9C5fNhXZpOUhA
	1TF0KO3+0Khl9TAc8RrwjI8Ufbn+3Dn0AmlCywAQnxnIVnQGC3epxq2Y3Dx86Vov5mM=
X-Gm-Gg: AZFdTZe4fAA2RoOjkbQ+VlgnXJCMFGzAUetCx6YzJhc4ImHdl3i0KPxXNk7yzyxOegz
	Z1tpfFq81o1GpOK9Cyvg9Kz0szwsyi3zjOjX1YdtlvTmwr70gQHgFdOA7+yJxRSQF5cJxPm2W4z
	6Ri2Kdflu+twMHUrMf5bOqJ7FhKvvbqg2h57VIpmnvmNRaAIkOSU5DnXS7QXHKzED1Oh9kHqKsk
	kRRJ2lqcc9+u6T4T3vNeD2gSVBj7LuwrSE6upcWtlskOKj5ptpshyq9gGIHkAsiSXcYFrocx4+d
	s3eKlgNiHE3LyfhwHXU14Tg9rhuLno/esnzooZ2SsnRtSDxnfuw9J672A0N+VA0ojMXf2Nw+XhF
	mpR3HQT2E+jfkl63GOIbpu4qEJp+/sIYWk3ylO9VQlRWfHrElTDrirg95+x4LNiQGRYmmiJ3yhm
	5Yqg1Pf92sZnpOjdn7TDE/bsmB/XR3EjrYLcqjQvD9nXzY120cYxZbxKwRAFIHCX/nvqgKR/U+o
	fcsp7HDYizcvp+JTF+t1QlU2kl04F5SegLooPYFM4w3uXortxtSNa7N8+cx9sRRjbSJKaqqoXbc
	Ez7v/MrjE4/hZgeGN7oS2nLX1NbYN2plx35L3vc2MAfMvFrmaESteuefnECDIAY3PLvt
X-Received: by 2002:a05:693c:6205:b0:386:a498:3ab1 with SMTP id 5a478bee46e88-386a4983cc5mr23758705eec.25.1795836031344;
        Fri, 27 Nov 2026 19:20:31 -0800 (PST)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm86275702eec.21.2026.11.27.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:20:30 -0800 (PST)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: m.wilczynski@samsung.com,
	ojeda@kernel.org,
	ukleinek@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	elle@weathered-steel.dev,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH v2] rust: pwm: reject over-aligned driver data in `Chip::new()`
Date: Sat, 28 Nov 2026 03:20:29 +0000
Message-Id: <20261128032029.9516-1-pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
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

`PwmOps` does not restrict the alignment of driver data type `T`. In
`Chip::new()`, the call to `pwmchip_alloc()` allocates memory for `T` and
aligns it to `PWMCHIP_ALIGN` only. A `T` requiring greater alignment
can receive a misaligned pointer.

This is a soundness issue and it is not triggered on any of the in-tree
users.

Fix this by rejecting over-aligned types in `Chip::new()` by asserting
that T's alignment does not exceed PWMCHIP_ALIGN.

Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
Reported-by: Dylan Zueck <dzueck@uci.edu>
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
This issue was detected by FerroLens, an LLM-assisted analysis tool.

Changes since v1:
 - Moved the definition of PWMCHIP_ALIGN to include/linux/pwm.h and removed it from drivers/pwm/core.c.
 - Simplified commit message.

Link to v1: https://lore.kernel.org/all/caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu/

 drivers/pwm/core.c              | 2 --
 include/linux/pwm.h             | 5 ++++-
 rust/bindgen_parameters         | 1 +
 rust/bindings/bindings_helper.h | 3 +++
 rust/kernel/pwm.rs              | 5 +++++
 5 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4c6d716e5fde..520e5b788958 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1594,8 +1594,6 @@ static void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 	}
 }
 
-#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
-
 static void *pwmchip_priv(struct pwm_chip *chip)
 {
 	return (void *)chip + ALIGN(struct_size(chip, pwms, chip->npwm), PWMCHIP_ALIGN);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b11ae91723f8..efd14a777b44 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -490,8 +490,11 @@ void pwmchip_remove(struct pwm_chip *chip);
 
 /*
  * For FFI wrapper use only:
- * The Rust PWM abstraction needs this to properly free the pwm_chip.
+ * The Rust PWM abstraction uses PWMCHIP_ALIGN to check the alignment
+ * requirement of the pwm_chip's driver data.
+ * pwmchip_release is needed to properly free the pwm_chip.
  */
+#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
 void pwmchip_release(struct device *dev);
 
 int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5bab3cf06336..8e70ef2e34fb 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -50,6 +50,7 @@
 # recognized, block generation of the non-helper constants.
 --blocklist-item ARCH_SLAB_MINALIGN
 --blocklist-item ARCH_KMALLOC_MINALIGN
+--blocklist-item PWMCHIP_ALIGN
 --blocklist-item VM_MERGEABLE
 --blocklist-item VM_READ
 --blocklist-item VM_WRITE
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..2af0af4f6858 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -114,6 +114,9 @@
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
+#if IS_REACHABLE(CONFIG_PWM)
+const size_t RUST_CONST_HELPER_PWMCHIP_ALIGN = PWMCHIP_ALIGN;
+#endif
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 8aa47304bec3..7fd93cc644bb 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -587,6 +587,11 @@ pub fn new<'a>(
         data: impl pin_init::PinInit<T, Error>,
     ) -> Result<UnregisteredChip<'a, T>> {
         let sizeof_priv = core::mem::size_of::<T>();
+        const_assert!(
+            core::mem::align_of::<T>() <= bindings::PWMCHIP_ALIGN,
+            "PWM driver data is over-aligned"
+        );
+
         // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
         let c_chip_ptr_raw =
             unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv) };
-- 
2.34.1


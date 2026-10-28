Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226527;
	b=IDxZ3FFKxg15sDLxwsfI/cVeKYPz2CAWvcaEFmxaz7djgKegKu/o42pe9GF+XHZ8PLR8
	 RTmZ4OvgEnyzZtH0oCRmfxrdE7oct3t2fipOIhQ4eCinB8jYnmFCZHRc/5AHuu3q6UKMw
	 AhZkbFB2Jb7ClD3A40iwj76sykvNFef9zMiS7o9QYJGEvHP9rqJaV+ZAUFMWbqCxa3zmr
	 CJ5RqEIjnlGLylOb9anl2VkdEZZB1q2aDDT9qXdiedmvRKkPWgDqTMcO1eSb9RA5ATBFQ
	 lg+uZjkX11hjALMvin6pZcSn/bZlqpT73acgdh3vzqM8w9S76QNXd4cqdeEAsXOUkuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YEhgac1kjYxn03aKruXlSpkZnrbKOWoEKZtLlFnXf7Q=;
	b=oZD42CICTcbULsfCpjDuHOshUXEQCOc1znv1isJxppYAMiyuFrvgpNPdgEAWtBEh097J
	 12uHtGVE7Vv0ptZoJ7NnkjAjwcaJIWyCA0IhPmth8thunIGkmdXhh26YW4z3wEbRle2KZ
	 KYEaimwAqGK8J5HcHyIt5bKuhZxGcx7phI9xYh1kxvFQMz2C28akGogmXGGS8cQ8ZtnSE
	 LlOuL3enC/9+uljEEHbb2+6wE4TRLAs2MByTjHDL01m13hUw6UXmZ675t4h/jz030Whza
	 NtqlYfvc8dbo25k24QNjPlBz0CjnK2y83Tk0Di/+UIho+DRJp50PMAWSK+xKE8pGNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	dkim=pass header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=E0YblXM9;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69618606A31F
	for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 22:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69618606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=E0YblXM9
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso2396793eec.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1793226526; x=1793831326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEhgac1kjYxn03aKruXlSpkZnrbKOWoEKZtLlFnXf7Q=;
        b=E0YblXM9f9mV5jpfmkxxC7RjWPxa6FawetgZmb3NqYlUmf0tzMP5dq/MLJL5bpuf0H
         qEn4s51z0dBEorE0dpigOysm84cvOkFnF3OQCbePDRO6yp294sOCsugkhKNnqVkGNoVo
         oZgGCQvb95Ti8cA3Z0fGSGOtJH6Ib3ZY+ZGU7fttLIJ7t1gbJKswZpsFvxAXY6JPqzhj
         0dP21c95E4wGN3C708D+7ctZ2p/CnDooHriLorVByIV244M4dli/F7MT7+LQvJwkvFTf
         fMK2IrWhtNehhe59bjtMmEOw7zWvJAuKjnNNv68XRcAZEYLiCRDvgQFvLUJ4gU9AT8d1
         7mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226526; x=1793831326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEhgac1kjYxn03aKruXlSpkZnrbKOWoEKZtLlFnXf7Q=;
        b=RP52osq5jWgHJXCxDMPbI5nohRGx8n/kLOqxdcowXGsZ9ZbCyrOo7U8F/PX9uDfygs
         ks4WdVYPJEfBccxvnucd8eYdh5Zi+Bv9+ehsqB/3MwSUaOb0xoqjQblpgfshm2I0QCaV
         VNGSjLIvjyToDjluLdx6cUuFcpz76O2w4rdnuZmM/FI2SQpo9bV6r8gM85GRdP6J/Tzu
         fX5KrTXJQd2AF7ZP2XkNuhZ3AxMlSkcX5p/ATCvucO9QrpCeH+17Hw+wf7Ocep87WJJS
         pvO/eWvah05b3msldt5h+hmjF6qIVDTdokYSoZ1VDF4zUgF50cfa08Eoa4pYx5KVla+6
         Fqwg==
X-Forwarded-Encrypted: i=1; AKwUvBxAqTYqGFfMgsRVF6nLzW3glnX1JOApwx+zwVZ2adRoyOUffQ6+aBf2031ngayDee+u9O9XsDmETQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx6povwYmwaQxBhs/66AyWSpo/nfLh6ooGdhNWfmX3GzXoDKmd
	Ki84o/XMN+KCkm1vsfmUCunSjSqw9HWzyGFusdH/eHBsS43igO6pKrj9ByM3oT9SHqA=
X-Gm-Gg: AYBFou1cnok4z4sfSYnNZ7QsL3+H4SsxscCwohrgx23bCtLkSiQMUlONxfRSHud69PN
	0A1irtO6bS8M1OQykicOrhGwddSxBSTscITPR/jXYZlJJ1jg7vKUBS1xWc8NauS51hUm/f2K92o
	J53amu1VKXg8jjIcx2ubyn1D0IywXezi1Abnk/sGOcZ5AYuahULno2j9gX8pChTHutCn8djky55
	Jdifny2cmvQXfoW+WAhgdPjy+y2TT7IVQuuLcOy1fNd8WsKk6OCLKNd7/qRPtNs3ouE4uxMSQAy
	GkqzeDQn5moB12sGfCKzSe4RTMeVloFX9i+/j6R78UNKhnpkPC8wnIUx9dT14+pp2PMpyP70dxT
	o7xEBcdRTP+QPmstW/nZxEKCV1Fps0AXuEQvuyrrMLRUHEOSKdk/QJSIFD31fFiMstcKtPl+XUf
	9j9/RKsvIqANG5sZ4R3kMtbwECzWlHS7HAlWznMpr2u02cEwfwbxJFYS+bC7TFBPvyOnkB7Enyo
	v3qeBsBm1lr5wFDKBKMv3YkUhttnV0kaP8E2LZZBGe6Ii4NkncWpYOL5P7DBumacVtdNcSDIhsU
	Mo3Mmi4JZdJx2unaThjMhTXMW7Pmb7S8W7PQhmSwWUllMQDcTiAnW/8LeqkXk9or/g==
X-Received: by 2002:a05:693c:83da:10b0:36a:1f:9b74 with SMTP id 5a478bee46e88-36a203bce76mr5398946eec.27.1793226525305;
        Wed, 28 Oct 2026 15:28:45 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a2390929asm12301773eec.12.2026.10.28.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:28:44 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: m.wilczynski@samsung.com,
	fustini@kernel.org,
	guoren@kernel.org,
	wefu@redhat.com,
	ukleinek@kernel.org
Cc: ojeda@kernel.org,
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
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 1/1] rust: pwm: track the owner module when registering `Chip`
Date: Wed, 28 Oct 2026 22:28:40 +0000
Message-Id: <f9cf8f0d897f22888134b2b17f1b0f86bcda311a.1793150685.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793150685.git.pgovind2@uci.edu>
References: <cover.1793150685.git.pgovind2@uci.edu>
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

`UnregisteredChip::register` calls the C function `__pwmchip_add`
to register a PWM chip with the PWM core.
`__pwmchip_add` documents that its `owner` argument is supposed to
be `THIS_MODULE`, but `UnregisteredChip::register` passes
`core::ptr::null_mut()`. This is acceptable for built-in drivers.

However, for loadable drivers, registering the chip with a null owner
prevents the PWM core from taking a reference to the owner module when
a PWM is requested or its character device is opened.
This means that the owner module can be unloaded while references to the
chip remain. This can lead to use-after-free and
kernel panic.

Fix this by marking PwmOps as a `#[vtable]` trait so each implementation
exposes its actual OwnerModule, then pass that to `__pwmchip_add()`.

Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
Reported-by: Dylan Zueck <dzueck@uci.edu>
Assisted-by: LLM
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 drivers/pwm/pwm_th1520.rs |  1 +
 rust/kernel/pwm.rs        | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 728993998446..6a1f4219d6fa 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -94,6 +94,7 @@ struct Th1520PwmDriverData {
     clk: Clk,
 }
 
+#[vtable]
 impl pwm::PwmOps for Th1520PwmDriverData {
     type WfHw = Th1520WfHw;
 
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 8aa47304bec3..ae7b449d67e4 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -12,6 +12,7 @@
     device::{self, Bound},
     devres,
     error::{self, to_result},
+    module::this_module,
     prelude::*,
     sync::aref::{ARef, AlwaysRefCounted},
     types::Opaque, //
@@ -175,6 +176,7 @@ pub struct RoundedWaveform<WfHw> {
 }
 
 /// Trait defining the operations for a PWM driver.
+#[vtable]
 pub trait PwmOps: 'static + Send + Sync + Sized {
     /// The driver-specific hardware representation of a waveform.
     ///
@@ -673,9 +675,14 @@ impl<T: PwmOps> UnregisteredChip<'_, T> {
     pub fn register(self) -> Result<ARef<Chip<T>>> {
         let c_chip_ptr = self.chip.as_raw();
 
-        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
+        let owner = this_module::<T::OwnerModule>().as_ptr();
+
+        // SAFETY:
+        // - `c_chip_ptr` points to a valid chip with its ops initialized.
+        // - `owner` is the module implementing `PwmOps`. It is null for a built-in
+        //   implementation or a valid module pointer for a loadable implementation.
         // `__pwmchip_add` is the C function to register the chip with the PWM core.
-        to_result(unsafe { bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()) })?;
+        to_result(unsafe { bindings::__pwmchip_add(c_chip_ptr, owner) })?;
 
         let registration = Registration {
             chip: ARef::clone(&self.chip),
-- 
2.34.1


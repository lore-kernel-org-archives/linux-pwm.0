Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601539;
	b=pM7t01lhmcwU75MniIygoZ9lWYUGIg3/vraG79DuLnyagFZqbDPCWdPm16a9R7wn72jg
	 1Me616z85qZxzOstrHyUAThrm1gPE3v44zU7pgN/nRj/wXJZFnMDhLGET1H5EnM/oPlKU
	 NhDUYldg7Pe4Vfz5xRoPWqKyg0FVJdUoDr45Okpo+R82a1WFZkNG6O9PSe2jtS1X+D277
	 1l0Bw++azJyPMFL4Tq/1zyKKFoXlNrUznDDiTtS8sAEw5Kx1WZJEQQ4+9SN/bD2ZFYIuB
	 gpQ3KyEIqoYZRELluh+ycFwtaa7smBceA3hUvibS23zxcXDxBpv1wbopNqm8E+zGKNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vm1IGuKTaqbaumPmtsc+rwOgJW2SVoe9zBDKiHFpTCo=;
	b=2xeORKhL1hTIUUlO/TUtHxq64h4N4M4m6hV2BQWGgZlfOcaSAdvzGz7TuePnC49Ao4bl
	 fB9N6Bsi3+HhHni3EV8/dmhfdTaizqHatw5rRtmaAnrYL29hiKAGKCICjUN6O/9oB/3oT
	 kQJ+raDOTYam5CzpH5rDSv7F4eyR4lgcHGv20jfZOl80RA8KV3HbpYiuYDYfm2RfwJjZ4
	 qYsuwpMTcS8Lm85L4/JOgQJYnxwWMyOdPbwSVtobMBGgYgSGWg5nndkENEZGxT+2ezZJu
	 k7vDBHJFtIey+kbL6uHkYdNothdaH2xWi6zn33w0BgXtW4CYoVVHAoJFNCnyfPtMrxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	dkim=pass header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=OPvtwYSH;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE3606A323
	for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 20:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ACE3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=OPvtwYSH
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1780339eec.0
        for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1794601538; x=1795206338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vm1IGuKTaqbaumPmtsc+rwOgJW2SVoe9zBDKiHFpTCo=;
        b=OPvtwYSHaSQxsfyMQrbBFYQdkcJBWZSKX2S13grdyzcxQgX5GformHiRgI86lYCCpv
         Jg6jHuYfTe/mgnDGn2b5USX+FmKyXx85WnMdlPYspJks9IJbX+MNeVPqXgiliV1ApQXM
         cFE2mk6sGp5YR4WX3JBa2mMHHaXN1AwvLO+YgN1wc/JEGiS587MHwp+lYF34YgpPhVgK
         QKouQ7KkKQoANxjauV9ktKfKx9XCC6ViibiAxo3Rk6sLiyJBoVG4qQLvJPKtwFB2K/dQ
         bff33pupwTNOaXKqdTWOF6xHaYlT209ehYBdsW6EMu5PG8gPtWFTbIDLFNi1XnUp1QfP
         yuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601538; x=1795206338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vm1IGuKTaqbaumPmtsc+rwOgJW2SVoe9zBDKiHFpTCo=;
        b=TCuc8FNy8GJUJTmm/yX5Fr3lY9J7NSMYP0lo/l7M9kTPCSpAgxXPdP6mPRJbE4FdZs
         H0UkXv58w88LVayPR9/iX5iYDD1bfGN2KlWI7cFuWC+FJUG/dSHcPmHj+uQPP7+Z9J4R
         1kpGiDWYB/EwqWtYoITQDcaRer2vgSGbeIbunnY9YYa8X+gGq7QVAlfbs7a1XmN1JhIq
         nmHeGqIOUQK+p0/+m9QXtOKK2syJhKW7YZYVkA2Qdij6cwZwHtUu4hihymgORgzEieby
         zdjFYKLDlTad90pAIc3AHKtOvm9/do1Qn5qzuP6HRoFTJyqkia7svtBmbGg3rug1Lyc+
         BrUw==
X-Forwarded-Encrypted: i=1; AL+hErFGZMvfgU03hFiEBCP/v8H77wII3NZQHv6ml36maSm54leVGdHKDocIpgo3gMmTCx/Ph/w+MhIkpIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wjkm2ucVt398bhdzImUaV0zdEMkdOMm4TZsXsJa7d913o5LqB
	40fPsHfGu1r9gC6SKEduZuD+hrIXg30LIwjYai4n4eI6YmDZr1uv6SfIb1X/WpzCApI=
X-Gm-Gg: AYBFou0KNMliMMDdw+0721E/FvkuD6wSrgCERXVHCJ+JmF2ZZZHEWReanNH/fjWhPvB
	mQfrY8l3Lo/vL4Is6uI0dRothQfMRtxGQi9cg0hAni/8uHyRotnJDkmjUqx1aPk9CgifXjYvxWc
	OdTkJd/hC5K1JHNyhDfKpIbSF/bZM/2xjafaosQ+EilVuZIEn4aHIugz6f8+JYF54tWQ+GfLZOs
	zNAWmtfGigAk0tNrnQR7FAzbUPO5Cb2n0RWmIXYy03u2uMi7+gYLsISGlyjrJjgIB4LLZug29pI
	g6AuDYe7iv2ubgH8cHouTh7pYXrm8/CJrOFvV8fCuqXuiDGHfZpBOHnwb16FTCzrdJi6jkuKhe9
	1rIE4IxdEbr+VvSsjol8HXbhsteCDPB9Le26bf6MC/W4bHji8A+szahXMLLqtJFjCiahLbAEzdb
	7WFNcAJuvdHQgoH/VFpujTeRdD73/U3tdnwQJnkNQpgEWEQd6l0O21GXOCIVL+VL6+AStKrGZa1
	Z+WXoWZNS0ZmVN+Pe8AhclfHQc/kN6FyOtfHxOTWUgRr/XJDsAwYeIYzj/a4LQUZ3S9sb8Q6bfJ
	b6Tlp2wrt8CBaspYlZHtAUAWeJjmhoVCk/IWJ+1x1+mOzj27/CjFcqpbDj7RkQWBuCzK
X-Received: by 2002:a05:7300:e9c5:20b0:361:167c:2364 with SMTP id 5a478bee46e88-37966e3ab7cmr3493290eec.8.1794601537810;
        Fri, 13 Nov 2026 12:25:37 -0800 (PST)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-37956bad134sm11725372eec.27.2026.11.13.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:25:37 -0800 (PST)
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
Subject: [PATCH 1/1] rust: pwm: reject over-aligned driver data in `Chip::new()`
Date: Fri, 13 Nov 2026 20:25:34 +0000
Message-Id: <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794600927.git.pgovind2@uci.edu>
References: <cover.1794600927.git.pgovind2@uci.edu>
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

`Chip::new()` does not check the alignment of the driver data type `T`.
This allows a Rust kernel module to choose an arbitrary alignment for `T`.

`pwmchip_alloc()` reserves `size_of::<T>()` bytes for the driver's
private data. `pwmchip_priv()` aligns this storage to `PWMCHIP_ALIGN`,
which is defined as `ARCH_DMA_MINALIGN`. But, `PwmOps` does not restrict
the alignment of `T`, so a caller may provide a `T` whose required
alignment is greater than `ARCH_DMA_MINALIGN`.

This can result in `drvdata_ptr` pointing to misaligned storage for `T`
in the underlying C allocation.
If `drvdata_ptr` is misaligned for `T`, that breaks the safety
requirements of `pin_init::raw_try_init()` which requires a valid,
aligned pointer as an argument. This is undefined behavior.

Additionally, `Chip::drvdata()` can be called using the `Chip` produced by
`Chip::new()`. It creates a reference to `T` from the misaligned storage
which is also undefined behavior.

Reject over-aligned types at compile time by asserting that T's alignment
does not exceed ARCH_DMA_MINALIGN.

This issue was detected by FerroLens, an LLM-assisted analysis tool, and
was then manually analyzed and reproduced.

Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
Reported-by: Dylan Zueck <dzueck@uci.edu>
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 rust/bindgen_parameters         | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/pwm.rs              | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5bab3cf06336..59d0a6518032 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -49,6 +49,7 @@
 # We use const helpers to aid bindgen, to avoid conflicts when constants are
 # recognized, block generation of the non-helper constants.
 --blocklist-item ARCH_SLAB_MINALIGN
+--blocklist-item ARCH_DMA_MINALIGN
 --blocklist-item ARCH_KMALLOC_MINALIGN
 --blocklist-item VM_MERGEABLE
 --blocklist-item VM_READ
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..4ffd714f9229 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -113,6 +113,7 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_ARCH_DMA_MINALIGN = ARCH_DMA_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 8aa47304bec3..7823bb56d17a 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -587,6 +587,11 @@ pub fn new<'a>(
         data: impl pin_init::PinInit<T, Error>,
     ) -> Result<UnregisteredChip<'a, T>> {
         let sizeof_priv = core::mem::size_of::<T>();
+        const_assert!(
+            core::mem::align_of::<T>() <= bindings::ARCH_DMA_MINALIGN,
+            "PWM driver data is over-aligned"
+        );
+
         // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
         let c_chip_ptr_raw =
             unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv) };
-- 
2.34.1


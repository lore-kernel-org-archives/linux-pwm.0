Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD8233927;
	Sat, 11 Jul 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765022; cv=none; b=pB7KG0ribP9K1QZ1syyPaEV4NzhNBJQ4cI2oNBD8dCbfYkAVLSErmGqNxOWUhn1TyReyOJgxfIVInovNMI2stfOxzxILGEn/sw7QWpN4VHtdY9dseqf4W0rjSsQgXMr0/3GEjRxeeJ6xTqadrhFdViuMWR0UzAc5jagObCuvbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765022; c=relaxed/simple;
	bh=+Q01IOSPpbl6YaJ1sx2U1xpDg/zo1GCHE9ISpCMdGX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HTyxsuZ3PPvXCexdGDf3E9ZSNpUanEWpIvdYKNKeYARbb547Cw+Tne91IGDa1Yjy30reX6+2dSnAF5ArFC7FOULU4xYMhczYu2w5Bh0ht+Gv8ISEFQN6gO9Iff5eu+NB9YApl3OmRGzfoawdGaijnUxMKLSBGLDHSHlgc1G7HEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=M/h8gBoO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=p8w14CPZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M/h8gBoO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p8w14CPZ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gy4PP0dlZzKvv9;
	Sat, 11 Jul 2026 12:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3ImstQrsA9UW+38lhQ1sNds7gu/oGbkbhambfG/NR0=;
	b=M/h8gBoOZzGcKOjKkhO2U3RWnN/IbG1O1jBcYDl9RQ4AA5snm9OVJEtarFLd9J3rDReFj6
	cNpOq7imAUFtt6EZ8L/lnnrdHaG+lLjh/ygkcd2tV06KZPvPWWJKqTNn2AItsvYuXUB3Qj
	iutPsL6iGbqfXhp6eFBgCIjMRq1ZpedOUVrV22S9WqnVI5V4bQpL41lYMBsFU4uc07gPzh
	+21VEAw93+HcFc9lffr2jdn4pjKKLg6hpVtlv7+7M0dWCcObsRjYFe7i8elsi0z9jB/T7U
	qGi/mlOMjMCU3zWv8qR3f+MamcxyaSqqFh9Ggfh0srW7njLA+ZfE71s8pqrc+Q==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3ImstQrsA9UW+38lhQ1sNds7gu/oGbkbhambfG/NR0=;
	b=p8w14CPZ0kWEU7bX10C1ghN0UHreb54mtp4opQHTe3FNRthqsgGq7vqIfcp7mTgjL7iyBq
	asnDirQLwQNdcRS9mp5FYmRd7q/e6/mY1/lZZA6ZhUE4vayuQXfwjpLnc4EdrPyfF22o0Y
	8Oo8fFnYiwoNeRIB954FI0S0S3XEnmETjWFaaS4+7O7U5YK2y/nRUrIlLcRoMZHHeyN4LZ
	QG+4EeZFnI3eJ+YZ+OUv3oApZHbkyxJ7rPX3ZnpxbrVP80sOkGemDtSRB6SWmhVkY4KLpe
	DWvoxZOHglK7I3Mq+AvdP1sHQshrQl3Q6nSCWDKgmDXKbpll++Y3b4Unh722zQ==
Subject: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Date: Sat, 11 Jul 2026 12:16:28 +0200
Message-Id: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTW7DIBAF4KtYrEsFw4+NV71H1QWGwUZN4hSI5
 SjK3YuTRVpVirqckeZ7o3chGVPETPrmQhIuMcf5UAf50hA32cOINPo6E2CgmQJNky1IcXW7U44
 L0hELLRNXwGirpTXSeOQdknp/TBjierPfP+o8xVzmdL5FLXzb/kddOGVUSBeYkMhrxtvext0wr
 69zGsnmLvCwqvbMgmppo7RkQ2hBmr+W+GFB98wS1XKtswIHFzQLv63rvYCEX6faabm38Ki0b2q
 EYoYZ6naftJyPSHPZwhzj1rbeK8V9v6ityMHmup/3+1j6xgDjDMA4OYiuM23gghtf3+UaPASjD
 Sj0vK0vXL8BKCEg+94BAAA=
X-Change-ID: 20260526-rate-exclusive-get-th1520-764a949de18e
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783765003; l=2054;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=+Q01IOSPpbl6YaJ1sx2U1xpDg/zo1GCHE9ISpCMdGX4=;
 b=wrIw8EiPXBMgXwOPtE10nUhaLnGuBvvXnluKQnp020xOGAt974/hFA4jcJSIM/LAIYqar4qEW
 TwOwcYvbqCsAW9XZmIYQ5zix6qVPq2cHcCTaxtX3rG7/0g/ox4qJTaR
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: p68pwkc35abrj1qzbhy65xyydo66i3rj
X-MBO-RS-ID: 17a3b90175c5235e027

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v4:
- Rebased on v5 of https://lore.kernel.org/rust-for-linux/20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com/
- Link to v3: https://lore.kernel.org/r/20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org

Changes in v3:
- Add #[inline] to Clk::rate_exclusive_get() (Onur Özkan)
- Drop intra-doc links from the regular SAFETY comments (Onur Özkan)
- Rebase on Daniel Almeida's Clk type-state pattern
  https://lore.kernel.org/rust-for-linux/20260618-clk-type-state-v4-0-8be082786080@collabora.com/
- Use vertical imports in pwm_th1520.rs
- Link to v2: https://lore.kernel.org/r/20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org

Changes in v2:
- Rebase on pwm/for-next
- Remove newline after [`clk_rate_exclusive_get`] comment
- Remove unused [`struct clk`] link
- Put semicolon outside of unsafe block
- Link to v1: https://lore.kernel.org/r/20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org

---
Maurice Hieronymus (2):
      rust: clk: Add `ExclusiveClk` wrapper for `clk_rate_exclusive_get`
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/pwm/pwm_th1520.rs | 18 ++++++++-----
 rust/kernel/clk.rs        | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 6 deletions(-)
---
base-commit: 92010229c4b38897f1319d260162d2f96925ed17
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
prerequisite-change-id: 20250909-clk-type-state-c01aa7dd551d:v5
prerequisite-patch-id: 2d3dc45c241d9062a0d2546ec649eec7970fa50a
prerequisite-patch-id: 67ad535fe110207ebc79045ba022ebb7137b0309
prerequisite-patch-id: 3d1d8ee5c2a4957edd0807b7a5cb65dabab345b5
prerequisite-patch-id: e2659037b8aaf51831da099cc568ad5b3c24a4dd

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


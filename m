Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042287;
	b=4B34ftUjjghk0WsgKksbqqTNEtHmvUfry6etPpxxwmSOU7c6vDva0BTlE7MqOv83RNcV
	 plxUjhWR5BbhZaPrzaRRUyLzxSwyh6waQHLnWWpXp8hGHYnEpgRAprH5h9jr0n2ZSJDu9
	 csoLJuocsW/T1ZWPgDYxfe+lO4+KVm2V5ZDRYEeTr4RseOVZ2gh5kdd1mvlHZ3t3PmTAz
	 dXvndoZSbvX+mGFaUCSw6tKS5Rg+CobzDHMAvSW19nzNtkAZ5TiKBuArf9+TjwgWKMNSY
	 JOEN+Ix+h5mDNlqH8I0RbnvSa/f/E7rpAqf/mnjPIuSXWC8kCQfsHO5t8ijeYaFdd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042287;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=yocfxdmltBMVaJIKGLzVjwYKlh96aJRfUwiGTmIerSk=;
	b=o2san6/6kcVHMsiv/xFg+Stra0y5Tlqw7+hS40i+B6IF4Zu4UVXTK6QVPR1MbXX1lz8x
	 6h0pN0ljqoyvi7DPmsLyk5XDFvXLfa742SnYBhljh2VKsZe1i7xciO7s9/s8Ha+ehmlA3
	 EFg5ru7+PB5q5vQ32DBjhkQgYxKn4Pdod/xq5+VQlUdeRKfGZFaa0QrY4nCF5eiwpDEEE
	 rB0h9kdk8n+Sc5YKMJK4ARq9IhrYBPfLgE7q9HfPH8p6jlyfPUUZDxcPwOzjLSr438bNA
	 6BshEvV3K1u/VpALBVsrNV8QUl6hYXwagfU5LrSRoKcNdb6YvdQE9rGVPYprM3jHJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=McuQ4u6N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2kc2Bnfj;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF55606A32C
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 22:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF55606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=McuQ4u6N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2kc2Bnfj
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 111F91D00232
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 17:51:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 17:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1795042282; x=1795128682; bh=yo
	cfxdmltBMVaJIKGLzVjwYKlh96aJRfUwiGTmIerSk=; b=McuQ4u6NuNFb3OJFnx
	fBqlU2IdFdBtbBmmGgt+lDKjdRpktW+wRLQT0Rw/BgstwXn7wkqoaLuJhIddycYg
	/ZBzTo3rlh1rUlPkpqnBXJLXTgUA1sd5tiwptYmqsy8V87Ez8FViB6sf+ZXTz+zO
	ggziXSCJIouc2FiCfTf8LwaxQNix8bUILGRiZRn8+p58ShQSiFp8iQEw2sstNiT1
	i2TJDNLqYqO6KFzu2osDTYgQTPkkG+fKgEmU+Lke3cDdLlPeF+bGk7/dTXUwerPb
	nrZQ+3cP/RyYv4MhNMNbDT13B/gTuYCS8P9Hue7G6F8f1sa4DFMBI9gqzRQ3P/td
	D15g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795042282; x=1795128682; bh=yocfxdmltBMVaJIKGLzVjwYKlh96
	aJRfUwiGTmIerSk=; b=2kc2BnfjD/ameYcqY+Z0uRs/LgKesGIhVFfWiyxfRYx5
	wIilZVNwCG3iT+Gjile4FrwqVA79smqKiMcNCH1T0YjIQySZ7API8823I+rwOH/Z
	43cK+XtKGc2JDwgoho4Y3hst/hetPjoR6mVtmX5tfyr7dHZ9mKcSqIIOrpAna2CB
	zr0BZrBnvMdIPFrDq7T36r6z6xjhYe8s2ExAxFgbrXqmlul09Zb+CY1Mb+b2C61D
	AUntbBIwfzfkP7KXlvUhA2Nk8c9g4YVI4EU/zQx8H16An+qYVGpB4dTsYeQCaKDL
	7UfE8IE8E40x2Ej4B3N07yxQd+vZ4AknBMwyOzmlLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795042282; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X0RmtrpndnZtIu7jmeGdiCzIc4IDsBy0JQ7+p3M0p03W5pV
	2iLIdmfRhn5oVK1Htc2Hj5odbzUBqJiO9k6pJCcVk9KV8ksY3mPIaAr4Nd/GtTk/
	YtJUyAMU8wG0DrDLqbkj1pyDYNyg/ut4Z3vvuIApbY8hmrMDvp95s8RKiR1/aQ0q
	t4qEAB/jA05uC0wXNuuwQy/0SBwWVZWzsyCLyNUT2wPvqI1n5T4GH9hTyvop216/
	l9MuRxHv9thxQA8dK/+4MjaznQMSQl2Hjlrcp6Vgm9TrK+GtfgpgDrsufc422Pjz
	B/7sGzdR2m1NHYfl++lj4aZvqModjbB948LkeTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:siRbW8xq4eTq01S9K7rwAmPitEZfp3du6esi6LFqbVQ=:DbMVJhyW4CFkskQAHCLc82yLpYiiKZ4nq2JsMR6q5mA=;
X-ME-Sender: <xms:6Sv-avFKRdsY56bCHNU_eb6fhdDP1zjkFqhqTJ24LntvTEOT88CWog>
    <xme:6Sv-at91yse0k_GD8b7QA93WYrt17gogpvSZs1tyZVMPUBi9lvSR9d_fXHjbwvCcJ
    MIKPgYgwGYhFdy5sOjCSrvLn-hzXl65Q7L-6QRcPcdsU1ATKjKfPDNo>
X-ME-Received: <xmr:6Sv-alNvcGkHbEqCT43v0nNvU8aA30iNjUxVhhUbxCK1cgQozIl0HFUzEdn8l07Yf0NaKuYEbyRZ84duME4>
X-ME-Proxy-Cause: dmFkZTGXPcSrtoExca7hP5m3Br2SmAjrZtg3cVX9gsgDlDTf+5zq8a5PkeehtQf9jkcGo7
    1nqIg1AOU5nNW9XiNtze1UEcprRAvVCi/WjDG/2gIYyDrAOCG2L9coyoD8IT1na0EISod6
    k4c2pTwpo2yKryLJlGWhRMvFgBbHrHhx36sPyJuXPXKKPAg1R/clsE3uh5qtf0urVdZ7gX
    E2QCCS9l8+Id1PFIaPpLwHkhiJjy+xTHNbewsncJagJhIXyCiRo0tQhjyR6M4ZntlzJhwm
    jrpqvdPVvKbBi6vCeWkwMvFnWAjyOR0mgTqijLwmvsrsvdvKHPfHechWkK/koONbeTVSdc
    iZ1E9O5sWynTg3G9gScGlz94rYNCUC1C9Q83jsxUBRk7Qh2LxEbwpxhoPZGKa3GsddHdHc
    AlwQEIkWPgNA+t8cAnxEU2E5cSlPKL6VhpantHI+BTzvIwymqgobB2ooL2sf0E2zPXCgNE
    rqBeLWEwAxzIBLSgDeni4IdVLFRuAMAWQkH5SwfDMv8E/nCqcyQ7KZ2/gYFvqPGGrx5cGN
    MW8guu+Ai58XsxI2iRNn6LyJmX1h43E/Y5Xwh07Lgf/3jhc/qgASzInTdWliJDiELdPMKd
    H7aWIe+5dl5TKJs6cm11g6R/Qcw1T8FtA81xKqHp7TwmGmWjAmyN6N+UyJRw
X-ME-Proxy: <xmx:6Sv-ajifeUmoS1SntL5JWQG0cJX0DPUxzY6vr838q2COJlnHsSVw1Q>
    <xmx:6Sv-akS3b7PEXX3Pro20QqH-oao6tGbJ955IUgYjYjeagTzyx5GxEg>
    <xmx:6Sv-amoTObKf2EG0XoQSPjwzRfvPF9RAXBvMR3iXC04dbf6hVTjTfA>
    <xmx:6Sv-avaQolN70kDSjfN4otMu0kXpxnKilpOWluOPEGWXSWeWriNjHA>
    <xmx:6iv-aiAxX3Jhqpxd4zaIC8rtYlMZfmhyJLap6kJnOeE3BBuDHgLNxdEH>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:51:16 -0500 (EST)
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
Subject: [PATCH v4 0/2] rust: add u64 division helpers and fix the pwm_th1520 32-bit build
Date: Thu, 19 Nov 2026 07:48:24 +0900
Message-ID: <20261118224826.2491684-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

This series fixes the 32-bit build of the TH1520 PWM driver with
COMPILE_TEST.

Patch 1 adds a math module to the kernel crate with Rust versions of
div64_u64() and DIV64_U64_ROUND_UP(). Patch 2 uses them in the driver.

The driver only needs u64 by u64 division. It does not need a 128-bit
intermediate value like mul_u64_u64_div_u64().

Miguel, Uwe acked patch 2 and is fine with this series going through
the Rust tree.

chenhan's patch [1] also adds rust/kernel/math.rs, with signed
division helpers. Both use the same module header, so whichever
is applied later needs only a small rebase.

Tested with the doctests on x86_64 and 32-bit ARM QEMU.

[1] https://lore.kernel.org/rust-for-linux/20261031103206.24051-4-chenhan0017.work@gmail.com/

v4:
- Add #[track_caller] to both helpers (Alice)
- Check for a zero divisor only on 32-bit, and use the panic of `/` on
  64-bit (Alice)
- Add Uwe's Acked-by to patch 2
- Rebase on v7.4-rc3
v3: https://lore.kernel.org/rust-for-linux/20261030020209.3833766-1-tomo@flapping.org/
- Use div helpers instead of limiting COMPILE_TEST to 64BIT (Uwe)
- Add a math module with div64_u64() and div64_u64_round_up()
- Drop Cc: stable and the Reviewed-by tags, since the change is different
v2: https://lore.kernel.org/rust-for-linux/20260930101257.1649945-1-tomo@flapping.org/
- Fix a typo in the commit message
- Add Cc: stable, Reported-by and Closes tags
- Add Reviewed-by tags from Andreas and Gary
- Rebase on v7.3-rc5
v1: https://lore.kernel.org/all/20260929095612.1072417-1-tomo@flapping.org/

FUJITA Tomonori (2):
  rust: math: add div64_u64() and div64_u64_round_up()
  pwm: th1520: Fix 32-bit build with COMPILE_TEST

 drivers/pwm/pwm_th1520.rs |  8 +++--
 rust/kernel/lib.rs        |  1 +
 rust/kernel/math.rs       | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/math.rs


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.43.0


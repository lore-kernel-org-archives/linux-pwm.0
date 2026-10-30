Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325776;
	b=ir6MAcii4b6tenIcRr7qLWTqbQumQXAjo2CMm8k+v1Jz34XGV3OTrJVVHLqmMyLLBG7R
	 BOA+obziKK0OlXcA4duqRAktuNc1zaYWLMFO11GO5q1XMT/jhLAQLhTPD52F/DwdfT+TD
	 N73eIwq+C9oJl8otQG4AvWnhzqyhmE+ly1DtlQOP2t5VUQDw+NV5qxAJ3uK6xMidAJ6Wy
	 WRo6qB10ua/Pl4hvSu/yvg7AkV8Tv/uYKHIZzUj1hV7dQH+5ifNl70A0xallBufHZQIZ6
	 RRUeg5Hbf4wwga4hIXKbUe2YcqBuRokAYSP6OtktXcPcmE4bCnQcQQoRYPZamdHGMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325776;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jGCqEVzR8T1S5Te8Lz5QXH3GsyVWL8IhPNvqqtIcotg=;
	b=idhos/RxVAtaXmY+Mpxp4Xv+7SllndGC1VE89SfANpZ+0vK9r6FifaFpHJ1SZHHk3UTX
	 VWjYhYFWCkNMZtRAiH59DzNFUQtw/pzCDT1ufolTlV5kPQJ4j9fLojbnSkS9awsx9Tljx
	 4sSLpymCJ1EjiNASqhASKmHwzgAdv6W2FS883ocaKNHEG2vHpgbW1vsc85OiSyVhhYGpK
	 H6xzvykz+/DpOy+9Ok3lR4dbFyP+qi/ZNM+23XmLS6a2i9WQeK8XRVTKpbYbACcgLMq4y
	 mtPNJUs/Cb8cAZeOTaGtT49V3k3ekIXj/kNwSz+z3IEoC2qMT7L50SaoBFs0m4YFmEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=CS9+kCg8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ThxInMuZ;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F945606A31E
	for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2026 02:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F945606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=CS9+kCg8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ThxInMuZ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D5A4EEC0588
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 22:02:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 22:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793325774;
	 x=1793412174; bh=jGCqEVzR8T1S5Te8Lz5QXH3GsyVWL8IhPNvqqtIcotg=; b=
	CS9+kCg80UFquvnQJvnWu1yUSwczvy/s3xZCDCMjt2ODUqwXljno7+gGdVODhEWE
	kzXgdv9vpaLIjfeYlXXaxakJJbGzXNuZdXAWTiDAg1HJRyUbhyq+sBB0X5hKmu0x
	EKchhNdbgC3fON7K5XyqpU449Ex79gkVvqC+kOomlOm6ij8MwlW77Ao8gOBfO4Z8
	pwbRl8MucHywt+DLezeXkG5Yp9hrIDWxZpUm4upmVoqUSLJkrtNt+l/RK/FczF7M
	57HWabY2Ewgd5bEzGNLtHclMA3NVBw5hPtHICZR5a0JxUYE6EP+CW07TmxED3g/N
	LFAcn4bpI5KspkEMServXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793325774; x=
	1793412174; bh=jGCqEVzR8T1S5Te8Lz5QXH3GsyVWL8IhPNvqqtIcotg=; b=T
	hxInMuZodVHh9qTpSdZOUF0OCUDmQ2agEfFKHrr2ktMZ+eUdUBGYv6P/L+brf5Zr
	LYhnlIqGD5XyIhITOkXRrhQoK6Rt/GfS6Wv7pOLoFCXmtivKjzND5QrlVGWz9Kck
	xcf3mf443ZTNOg0qtvoRXEHlxnhASMGlqKbdNJgkxQOWtBTO8m59mHiIoln3N3CP
	ItfL6CiGdFIXpfIheeIP5odHGIxTiuQO4xMm9K8ahDzqYsrD60UIvT1UnN4ZRomV
	1LH49QcZqVKcNs7pa4O1DZ23TWWRORmDvFrhEx9OyLRzxGL6fISF+KVdNrQLbjH5
	Qj+beA2/8OminfvhY4F+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793325774; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jkCOPchbVhmIsEan+/yyGQ7YqTeuXD8NkSKfdvbeiOCeT9s
	9cQmdVOMt7UohAvzEGGODPM9QM/2K0ynJHxSZIRJu4mMUp7L1vpYVQe/s6FiK5SZ
	lqpyQ5YtRwFs7lTCC1zk4AVBk97rf4RVRA+RDCHYKEZEb+4WTm7ruodguY28RdOw
	xLfHA7XbGqtPMAVKZMngrsFP5ucKfsmVgbp6d+kuAgl/jXmPFpJ8f8pPloiGuNXf
	V8VmpSzJYR+8JcbEpb7iWxrBEamO5g80At3a6Eq/b5Rf6lKYfUT1iuCD9rC7kTGd
	R76ujaA+6k9oSycaftw5eBlrYf39OllRWQtPRFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BHAQ4FGcV0vC5kZ+s1eHL1VLTD9CCd8qzVcPUVp7oyA=:WXN9aA2uAcweQ3W0QdkUDtUrqZiXSYHVf6/pF7LdZ+I=;
X-ME-Sender: <xms:zvrjav6Aiwzg7MuWCZ2M_cjrHsSxbi5X9aUrsIcYfesNkKzAv2OGFw>
    <xme:zvrjamgnO_GIPZjV7O9KttJpRjPRG4vdrFAzaebcXEXSvVv9gx4n3BZJbfOSa0qYQ
    ASQ7g8bz6kwRiFzzKAcw9bDDRgd9nZ97twKdHtBOXGP0Ydo7xZFSet1Jg>
X-ME-Received: <xmr:zvrjaqgcOcYfH9tpZDXT_SOiyXocRQg8hg4aqbGmrkRYBNyZsHuOdc__NJgrlD2dMHNv8Jwn8WT6kGhqmdg>
X-ME-Proxy-Cause: dmFkZTFfgFyuGgAj/l0WtMGSZ5mlCRXFY7BbGhK3fHRqzV+g0zIjieft2/feh1wXq7p0Cd
    YhkJgIwt18g+bpyc9psrGGoi9jNfRrd0kmTvZQNXK1u0H/sIu0NTwbkgnxwGLihEs8cRl7
    QEM4bOaiYXoYZf/fGxFvGhGPsAVwWrIsCISNkGr0Xx7GQYTjY+kMZe3o4tz082o3MS18hW
    Sf+aWHqcG5i+X+2yNrTD+DKWpt6e7d3p1IdFI8OycVRCKTtjpj8I/51U0mCW/BNLvMHN4g
    t8LyjQnTMtyyrLfWM7t6agciETihO18Qo29x0eEvSAOBLhCX3wQrfpMx3nSpEsLeash6CH
    X8lLuuYT8DPQq78PtjhtRO0O0m0Gn6YzjaU6QHfuIwn3idtG7NBezhhekHnC5iITDp74mW
    AOsvRcqTUpx0P7KjjaQsCDGoYdv94gYR4D+QI4AP6ePw3Uz/6yBnBp9qkBEXOrBsrf6EWQ
    BuiTgDsKROxofZWF426AOnEZI51T/K2y1BEBb+90thT+o99sDynRy/p4xTdgIJPjFgqbUq
    ZPrP6sXTuOrU/Nr727gWVmdwApl9TCuUpxR697Exz7IcSHNc8IFZfs+Al6718j/H1ppb+e
    S7RUoYNMksvfOo8CgJefPTkKAhhGn98PWpSCYn56jNWgACLv5hIVDIjPnMTQ
X-ME-Proxy: <xmx:zvrjamnKAZeeXCj4l6sRQbuAaW7znQdCPJMWuf0yETolb5NIuOMJuA>
    <xmx:zvrjaiEhZFwYu6g8k7oxXnlj3APYbb74vs_BfHB1f_03hp1uPywcAQ>
    <xmx:zvrjaoO0Infry5XymrPR6duqeu8bvT78GM_-m_lAPFsB-Vv83BL48w>
    <xmx:zvrjapue5EKJ5Sewr9H4P-L2xWIOh108ZkcinIj2S4VKac91hmVjyw>
    <xmx:zvrjarFSqxAmObBIIMYto-D8vqYF2yomjH72e9UGBcFriVx6e0H2iNmu>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 22:02:49 -0400 (EDT)
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
Subject: [PATCH v3 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Date: Fri, 30 Oct 2026 11:02:09 +0900
Message-ID: <20261030020209.3833766-3-tomo@flapping.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Fix the following build error on 32-bit ARM with COMPILE_TEST:

  ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' undefined!

The driver divides u64 values when it converts between nanoseconds and
clock cycles. On 32-bit ARM, these divisions are compiled to calls to
__aeabi_uldivmod, which the kernel does not provide.

Use div64_u64() and div64_u64_round_up() for these divisions, in the
same way as C drivers use div64_u64() and DIV64_U64_ROUND_UP(). The
results do not change.

Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
Assisted-by: LLM
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/pwm/pwm_th1520.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 728993998446..bd05fe49650e 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -31,6 +31,10 @@
         mem::DevresIoMem,
         Io, //
     },
+    math::{
+        div64_u64,
+        div64_u64_round_up, //
+    },
     of,
     platform,
     prelude::*,
@@ -68,13 +72,13 @@ const fn th1520_pwm_fp(n: u32) -> usize {
 fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
     const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
 
-    ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
+    div64_u64(ns.saturating_mul(rate_hz), NSEC_PER_SEC_U64)
 }
 
 fn cycles_to_ns(cycles: u32, rate_hz: u64) -> u64 {
     const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
 
-    (u64::from(cycles) * NSEC_PER_SEC_U64).div_ceil(rate_hz)
+    div64_u64_round_up(u64::from(cycles) * NSEC_PER_SEC_U64, rate_hz)
 }
 
 /// Hardware-specific waveform representation for TH1520.
-- 
2.43.0


Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653C41BA87;
	Fri, 24 Jul 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917025; cv=none; b=rLNS7Z5jKcCZTkwPFxTNYUmoFU/7EPAEhrPU8hM+ImUYJpTXyCfbX5bsQbtbZB7UbnOQWVu7nkVcDl9yJGZFkhL6bQSDlVojlgHZ6i3n4AuRA8d8AXt829ZOANl+NMKy3lImumdu8E34EJG4lIwKxSrTpbVpXX/5kztCmpj3G0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917025; c=relaxed/simple;
	bh=EAgiesomzybSknxGeZNprvP2a+/4nRBcYAJ0yjY0iyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujD/NMenscG02PlIkhebZt4Wj3g8uF2bt2tQb8QTrmZn6BQ+/2iPEcmkXJzhuL+cd1YqPRn6op4sq1jVBKZp3tbux6N0uW8Pab4NND9fT9Xb0Qzlyzm9xpzkg6ZFnskQrjlVTVs44nuJwTBetHBpv2V8fda9Nd+jF+B5l91/RWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=cc42/l6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YBVxQcxc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="cc42/l6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YBVxQcxc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7216B1D0043A;
	Fri, 24 Jul 2026 14:17:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 14:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917022;
	 x=1785003422; bh=0P0G96PnVjrvutMww2xQvKi++EmjNPwy+LoL9j5UZ6g=; b=
	cc42/l6l4fMsh0w40TKNFR9S19xbSTItuHOc0D0bcT8uj4LTvgC+QMDr6QKB5Rxq
	03VCZyktTP2lCgHl8UZ1hWXnFfi7Bg4zfXq4BFa3qAJuux1oUjYFTOLKWlgPykv0
	esTzRT3Er4AmidurlVilSWhQNJ1C0VPABet4tkXWTutW9lamJR0K3KYCigrcMJKM
	aDAe4hIbdMqqKFg9sC4gU0HrUBsvpedbnx365m321uSFzv916OqhzNDvxfwfbKjX
	Ti7/aU/m/b/4lfMy71N5s5hThmfJFbDjqMykWD4Mtz1g897eZ02z3ELRJmhrHQ03
	5naRjR+ThGGPKsRLPwNprg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917022; x=
	1785003422; bh=0P0G96PnVjrvutMww2xQvKi++EmjNPwy+LoL9j5UZ6g=; b=Y
	BVxQcxcr9DVB8N/yDG/9tvdza1k2tm6zq6DheB73FBkLHWN5HW4O9HKGGYmPg7bH
	TqIEUagCsBvuk5nW9taLp7TlU11Cw9UnsiCbpgMETCSSKhoG/68sCzJI1CY1To+6
	nQOxA+otCYuf7KmGZ8yqsssEUNX5tqnRhlBAtq53mtCdDEIT8sVP4/fSBLz81qht
	Wl3ChpDdtD5bX+C8M0PfpjR7lX8RZNtasititjeJLLiYE2sfo8i/fyuZutCwLA7F
	uYwIX+je4OCoFSuCIpQpvc0KU9IOC3kcCdRPUlqT4QQem0Xk5JJzarPXGar4a0tq
	2xScxINeWfr+5dWRBbVmw==
X-ME-Sender: <xms:HqxjarxeX7SRP0T8K8_q-QY12QHNN2C-FlJuijDUoE5XrdBe0C5hBQ>
    <xme:Hqxjat8WrvtBl5yOPnZgGTJ6vSUGSNXeX6-XQOZzx7DfhKOixz8B9Jfi5684_IJuU
    8oX6WlE2v2WW8nem4hxnKERj8y82fPmV1xhDadAzL6VFXpOU3mA_oXQ>
X-ME-Received: <xmr:Hqxjar_J_xWrfSylVXAvVtQeGvkHe1gUXmQcWNFoit0F9R6kB7b7XOeGnCQXEZAVbr5fs3yFiHpieo_0T9Tu54DgIWcCgLZxKHo>
X-ME-Proxy-Cause: dmFkZTE3h1iVBXYgSPcd68LVCbMYhnuaRavLLB/sNAzgF08hajlfFlCPkBNvaVlO65CCyO
    QhgbitTWrQnOHC9ZmasH5y88JNj+pctJAtJq+a2i0IPckhKnqCV7tXHpky3XqFscCwfRF/
    WCBC8Vi+sPQ79DnvzHozlPPSn4b4666jd32NbvbVPQChZpAQ+cm9Ep9tGXS9uhHWHKqZj/
    LrrZwG6IJepoE65fBiVyb1J9Z+W7M834F1B8RDvhl2DiDxBd0m14TWkej7E79wjgkaIo38
    tS/n4IH9JTg2MYL380cfV565ZYwxVuts2GpUZMhEGHUKz5X2W9m/9lqXSWdFb1i1YZmMoi
    iRyS3P5J2/2GJKSPre7VmXavrnfQ9mafuvONbD8qrP5bSnHK0s5DKIwyNj5h9Wirf5Api5
    E2SLzW8oBMIM33XafBE2+hdbHtqT7L49ly864o673WHGZPXvMkZjTZodkMqilg4J7xzNtZ
    hiqUlsoVXrIYNY4LIcyAkFIzLScNEdfR1PG8bfedZh0oNVeAcNS9g3RDThvkvEXNHPS5Qe
    KqOBguwrXM785WFQA//wcP1IZrvn9zPYLKegqMPButVt2qC+DHhV7UdyYpMQox41zWAPPI
    meFctFUiGs3cCWcfVaFVLFWfXiuSlAJTZkWtO4N/AMLMr1nZbWhuz2EFSVGw
X-ME-Proxy: <xmx:HqxjagccZ2hoHbIBFnzAfLN34jZ_wSOp66EWW2JG8sY-ra9W5Y3HQA>
    <xmx:HqxjantYKEq8hdUTu2p6VHuLjB-ck-jgeoOppPhj239qtDBDhvf3HA>
    <xmx:Hqxjap3FKnBVlqn2pIvCUZIzQjnAQx29bvJk1JMjUEHD0KigDXe0sA>
    <xmx:HqxjakDxMx4_om01tJ0B3PicFCFmGgHMVq2s-fgIbN55zG0uRE6FTg>
    <xmx:HqxjasWRtP24WDfvvC4fuAuD5NexvOgZu8yvL7zrKbBYgGqrOetpGfGg>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:17:01 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:44 +0200
Subject: [PATCH v3 4/9] dt-bindings: arm: apple: apple,pmgr: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-4-bbeba0420603@jannau.net>
References: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
In-Reply-To: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=j@jannau.net;
 h=from:subject:message-id; bh=EAgiesomzybSknxGeZNprvP2a+/4nRBcYAJ0yjY0iyA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNXx/VnYK7UjwNvKpT+8t6toexl44u9bq5vUXy/Zlr
 EsSWtrRMZGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATPWLGQz/lAOnFov8TYw69bp9pmHypVqLjMvn18mt514+YfH/2UHSUxkZJp3ILnr
 9/C97gonHt4UhQSdkOf+s59g+O/xkfOJHobwzHAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The block on Apple M3 Pro, Max and Ultra SoCs is compatible with
"apple,t8103-pmgr". Add "apple,t6030-pmgr" and "apple,t6031-pmgr" as
per-SoC compatibles for M3 Pro and M3 Max and Ultra.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index c67b67ba065a..1d2001836eb4 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -38,6 +38,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pmgr
+              - apple,t6030-pmgr
+              - apple,t6031-pmgr
               - apple,t8122-pmgr
           - const: apple,t8103-pmgr
           - const: syscon

-- 
2.55.0


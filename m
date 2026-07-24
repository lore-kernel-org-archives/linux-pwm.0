Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2648435A93;
	Fri, 24 Jul 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917028; cv=none; b=b0FFBE1XpnwW3+uvgAzX6AMBR92FF1VcL81KJX0xO6tys7oG3NG0wCCmW+PqoMwHJccTC1VORIHDo4MdneQwCstRXCcy2O7IpYmyNnDNbmHn+ry2S01wW3t6hztmrhqqJTB+ASZLoDsFY1+74gn8We5cvU5k2AVquQ7wcoQ5nYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917028; c=relaxed/simple;
	bh=EOha7mQGj6gCEN3iU4Vtes8noxMlN2Ugngc5Pw+LtX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZxEi0uhnUov2W225Gs9LRThqmeB5tJWpWyjILQlCwF8BGpCYQw99cjrfj0MrxCtm+0RWMX0Zj+TV5NZITzSKRMGuHBIBgKx7lhCzWbX9uT98PCYeXZROmU6eYXCKblfStMnfuryWFKQ/HS3M9YpUltLusLiK7An1vIL7bzIpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=YoaOmurX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDPOJCXW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="YoaOmurX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDPOJCXW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8FB77A0140;
	Fri, 24 Jul 2026 14:17:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jul 2026 14:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917024;
	 x=1785003424; bh=MfPtBwdr8IfR98eQ9trEccphSZy9HVrDnNdNbRygOTY=; b=
	YoaOmurXaqorUpCdKqHWBKPOv45oVI7anexJ8lgypFo6zzjrxpe8EWQlZfGWe+j9
	ZpqmuC/GwcXL+fEQ752oOEai1kJmF72JsALp2fdI22C6lK38+nllwMxtTTy3aMzU
	yAJZpnmiU0B2257HOMEGTmQo3JgpyZQ0z6dpEam/9LuiHlFmuP8ELQkIRXtggUhO
	rB+FyDiWvpO/RY/kJgzuq2tcmx1BWJEWMDAWY1FrlsSw82wYqBcY5nJQ1CI5WGtI
	5OJauYn9KgQufrjIF1740KfSwZSnAXcpMBAvfvMq4PGoXYYqbb0MMEXRC8IZDV4m
	7dGKUrud0ix+es3yDzE4AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917024; x=
	1785003424; bh=MfPtBwdr8IfR98eQ9trEccphSZy9HVrDnNdNbRygOTY=; b=h
	DPOJCXWf8ptp92Yoh+kTsdeLwoTq2IW2k5YdypBX9WEFktTHOophlfcC72mplQwN
	IB7Q+3qVPHNV1hUTYi0gL1863JxTIp0t6CReA4X61WNmJRT/rVyfbuvNrn1jRQCo
	VXg1gXzqndb2cKtbCXmv7KSHrBzZj9r2iqfunNEkDqmaLlec+NJlMDTJPTMm2VTN
	tsKP/zjOfWQjhRnydCgjIgbXc6nie0a5mdglznjJQ7DHr1T3W262gQIWq/Wbfi1B
	xjVijwBctWbOwDwHXJO4tFMaqO8Z7QK98oxJIvx3e1+MhC2jTpqIAyeOwT67nHcW
	Qc5Pkce10hRUqMiBFR8wA==
X-ME-Sender: <xms:IKxjakATDSj1dxNY44hnwawgqQ6UQuYvzJFCF6xbyPaoIdA8qQUVrQ>
    <xme:IKxjahOLgi4PKJpyYyf9D2ZYOqx-6dZ64LEpJmVJfB7cDJyMM82w6ttbcLU4gM69p
    1d1LrGzdjIoae5NFg723ZMQdV_syzmJCD7EWW4OX5lCuOlpmIXMTA>
X-ME-Received: <xmr:IKxjauP7y9J0yCkIBlIecIyOGrnW8yN1wN0zb40Oh_Djogq0siWUkmdF9iq8oM_uL7gZZhShJrhpt7SfoGLTuQPk2O6VwCjpqdk>
X-ME-Proxy-Cause: dmFkZTF1FX2rMAzDkHprU+9SOL/dAhdcZMnSKVMN5sSZpEXUKt0tpgGTqps5g9gzvwIbS9
    s+sfCmoO948cbdaFVKnKsFQZWlQG5l94gQ3OMj/lpmOBEFweLBWIwVRLX2N9lNc3poNr7O
    L977RANIhWLezmIkgwNFbh0KndpYGeRMYxoZTX0qtVRW146Bj7liiLUvZi0nEietp5Cetj
    sJsRGwTLW9VSWvYD3J5JA907Ht+C8uVy8a9gtIre/v7Ls/lg7fJiukWLBXmui4C8aVyG7o
    /Kp+oo5oKDhOQFee530ewC3yY4DxTEPsylZrAsmd6ePp8Q01nTX08+81q9r13bu3UjqCHm
    HS5MC+YEgtyvMrXG+Z//TbC5mAC75zk2D4n4c+9hpfpMrEyrSl6pJlUXZeI9PERAPZKrJ+
    btgLjN//eYP1xeviAZv00OSRv6CFSdiqCuCEa2SMjTt8IrVVY+pUYYPWlHiiWbpsWo+JEd
    8/ADUHSy027EzxZ0tOMrGubp0c6jqQrCXElaExv+e+n4RI30fXTQO1YyQeNYxy9E/20GqU
    LFZUMUWKX17Wk2yAfd2HmPPpkSJzTyxje2yeEoJyuFxsef9U25AN4TG22IqwHbBkQzMTOv
    3NJHWyIgXkjFjalp+xb5yjYkSh/MNafUNWL+46wuN0NF41GX2NvnPy7sf8YQ
X-ME-Proxy: <xmx:IKxjalvNlLFeHUBOX55-qOyc6pvKlccBWt6DORc-XvTv2k3xvISIKw>
    <xmx:IKxjaj9RXtFPY44SwVa_oO9JH8KS1kGlE2e03-nHWvupJmPzU4Bslg>
    <xmx:IKxjahHJVcxLeNPeeCgNK70MDHGCYLsjohlABcGrpbJgFZ5iI34rcg>
    <xmx:IKxjaqShjsigbumh3U27tDv_ExoVBEa-Lafkd_rGPKxz2CpfnVbeVg>
    <xmx:IKxjajm9mE8rhARhtDmXNotV6cjshRroA2Qw6HMoT_XGogNVAxhZ9FGA>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:17:04 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:45 +0200
Subject: [PATCH v3 5/9] dt-bindings: power: apple,pmgr-pwrstate: Add t6030
 and t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-5-bbeba0420603@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=j@jannau.net;
 h=from:subject:message-id; bh=EOha7mQGj6gCEN3iU4Vtes8noxMlN2Ugngc5Pw+LtX8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNXybFX/O7o7TyNt1utMkaeZMy6QXu0q3H8g76LCKe
 zLfdF+ljoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKrVfBn+hxwKkCmYLPou3fxNm+rS36dCHSrnbJGW19hruP5U2Lv6lQz/NI71G0e
 ccW6Y9M3p5yUNxgcng18Yxj8sbn850yT3EOdvRgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The pmgr-powerstate registers on Apple M3 Pro, Max and Ultra SoCs are
compatible with "apple,t8103-pmgr-pwrstate". Add
"apple,t6030-pmgr-pwrstate" for M3 Pro and "apple,t6031-pmgr-pwrstate"
for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index c9be097cfba0..e269f433524e 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -45,6 +45,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pmgr-pwrstate
+              - apple,t6030-pmgr-pwrstate
+              - apple,t6031-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 

-- 
2.55.0


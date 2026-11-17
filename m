Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920261;
	b=2xI+dbuUv2ji1XLrLKadAaA85kp4KO6VHiZyLOcbqpOG+jrQPsH7Zp85b3aY2VduVJRG
	 42a7OZYr0iVvkoWbO1FRQlWhsXkTHCsivPBRejVXv/C1wdO4TuLn/27Cidd5Q/pwvp4P8
	 HXYNlMZ9g5NgdAgxNHTMP2+LoG4soVGVkd3cgmdZAE9z6IUET4VkVrsrkHZ0EIoxPSt73
	 ziwtmFfpH87uQ9yJYovlojCG4TT3kVYLWWzBKyGVfLhhpLtt4KUNz8Kq0pnWJ3N5VesvM
	 rhNDK+wDy3w14pyuKQkkSG7kxO0VhfYw/CNslGlGbfLzpl0ED6XlICoVHpi6N9VXpZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=pq4AjLVwM19r78cOmsBTZmnW52I4hS/grHAe4MpsVsY=;
	b=k4zPsFd0iTYYJcEbz0SX9ERXCpcpTJWvrzn6XJHl6T77AAHEwS7XmUjCHpPX4IdiveXr
	 jfm+dXpYJzpZgvuuGzh6WPe/AY+Kk5Ic4508BNCRluhWbO2skuz7dQMDjJF2bfuhDO0Zc
	 +ZbrrvFg697fNWJXH/2W/jegXpl8wG1sTX71XTn36+fzwx8JCqJysoSW1Q7a5j/b1nzCi
	 r20h/yt8KMMei7++9nysERS999YMK/d7jmDYfTJJlVtqPem+6OnpyetIx+Kbr4UjeoI15
	 Qyqm1abxujhPE0BoTmHZxttaJiS+/YlmAQJtjB6KK80x2jUhjg6vcX7UNW3SorT/3Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hqbGnlds;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE1606A337
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 12:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CE1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hqbGnlds
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so11661232eec.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794920260; x=1795525060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pq4AjLVwM19r78cOmsBTZmnW52I4hS/grHAe4MpsVsY=;
        b=hqbGnldsRnNYQeeJ/LsOxnTjKzWYSBL3+tdT7EhSLvinL0tTzRB6p340IkMHV/b3t1
         p8/5oMc7sOgO/k69d6xeQro9UlUOwxjJKD15HyuuLNvAf04ZelbrXzHWZmx2bj/IcNqb
         cv3r6vpnls1OJYtYo08cymmRO1BTkKmpPodoTARMRyAmGkuYRbQhfi5sCQDDgmooPoz0
         pBuu4RHR43lRX2EN8FIdUYHT6ogk4bILpwK6NYjanSs1FH22geOZ7WOrNlYBSS1/CMRF
         Cbuz9xIvdlZJbSAtn9XQbeqOPkQC0cW2XmQDM/LWud6OFk8cIKUlHmhG0rmb/Tu/pCQg
         CxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920260; x=1795525060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pq4AjLVwM19r78cOmsBTZmnW52I4hS/grHAe4MpsVsY=;
        b=sIrAoI2TVa7B5Yh4RFoMdLmWKsKy4MZmj1aRtQYyvpbTK0AR1QpzEDBHM+EYkUslJa
         lXzk26XnXkCfBn7SF2hky0OGID4o5Q9hnq+XM0bTDupq8QJ7VWud45d9vgw1C+0FISZx
         z85qS8b4jUWctUuEy42HdOkOXf9500Ux74DvWivMcMYUNMTZURUc+bKOckn+JG8q4OyB
         l5j1DQivLl2Q+rR4RW2Y5AnESngLdTgcYOknaYCEWpKeLWTJKpGiQBpJ3BkIgCgthjhf
         njQsAksIP1ra9qrGLPqgkpjrsPPXNVvIAo3LnG8roaBL4PGE1ccLIXESlqWEgH45Hd8f
         pncQ==
X-Forwarded-Encrypted: i=1; AL+hErGZM0lleKUo+qXJSWmJb0+eJYYl/61QhPoZZAy+mIoZ2nBmp1j5yh+mnTMWuxsO9jLe9JLTLWTKq10=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z/vbhEt7tQAhqcK4pmdajDjeP7i1bYzSpxZe3jdG4U06YUDwP
	mDVTzsDENcKGcv16i/h+pxLGgnqETHd49wqM0kB9y8bfbdWFA+tUyD1PvSqT89WC5DA=
X-Gm-Gg: AZFdTZdPMLlZACTTZvG72tlA9iRF7b9ZjZ2Kg/qUKhv9z3aD8clBfLla6ntdMxlXAaZ
	inJJoizQoYzvsIuTUozO52wERDhrgCEsyIij87j8utWdZuojqJdHcMmq3WwW4SlqEZjyPcnR+eT
	cviN6mewEiNo/aLVJyXSi8K3pP46piF8ACnW8pbIeGU3+6MOlzIWpzHFSdly1vzPDycthSqE+1Y
	bHML1AqphCgMOL0yCRw/g1VBxl7WXq/dFkzvFXjqMWj90wlZDQByk7TpFzRg7dWuTP3jtQAxkvA
	9eFWCnbU51X+1SN/5oGqUWikkFiweIw24aDuim11Qv/OLmdr/o1iC4Pdvsm0AuhBJ96PszK4z1y
	sZ3o5yALBkoI2A3/Sig2BDKtO+4lnTurKlijtJfVgUXU7rPHZSnhPHtJI9PttZCWV3In+TDwmMe
	Iyky8Iqt7M2m5AcKlM+PuXAHl83NrK/1xpPyMHaZzsZUoltxc0uCHPzTgo0rOc8eDVMuOr64Q0k
	vNFJw/xpd7xAeLPleWA0Kugdjw6IbzsmCyYoWCV15amLxsf04caRjk/a/ztNu0QLJKgx/RoCU1M
	WB8+zQWOZweIDpe8u1G0H8fSjQtd3ISEQAVH1ifgRrdX8QUPc8AQCpxBrYM+xXSqnUTt
X-Received: by 2002:a05:693c:60ce:b0:36e:8410:ecf6 with SMTP id 5a478bee46e88-37966387d74mr15512381eec.13.1794920259546;
        Tue, 17 Nov 2026 04:57:39 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::a1aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm44767034eec.11.2026.11.17.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:57:39 -0800 (PST)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Tue, 17 Nov 2026 09:57:13 -0300
Subject: [PATCH 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 CV1800B
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-milkv-duo-pwm-v1-1-3f1786ea57b7@baylibre.com>
References: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
In-Reply-To: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Chen Wang <unicorn_wang@outlook.com>, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.16.0

The Sophgo CV1800B SoC has four PWM controller instances that are
derived from the controllers found on the SG2042 and SG2044 SoCs.

Add the "sophgo,cv1800b-pwm" compatible string and update the binding
title to cover all supported SoCs.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
index e0e91aa237ec..11544b47c1b3 100644
--- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Sophgo SG2042 PWM controller
+title: Sophgo SG2042/SG2044/CV1800B PWM controller
 
 maintainers:
   - Chen Wang <unicorn_wang@outlook.com>
@@ -18,6 +18,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - sophgo,cv1800b-pwm
       - sophgo,sg2042-pwm
       - sophgo,sg2044-pwm
 

-- 
2.53.0


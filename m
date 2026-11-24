Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541584;
	b=Opuhf50f9E5jR9mcLh3U7wWEalooyBYT/XpEqkkaQu1UKG/zjVWWw5BBX9dvT995aAqV
	 /0D07NBSQa45xMoXU6EyD74/R53MxZXJSp+KraQxCtPljtWktmypeBEBb/OeaDLDa6eik
	 Pn2KervX+qKJjxED03zKEg1EsYSLIjJcEPuPjpQcwIry/9XIVwb4eYaXwtD3oUBK1RSGK
	 ZSGjzlaAubKmt+jCY7YcvbXTmq9ooWYBsiktt+WC6QcrNTFmaTAA5gSPY34DOEPpsWOUc
	 f6NpgBlebVmy0JX2Kn35+bAl+Y+TMuP5L0XNnsknEq19xG5ASx7+iTYgs0pNUG/JV4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
	b=tffNo7zM8yGUL5l3pUs+gTx9RkK7IqAja4JGkRg3aVg7u184ig5ERntthyPTYPN1pKxh
	 78zELCFwpE2E9iYm+43kvJo4GEKqZtfZne6F5pAAxqGQCkgZtf6fEJxGdtppmyZ+dhCyr
	 uvQRcUoPgCt8KbiruXA9vgpFq1+enDwDiQf2XlBJ8w91kBueoRCAIULZpkKCESBFndVBo
	 DFqcar8UaPFxFak3FdnhNfhNb4ikuoDzUxLqPHW2C0Yv9ICm1euBMokliXHslTyicyFUm
	 d4p5tIWzG+8UWn1pBIz2E2UD/ihJpUvTGJOxha6n32o40PoXgtNWUWsV15ENeBCghUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YBeE8QUO;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7E60A2623
	for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F7E60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YBeE8QUO
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so44330025e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795541582; x=1796146382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
        b=YBeE8QUOOp51AgJ3SsRNyTURxzAxaIkVckh1C02xLsmCc5ezSk3lgZBSqW1dJ635jV
         EonCr68RcWbdREMNRZhlFzjZ92CDDH+sWWLhhDxs3Rvrfy2xtO4TY8827SYovhpAv4ai
         zfHU2mTEcOK48CP1YZVDzt+2gvjjHnPIED0Mpgu/kl1a5y24Kmf/+LulxSTtfsBUTgPC
         fdSmdHmMuFMEhTSbA3ymlevkPfvIQylu33tqvIY2GIw4W5p/0wmv4C4mRoBT8qinY5h7
         jW5hZHDl+h27oOREs94urwC5xSNzEh8OxlwSwZ1brBoFZooBUG4gfxpCZZBxvrWeEtxV
         8TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541582; x=1796146382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
        b=gkX3z5pseH3IuLbeoc2E36O8fMG0UsT9aIUHT41BcSaKjVuH2YF3aZS2hPOVY33vCC
         88/1zKR3y9+uImlNEYksP6BkDc0ly+AA8X0G0yChN9TSoByxzX9iXd0yokpHBnjm0nMD
         jcTlcK2gMnFdJUQLtVPH68wXZjlppD0PiZMk6O+HH7x6hu9dRUO0LTWaKh3onetHzFbE
         hakXWACp/+RZ4OHA+rW/6XF6CYgLi4oRV5zv8oMlbKpXoNb0RZx9H7tfb/fXxqgDB8TC
         XQU34RDlm70bOEdCeezBx8Bjjg6/OWszwUuhR2vLavHCtPU/VuOUg2wwc3Toiet5TFJF
         s5pQ==
X-Forwarded-Encrypted: i=1; AL+hErEv6LxslyjNXz7Fx1QmeuhG+cb6l+rHsSFqGjbqGnbld2t9iQJfnJBKXCriKwxxE4+nCwZKzBbT9Lw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XVnKjuX20SyD8cPcSfymMU+z9tYmU2XSPyWPTahuaU9fqZAuH
	zz5SAJ6GqrIwBx0l9WS9cYhS+4CRsDWwac6s8fGUnWH7xhonPwvrZeSsWwJNrOL/NME=
X-Gm-Gg: AZFdTZf5asbrzsCtLgTYI0/9C2A2vWJEMOqAKypzOOhLvPHoR/OaSNQ4el/wig8wAn8
	TYv9zjDnUNLffqtyUjIMfreBiMhPV4qnq59QGsw3tzDt4uW9OxHq6kEgC1PkEpkQXNFeb/ynfAx
	QWMRsJeA1gKtpt8HJAZvP0+x2VR8ij8pTAtqOWVu6kwyrHDS5MyfXYY1SrBYuEmlZKm0v7ILnPx
	aFi4RyGZSU6gyNNYDbd76YR/5RI+XCdsmv6N4ZLn/PUhYKKUJSKrDVYKcPIDyXKyqzuozTXR2vh
	nXO+u8WoryxxQxuLjql5NeBTZ/lQaqVf+hr4d0TFnn6+xOXNd+/bW3pIrDe89O9duiOvyL2rcYl
	es1X0kyp/d/XrW92qj0RQwQJiihtHZVeZSuvANttLTKu3ozLXLV7PbPIl6cH/i4zJCdgk2gIT4/
	wAky9c39zwzRZK8oDzJsiC0eQuaR0dJrYeK052yJPUOir+KX1mBcShvDGt0cQP+4sXXKV9U5jBl
	nVMuTn3dSmFzEpe2mq97EqmDkLAHOgRDjzfIVu4Qz0pEImetsc/f0OXBOkbikiC3FIXpjn9o9n/
	mD2mgW0WIQzJR9y8vGb6LbdLx6o=
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr309983845e9.34.1795541582068;
        Tue, 24 Nov 2026 09:33:02 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm439552155e9.6.2026.11.24.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:33:01 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: naush@raspberrypi.com,
	svarbanov@suse.de,
	gary@garyguo.net,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v13 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Tue, 24 Nov 2026 18:36:55 +0100
Message-ID: <20261124173658.31030-2-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124173658.31030-1-andrea.porta@suse.com>
References: <20261124173658.31030-1-andrea.porta@suse.com>
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

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
The DT binding has been applied by Rob (see [1]) for consistency tov7.4
and is part of v7.4-rc2: as a consequence, this patch is included only to
make this series apply 'logically' on top of v7.4-rc1 and can be dropped
when rebasing.

[1] - https://lore.kernel.org/all/20261102192302.GA882027-robh@kernel.org/
---
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 000000000000..be020583fd0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/raspberrypi,rp1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi RP1 PWM controller
+
+maintainers:
+  - Naushir Patuck <naush@raspberrypi.com>
+  - Andrea della Porta <andrea.porta@suse.com>
+  - Stanimir Varbanov <svarbanov@suse.de>
+
+allOf:
+  - $ref: pwm.yaml#
+
+description: |
+  The PWM peripheral is a flexible waveform generator with a
+  variety of operational modes. It has the following features:
+   - four independent output channels
+   - 32-bit counter widths
+   - Seven output generation modes
+   - Optional per-channel output inversion
+   - Optional duty-cycle data FIFO with DMA support
+   - Optional sigma-delta noise shaping engine
+  Serves as a fan speed provider to other nodes for a PWM-connected
+  fan.
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  dmas:
+    maxItems: 1
+    description: |
+      Phandle to the DMA controller and the channel specifier for
+      the duty-cycle FIFO.
+
+  dma-names:
+    items:
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@98000 {
+      compatible = "raspberrypi,rp1-pwm";
+      reg = <0x98000 0x100>;
+      clocks = <&rp1_clocks 17>;
+      #pwm-cells = <3>;
+    };
-- 
2.51.0


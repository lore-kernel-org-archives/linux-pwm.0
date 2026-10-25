Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918009;
	b=ZCeYkTiceIhiCdQrWSk3MdfqBRWR+JMfewYy7XnEJ/Ey2yVPPVKuR5l2MC8YYpI6GU5F
	 Fk4kNVXQ4pmhBDCxmEm2OqAMtkcPdgCYSk3Zy1U3szHqYP5yGuVOnAkhll59OI4IPSWtr
	 T3Cn7TqgvMRuRC3+RlyZmJ+faay+B5it0F9TXRDqz2OmeNWAblTqxQgpJVpLFyDDvHIeY
	 AyAuApbkS58WJ5lqE7dMwwVPcXJSXJ0wb5tHa6b0OHkpd4GHBETOoqRWTC/ceZgEA8Pqk
	 2z4juVgQtOv2NhBZL1XsfzVkFfNRuL4/prTxpJPxqXTUy59j6Yuc9hmXB6gO0qjwwUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pSPsp8WYgTyYIXd11T+owTDZiioNpZlULQUYbYv9uh8=;
	b=dkMUVGg6TGRfhWikW0dYw2Pz5ItIwkU6dLQSchDpeYA+TagOX5Iww2CFTcrRaAwgG1zB
	 rl/x4YqCMhJ9C7WW97uo1Og45G0dKMprN+RPWfAJ8cc4Ef2HK0u7toTYq5XXzMRWQAAk1
	 EUWVlgDZ5lDd20UcwTOG04fAmkGeQC0wBVwkd7rsCaSjmOT3wzznpq1YyaZwC7UtoNNVf
	 jU9RMXoQbR+TSrXquKIjZQROXveHHU0K7eTPqLJiAORqhYtonX+Iwauin/r5RLtULfaNx
	 bCFAASDlvioYbr9jcqfJjpWYVc4DR9ZoZVbxEUPqVavgnAvH7a3JMAe3MtsNaMYAq5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GglVcgwI;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90084606A324
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 08:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90084606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GglVcgwI
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e04773687so641645f8f.2
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918006; x=1793522806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSPsp8WYgTyYIXd11T+owTDZiioNpZlULQUYbYv9uh8=;
        b=GglVcgwIKfAuJzhKvif1QWUuF1DmaBjTPt73jnHhBWyFQGu9HtWWP6M2Tz+X96NCD5
         T54adqHu+0zbxD/MI23x4hZTgKLQ/89mWBumVhcq3Bq7KBtQo8hsBKF72Tol3A1Fo49s
         MnPnsbVy5gmajXbl8wvpi9uUcTJpvb9Am1YQrIskxtNpz1XmWUMWvWi4sG6+h01t8jKu
         mW5Q9EHUpw4MeWGCe3bWziK4S7W/GF3BvX8PYIeTrctEE8cKFQ+GEIYT3dJ0r8bnSm/a
         YeNhHaZAVgRYEPVANK9zwMcPLZexrkAz5cRXuEgqjYU1fbxPN/hmC3+Noy8aTJktNeF1
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918006; x=1793522806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSPsp8WYgTyYIXd11T+owTDZiioNpZlULQUYbYv9uh8=;
        b=sl+/gTgZp86sNj78509nYgWg+awZ+MIjZeif7Go01eN8Y9y4Tye1NlwhVWJbOMsxlJ
         ZVdkrnctLXV8zqM9tjso/hdB+qLPpAXfpP9hSWRpECBBWY3p37b5TsEnoxGxcviSSgHd
         +86QL+6nZJgCCN7wLCCnfuDyopIazRU50N6TCwKlnHmlaishqqoCLptXqkzpkf8uAQsX
         5qAhI/kXHfhCjGdR06VPvPt8qcaIXcr/KHdeSXNteL6pAoPeiKvJIufYc9lrLCtu2ppR
         SwgGhwU15TBYavxYkOh/exkQ/Yr3VQED/QoFwlZqQmjlxtC+lulIACjw2pXxOHP0dbGW
         H64g==
X-Forwarded-Encrypted: i=1; AKwUvBwMKQyOQFN+t0XZFiOqOcH8ng6JSLvEjzcKDwIFRALLG7rozQcMlEfRRAyXppQnZtqiTYDSqVaS0aw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfRCoGp4iLgqYDYoAtoOaHOu9oq/ybQOlIi+Piq1VjCleGD0bC
	MWv3A6mpSNzWnAcmpJyR3yFCQWc9auMsyOyzbvot5h27dJ2j56PsaPmaXmfZYxmBUg4=
X-Gm-Gg: AYBFou371jF5ds/9Mt35G1i1lOAI+0gInigvZfsDVMQrRx1ja3u57uTS5IeFrrIuW52
	IALLDhFDz/70b9AOfu/Kc5Iyx4TKPDV6vVeAYacfa7yXvN2dQv9apv2HaIil9IFMXxyhBPb9t+y
	hIdYQu6NIxkBxIXBp5K1MgN0imvH1BLbLtHTPnq9TxsnFuHkgYB7p/pJJkvKTiH8WBrcZxE+znj
	2B/eyK1eGw7mWPdfFt4MCx/Jg8DOe+pAfxMPna96v8ymBQhQOl4bUL2YQ/7HgMylFre63zKeHuh
	y3CiZda5PadO+XekURsgwzUt1sK3IbGf07aqHvDzFJBzkoKYJeCvCMhB4f+CKgi5Pb5kCKm7wlH
	xRQ0hxdh7VCPdmuKY7EV7fXkfyU1anHCBLIUqEYcxjug04/U5dk5H8SmKlJXiCFU8uoYLtPMyVM
	UDB9Cm/ycMlPrG/DqmP/HDmhrbVg3IqjP1fIv2t+uGq9P75adJkkgZ2cCZXe+4/yQYxkf+0G8Md
	OK7ddUa7ZjsxojW2eLhiykleWrP2z8hTInPHA+qsCuEBt+QWi08L6saRGav9x3nWdo9NMsdjfqn
	mEmRuH9mPS3p1Xgh4bcs7XNtUB6nhsnC3uKbm5ik7/46/PG/nUne0xc5KXMid1/Sbvgsgna+ug=
	=
X-Received: by 2002:a5d:6f0b:0:b0:48d:f488:f32a with SMTP id ffacd0b85a97d-48e3eb8e5f6mr6646358f8f.56.1792918005553;
        Sun, 25 Oct 2026 01:46:45 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb99esm8616707f8f.23.2026.10.25.01.46.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 01:46:45 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 1/2] dt-bindings: pwm: Add the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 09:46:42 +0100
Message-ID: <20261025084643.93167-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025084643.93167-1-olivier@mgcrea.io>
References: <20261025084643.93167-1-olivier@mgcrea.io>
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

The X1600 has an eight-channel PWM controller of its own, separate from
the TCU timers that drive the PWMs of earlier Ingenic SoCs
(ingenic,tcu.yaml), so it gets a binding of its own.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/pwm/ingenic,x1600-pwm.yaml       | 47 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml b/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
new file mode 100644
index 000000000000..3ecaa92a5ca2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ingenic,x1600-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 PWM controller
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The eight-channel PWM controller of the Ingenic X1600 SoC, separate from
+  the TCU timers that drive the PWMs of earlier Ingenic SoCs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: ingenic,x1600-pwm
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@134c0000 {
+        compatible = "ingenic,x1600-pwm";
+        reg = <0x134c0000 0x200>;
+        clocks = <&cgu 21>;
+        #pwm-cells = <3>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..c905aa13bcbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12878,6 +12878,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 PWM DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.54.0


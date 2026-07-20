Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40243D75A8
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540447; cv=none; b=h5F/NkZyTKDBOfoFyB1s4Wtv1IO/WKOCZ2T8UdCequbDHR7nS6RXE1HeMn2DLE4FHXmRYE5mp7dLAV0OaYZrSIyvUTIySI/mfcGtAYvsBC48pFpCFRNcOXsjbVHYcU8JV5yAn+T5tbCZvbp9LOf3Nqd2diyi1cthMud4JptTUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540447; c=relaxed/simple;
	bh=YW9uoiEy5CuC0sIxOCa9X8yJ3i0+Ho0/5+EeRbYnQYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHPihHSB3XZHJmtsbr/aG5ehg06jcUocoSnWDeKK+pw9TFBAZW8QrUnzoL6ZChXOxtFPeAqtiQsZHgH4CU77uiLONb+E/3ldz1zd2q+9YizWflYFNlcWsntFId27OLyHWqVQFOA4etSzIesl63Uv7bH3fUWezBbBeXgFtZAw0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GKUXo+Oy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GKUXo+Oy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49558ce01afso9442685e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784540444; x=1785145244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3KtQbiImBVgvP9LE+N4FWws0mqbw5SWS+roXC5ImXQ=;
        b=GKUXo+Oywzc3Jh8vgZQ+TKHChDwNR/Y4E8rCgcS/TPBhi8fO6WSdWomkmvCzt8eWsN
         gC77yMVcD87UGm3WVfqhB6Fay+da/XZM52UEQ3+IngRv1vl9ooFb6FSaZQe6W7VQQ4BO
         +Hw5Bp832+UKbmXhLZjrNC8x6wjYt/ThnS/oBmkdKfqDh99JwWCOJVXRLB0lgk34GgNu
         kxbrl+izt8dXJ3u4+nguJOO0fdDLDKtotA+K0RhVeEOX8LOUHk4cU1r8sdKj9vZ/l0T3
         FSJHCJz/IQ4ideYLvaNPamhG0OL4OAgyI6n31Se9YMED1rySObjvIio5NZ6vdrzEsSUE
         /lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540444; x=1785145244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3KtQbiImBVgvP9LE+N4FWws0mqbw5SWS+roXC5ImXQ=;
        b=caBpYYr7VIPMmR1do1WIbuXKv2gSPyuLUuZ2LsYmjXzTyY7/RDDvMtljABeKZEZEfV
         2zg7RYojF731Ik0m5LVJEtcvOZJ4ysOIp2SWr9qH6rrou1FzMImdALsPZArRN0sn4FBE
         0wnw9xMzXwoHxf05ie8Dqcq28D5COviOQ0b6VeV3ZyYTlX/2VG/9QJxAQrui7/AzJ6Bn
         fQAxErLkjaJLnZpYTjcgwx4E68A5gIoHXvlzDy8sUVjEuczRynYcyUETBu+o33BotS6T
         3ULXZhDaZSSFNh/z917QoWzg/IsA/ni1mzZDeA69FEyMKp8GoY922Xln6SgYVwe+JVpz
         qfyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzOf1sYDB7KyNTe57w/eLGEKV2Qosnms1lgXBLP0ahVzOlmQHfjFUcgcehkH4ab+VqOxA1h2/gIks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQPSYPcmZk6gtMhH1F+TCJnFs2mQzH7v47UBv7UUa0QHRMpeG
	6aapY7kdSxt67VAV6vZzAHcNSD94ipsK6Gx8pEkfHiMGg8KRr5qph+yTmUQHlqsEAt2TsQyJkKg
	Sx5obT0Y=
X-Gm-Gg: AfdE7cnDb0wSw3hP4NQN8Mmx8NS4gVQKImoqD4glUpZ7HfItimNQlm8RdyNNmgO575C
	cCCRp/uR9GuQQegV5YdukuN5MzURf4GsgNp5hsuu28eSEvFyHG80956DNl7EeEUXt5Lbn9vruEB
	8BbyNX9iQf50/dkwePn+vlR9yQG868kPEhIUSfgC21WdG35ESHzrpemXMrw18uvP6/SiDUk+l4j
	4in4onqOwF5F7i8bY7R5d1QZFOVhYqxOT6bf2SoMr02GylYyj1rX1ScoUSRn/YS8udhLnxY5stE
	Uenx0pHsZSvVv7mbqBYGkjqbRux6Y1osLCTnkM8pLlxkFNjsdtHIXnSl4fMYaiOGeFyMKTWGFAj
	iBw7+reM5dhj200D+Vf4RAfrdQCduccR9CIoDJ/WPo/1DnrAKZX5t7jtZ4PYXX4+maTVLf9oNVH
	jB
X-Received: by 2002:a05:600c:1d15:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4954a3f4901mr160702855e9.9.1784540444224;
        Mon, 20 Jul 2026 02:40:44 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47e64sm281394125e9.8.2026.07.20.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:40:43 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Mon, 20 Jul 2026 11:44:05 +0200
Message-ID: <67d51a7210f0d7410dbe34e3d93813db1fecd622.1784539788.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784539788.git.andrea.porta@suse.com>
References: <cover.1784539788.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
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
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 0000000000000..970d0f3b33bbb
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
+  fan using shared registers (syscon).
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
2.35.3


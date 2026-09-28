Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645714DE72E
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606358; cv=none; b=bT1mn19rtTZg3IC+G3xhrB+FY/3TGtbY3EQKDSIHmc0a2yAEIlPfC/uPjMjhcTCJfNNH/QOMBPwz+ZkCybTXq/QOs8+X66ajPA4BN1na1nzAqP4r7cBfVo+IUgBMlHbZtk44U4QXnCxPbO9DlTldzA0Qm3+trt9zm7TJuO5JYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606358; c=relaxed/simple;
	bh=Go39NKKMwkuXXP/SejpjyZo/TgbX2bfpHuiP0B8nCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6ZxBPdKw+TTh5qnj8T4SoO4jrsWCBevn0SEpsszSxTbDfhI7v8YQzTh3hVk1aeGeJMSVJ6L6e/AyHCkGkOoZkNYWoumf4wykjz9ymQ763ybwMIN6hcj+uGKym4XWkGX8zyxNNTKMuS1AIpMIIKbjDXBeUXkduBKcUCF75u6l/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFTEi4Xv; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFTEi4Xv"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso1898986f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790606342; x=1791211142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=dFTEi4XvVLZJszsReOkilJ7ow361Yt51GnX19cTotmVahtKj4/nNmLOU6MJUNiaK+Q
         TiT3EzjtxZPUAkoNXyufdaap4MzAd/4A460k+ECGX2F83I9iwAbwGg9HnTLR22A9nXh5
         9WXlYoR/cGo1b1NL3M+0rVm/sCVpObhpDbls5lLMcUj92lzAjlaSziKdoSfpeVaYHNZq
         Gkp786T1UQnmM+53Q6wKdw6HyBhthXxxJ3m8OPNVQ8rNvpkYLiW8ny9D7rjWcLSDP/8V
         f7YU2108AR86D37eZsXsrC5QPBKwJMjZMvZwstA7SqIv6U9Vu6eireIB25vHBi7xIJjP
         x9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606342; x=1791211142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=q+41s4K8dg50L5PNVSMisrvjE2zjZfFrrjHFXR1Gurg9NzMwQ1s4S82ey5Ctnreo+k
         NXyBlY7mHze5Tr6+D1I8D2IBRi+JAmQsQYzwESpExN/temOeEfRLTK/CDBK2vhFuwLR5
         e3LFhjxs5CJLlLDVo1S3/vngL7ZtLVGoLvx0+faZ0CUMcJs6H2tXn7aTnB8ykSI2XK5k
         rbXd2RBar3RDNXPOTCQ+B5u1UcJvWEBOB08in37mT3Kz4fKfv9GH46XyJ52rxyGwYFUY
         14ZQqvstKj4DZkKj2MjxlIPF2YPUIgDrY/HbJLbU21gRCK+/m97ZWockwM5iVpB7LDkw
         JNSA==
X-Forwarded-Encrypted: i=1; AKwUvByVrf9vhU9LYBNwHkNW0dGUB9qgq+2eXOeo+ATx/xp6QiZ18B2OaBqsuxXkXJVYZiSI7or1hX7ySAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBS+yJykTfMZ6CpmEJt4xo3a0JYRH0bJ3B33MSSelmajgtEMBX
	TQNMWD4jZu/Oa2HaUxQ5b8/LeGQN0bcDQlc5s+fjZfluukSX8U/Y8lvJoGwK6tF5i0s=
X-Gm-Gg: AYBFou3bH2cFOmtiiOzcSBGWXWBkNTBdKEBvO2yLxDT1Xjl3auypwotGXbSu+ES1qJ1
	ZswHWJtFWLkSALcAp1Bt593e2eHrQsQ76DWLAkIKGnE7M/Hrwc4O/F/a+VwGEF1m6TleLuvTss4
	a8utVCbgxwwG4/1BYRP63dmgOg+4iDp9Clys9jrzhUtmKWrrHlAk/MiKkcYaWL/ICPFCHY80Z2Z
	PtiMgGgmOa5MZdzw5wsCUgNMKPD+6hMV1xdWrA3X0ajrwhMsrn/fzH9PhVQ9b9tzcUplBzAy4Yc
	V2WZeqOlOCmhH0V98PkHmmBJ8bG0mugnYKUyohBEEXyn6xIWrFyHVqlpB775YrSN/t6+xV4BhtC
	J0QOBCv9U5STkb77lCYeSrUcA6/3UjAEnSc5F2R7mnaAU4LXcRKDskpO3NTEf5yy/HRW3OHgzKw
	gaycoYHtmDcSP+//LCdGtjwaOqBvnJ7pn0i6B5/Y3+tEIwZJFpSUh+K7CyMBV+UcU5d/fM9w==
X-Received: by 2002:a05:6000:2284:b0:488:89ad:56c0 with SMTP id ffacd0b85a97d-48889ad576amr11374823f8f.11.1790606342507;
        Mon, 28 Sep 2026 07:39:02 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm28425051f8f.27.2026.09.28.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:39:02 -0700 (PDT)
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
	Julian Braha <julianbraha@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Mon, 28 Sep 2026 16:42:40 +0200
Message-ID: <ee0aa89faa14e0073f1271693bae28678652998b.1790606188.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1790606188.git.andrea.porta@suse.com>
References: <cover.1790606188.git.andrea.porta@suse.com>
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
index 0000000000000..be020583fd0ba
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
2.35.3


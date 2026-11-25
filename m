Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623658;
	b=39jaR0qx2yeqfcHJ+rA0d+mmepfnMg5Qmjn//rCA1dmQXebHItx41Ii9WlJcck8U56UB
	 M+99rSUpC4oeAPKc2zFdNrQrSvVVrhmTXJLd5GRsdFDsKmN6nAe4fBGpm3SkNS8D2Hhcz
	 stfCjkiKwKl9E5gj+94FDv0Jxz4wb69jzFwLW1X7PYLxkoYV2o3xyJy2cCMiuD3PfZFrs
	 Q5DmLqvq7et1wlI0A6zyoXU81jk8b+AXFHkZsvwnBPWXiXH+SoGHxq4Gj5DEuVHmFlboF
	 zELeC1COlBAMRfSZtjmFdyche42vAoxxOF+yX1jJw9AuNW9v4IdTVTnFXBmflynOrXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
	b=E76HfZt5Tvsg6g+uylvqjCmIjzfDbXwvmTDFuF0IVyLFEOXeH6gtQ1nm2ljFSYtUr2Vg
	 rnzyf8HnRbMWS5tK4qRKBIdHgKlhmZGYttxrIRZZSqoCwvn4PhYfBKOIaK8k/4vzn24f5
	 NFQ4oWhzt1CIQup3/qOdmdR0X40SdVUZ/tH9wJY5ZJ5DfasgGoKZKVQxGrifEG+cgE9Cu
	 HppswiyTSdw2Es3yJ4nTQb5qpIvETN2xZoWDwyz2JgZP8STgt9dGQpo84ohF2+7mX41A0
	 9rkbrSKoF06urydJfoVnYGWfVqUB+IBJhPzNoPeHPsbfx/zuQCYfVQUpM1kyitw9Quw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OBXIaj7E;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06869606A6A8
	for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 16:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06869606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OBXIaj7E
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491971ac844so5385965f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795623656; x=1796228456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
        b=OBXIaj7E1HmGWo9JqM9tqua3DNXDb8TFTkplpSggBDuhUhjA3PjuQqAh3VS9LOr/V7
         6soddrf7dewKxXTzQGhzqshKPUfy0pCHiYnR9hQRMNFFXJA+WQtkId771Bj8BT7vmh7L
         CdMqnmCJ/KTXoCYC4v0nGDUUeVRLyW/a9jIRAcLwHKJjS0uHVeg21VOqrbQ+RnkJvNiy
         U7o6ebtUYeNot2iP143VpKd9aFrme9o+rpvSqeuk1DnoEr/fQum299YO//4YxxLlvgFl
         IfFgz5WArV2/xWf/P+mGycorCWHhayDZCEK9AfEw3doma3Xoh8RAFTE+ttKGc9To5Wrf
         7xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623656; x=1796228456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH2MTB0Ze17g97ePs4wlPxbOQN12XIysjRotJSq3KWU=;
        b=Ifrzvwbr3UcguVPqHubh0XDvOxsVvGTwTehUIbfR+Kc7w7xn3kTuZCik8O7FNW6Z5C
         IhI72B55BO1r4hUYZ/AnEBPBbKK4vkNPP91wRm+pIkxag8GAx2QkdMre6HryBLVxLssG
         leTeVR3B6/6yLAYAgREE/f38ldPvGCNInsVdb7G4uNQhFqC02LRmdYCaFQIjX1I2Sgip
         K7VGefrUb210IzBHCpXEmnRDL52HawfswI4wCRD2VTc4JBxRwFGUgV3JVri5wn8lHfTx
         ZHrs9fxMyKjAP0e3eTk9Lc/mzdZLPx8uXndEklU3UEjqzWOcnwvJaJCoe/gXf8OX1E+1
         uhBA==
X-Forwarded-Encrypted: i=1; AL+hErHYsEZ7IMottpmckKSEVDnNVziToL9DNmKQcEXre8smFUiktvoCLpwIVG6DI7xgEJBZDSgRuKsAaeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3hWdK1Qlfoky//dU33CKrfXx4DOTEIalwR2uh33RY2yTAo2w/
	hxt/CnazPHaEDWh8Yf6Nw4vuceizvdhCP0wdsRtRvJ5MuZky0mbG7JOm9n++6C0Fj2I=
X-Gm-Gg: AZFdTZep0YLOP0dpc8D7V5G4oymDVM7MhpQRf7vjucTvrR3MWUrpvwmpwm5sArpm5fb
	F7TEjL9sriRs1fDn5mZN6MmFQ9kh3HvEhQD31lGwGxMOtWdKk76mZ5w1xK7e2Q7SLPRaE6af3+H
	pdYZpSyuu3ETSBHOeUDmKT4wIGz0VqZ3ZEz2srK/8xaZJZhVSMPS3wig/Yz0qM475UgCOo3MyuA
	QvKC48Twqhy1MaJOkWHMcHJEfF0hdSu0pWmNvWVz4A9tq30QwvxHWHIpid8hpIvrpz+ATpBnh/w
	aF6cBLJsHWGkEJhtdeXhW83IKk+9OonpfCiAMWAIUGjRl5WtklOJ3ItR9h2T/8jFlePbprIffbl
	YfGOFQOl7l7sXfjuXd0ATrIMnIc/tkBUuMzaVonQmqj5S/QV4ZlA3Qk9QsHsbk02MTUteR7WYa0
	RGEevM1aw0mlbEK/aPQuNWwSMQ+4aanwCJRrQtyKyTZ45GJB5843NrBasQSMNHvYbXdsQ26Oymr
	rpdJ3YZ8QMFzIoWXF0iLuonCW11BEIj4v+dotyhasT+e6WiG9ktL9ctrfKiht47v940ue+QX9ZO
	i2elWS+fLbUwlfkXIikJZZYa3PgFeFGGYtuqAltYlhDoEtoNnA==
X-Received: by 2002:a05:6000:2b8e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-4abb3f158c5mr24317570f8f.44.1795623656351;
        Wed, 25 Nov 2026 08:20:56 -0800 (PST)
Received: from localhost ([195.94.148.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm40286290f8f.24.2026.11.25.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:20:56 -0800 (PST)
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
Subject: [PATCH v14 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Wed, 25 Nov 2026 17:24:50 +0100
Message-ID: <20261125162453.23573-2-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261125162453.23573-1-andrea.porta@suse.com>
References: <20261125162453.23573-1-andrea.porta@suse.com>
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


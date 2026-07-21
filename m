Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898E403B00
	for <linux-pwm@vger.kernel.org>; Tue, 21 Jul 2026 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615003; cv=none; b=g/8qpYC4OaU25j3o8+mcWeTqW7wlRqU+zA/dH1KeEGqoHNomF5eJ9vOhBgo4jH/SmYoKS0P+ySrHvwoj2qmGKiLP+hYQN6sNkuOsDiTUSENdG8bfEC2Qos8w2k65/XJZAHNf/416DbDXYHZY50tBs2UiPMBy3fkggC1kYU1jak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615003; c=relaxed/simple;
	bh=10R457NwGTvH71mGj5Kfmru+y69/XctIcBwhK8pKzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6MlG42V6jg7w2M1mbDKGlvLzmPHWFNg2m+b7jPORMOhUzVkaRmBH4qI/3w/sDB+cd/MvHfr+jhNkoxI9rNF3ixFX/L6bGohML1Dxqz+gPtjU5Kowh/5VIOx9GNyW+o4c+hpDXgjSew2+zZ34M+owPB2YYjr2kxWlB4H57s8opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4xaK40r; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4xaK40r"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848479c9bd5so4949614b3a.3
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784615001; x=1785219801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=J4xaK40rsVf598qNfqhcMlW1vGo0W0dQzBTWioE/s0fb3O/a/of34JAH436fSnht9D
         i/EGmSq6xEvjxwMOIO+wXRWaMvtB6rngzmv3BjFxEkGFfUuYs+JrUl+yeHuLRVGKSsoU
         IsXD00f4q/YcLKF5tExFT+pxd2Eoiezds97TDuhpqdlvQ6BQzPBTBhQmf24Y6iDPykog
         kpuMX6TD7AMxAUkw8oUmCjeorCyYs9tcPeoRmm6WuNs24dtmrnioiOWKD1bIhZvd5eYT
         pePRDfBtmP+qvKXTOtWI0uiJn2speAVPDtyrjCVkS2Vd+rlXiiLck21sA8McL0dqRN0Q
         T+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615001; x=1785219801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=K/ggF8uOlVDOBbiazYoTU6d3B5pR+sG3xJcY/nTxhZwfe8cRx2b9ImZx9jvnrd7Yr4
         6OEcFAVKj4PUePTqeClxtvYxKLRnZUlREJiNxqL+KDfQ8rM6NmrhV3lI/ecwmHeENAlp
         eLHJTcGJVjD05KUg5WgjHUMA66DitU8eI4+OU9LhpiYt0+9veXRb/5dorwEp7awMasJQ
         8dNnWpX59DEOp23nDHpppnxxaT9xg1e6DJk1OSuRlVUx07yceYUczRw+GobGEad/1D05
         NaKIkhff8IXIk3yYbTzpEhIFnQ+PqYmERV9EnUdpXLnCzBceXX3Gz/1lpzg+7Bf49k7Z
         SFWA==
X-Forwarded-Encrypted: i=1; AHgh+RoiuIMZ0cW9t+fRtowYKTHcb2JO+WmokhHz08uBUjvbgKGAPKoHXrXjCwMDo+/Fhy6GZ9eqAsjTaew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAAcv4Tyt6AXxI84CISX9vim9UyNamT4cb/lKa7MFk+nnMjhy
	qH3htOX1WtkQUE8LgiOUyRPnf38d4ZDkSmDZ9DJXqqWmS1CHr1XZtc3o
X-Gm-Gg: AR+sD128/EaWVIIlPOvy/VwM6cbCDfhEhffU1c0QZAPOs7ii4eGamAcgNZ5BAjSXCbZ
	91XK80TJUQ54QAe4jaUf7xRi5J2XjIkfSC2Cp9tEhR8GiSyJKkWvdqK4KLuZgJysiUnlVPA3uQ8
	9a8BBmf+EIpxkgVof85W1AffBah9EM4MPTeuOVSnWymzPh/9e1i6laB8kaYwvDtltoD4ZgXRua/
	8wryeC+5QTdEErfD1TmMhvYw4YrXg+B1eOnEKZqf1mXmguPS/hxYuFOozf6y1xStpre+g2lSoLJ
	a/Wp3b7I2jATKIRGmNAmBEpsrEbi0P356yvOuHPoHExfYobZ1BuWEbXpYaQE0ywYusATYdesVdz
	7VKNSEIXvBPn+NTJPrSWrgSs6zlPxiKkPdL3A2yB8LIIeSOQGpMFYMwKqVtdFuekaNHnWlTNp/P
	ml9bgzp/IIotcMJjh335i9wud/iTurwrg1V9PNnLhIN+40lGuDcrUkwv/SRtFu3mUz
X-Received: by 2002:aa7:8890:0:b0:848:68cb:5c74 with SMTP id d2e1a72fcca58-84c294970c0mr16543173b3a.60.1784615001381;
        Mon, 20 Jul 2026 23:23:21 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c4b640050sm4020710b3a.45.2026.07.20.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:23:20 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
Date: Tue, 21 Jul 2026 14:23:07 +0800
Message-Id: <20260721062308.536947-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260721062308.536947-1-cwweng.linux@gmail.com>
References: <20260721062308.536947-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add device tree binding for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels and uses one register
region and one functional clock. The binding uses the standard PWM binding
with three PWM cells.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..47a59bdd14d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PWM controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pwm
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0x40580000 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <3>;
+    };
-- 
2.25.1


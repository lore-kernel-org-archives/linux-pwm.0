Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955790;
	b=3I/P0UrrWSWq6fbU68wxGIsHvLXx2p3Z7rv3cwWb+ld26v2LbKXmSsONmTxglMoE9p8d
	 i2PqI1mt0ZQRK7rMXToxaRpevHEvvkecR8hq6TMR+oAFDTL1IeEK7WCpIoLt4pde5+D9X
	 7gacjbaWmou/oEvQEDFnTBXcTU6TmWWz0FeuAKPOtgZkBpQqzUP2kugw9ohqcj7kC34NO
	 o7GU2aFM/jjYbAmQjJ1M85pTDum9AatA8TKdaswvaVf8oukxIZVck+LgNopnONWjrTefk
	 CSQpEMmzBab7lNSLqLQloL8pMy5CgrZ+cEbVPpuY5pyNh7k7j4qu7R4ZBeCcnURA8VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7DeFc9otasxZEGZwFUzRH8RX2baoMN1ocp4U5Fzi2nY=;
	b=xXUCEaCD5rqvyXkpVFpjE/EoxGjjcBIwybi+UhrxC/m1nMoa4gr5d+jgH1OsQLfIPJrQ
	 /g87rB6UfBbdvbQLCuz1TsS+6vU1uA7/yBJSMeYnLnTVLqB4aO5SFMJIkEQkXQUdxAsJI
	 /hEO7c7GBmPZgD+txSdNHk99qYR1FHMdozRIQVN4Mlnr/DF2K0ZoDUPyro+9d1tn50luL
	 Q36wf3Bo39C72C0SP3dHXuuVW3RZBu4dn0/TmhgpysCaqJIVH11YdlfgF4tI38OYNyI6W
	 RkFKBz3QNBjYzL8ilSAXnj7z2Hbn6MSxZqRKbtalNiHhJPsWM/7c2q7Zh7NgIjkt6wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oh7valtr;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB25606A325
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 19:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB25606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oh7valtr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b042c0759so1331761f8f.2
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955787; x=1793560587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DeFc9otasxZEGZwFUzRH8RX2baoMN1ocp4U5Fzi2nY=;
        b=oh7valtrkmKMdQvevEIpsbvmUYS2B86kxe5EKnfOszdH2bZ5JD/mQJdXd09w1JLvB1
         Qt1vbg3Ag8vO2VyqUOg8spaLE9Nqrc+6dCGWuHUVb4MXjPWuoAJRqu25eCTysrd0lbdA
         0NMw6g6MsvCMwt3BnY8Uua8CgnqlLA8TlLqL5jiY0Vk+Z94uq0caKIoBaVdRsfHK/xo/
         E64RojtF55nfs9sE+8L7z3dxtzKnjbMkinWa9wtWlJ+r2gvs+NVqTmQ7mrozV5b/3cZ6
         xIjZwiYjoAs4ZgGnwDpSG1hhuXxplXaeMIimJHEVDVT2tp1G71EcmMTTLBU1NF1GlkWW
         ecCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792955787; x=1793560587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DeFc9otasxZEGZwFUzRH8RX2baoMN1ocp4U5Fzi2nY=;
        b=LEw63Bk48JPgnL+xgwq//2gjqV0qSOTXIjRIAep4WU05Gk2AbtLOb1YgXss5i3NO1q
         iMsO3Eq4PJ/oy1bI7r2Y2bBRL1a7AuuXcrjbwiutF9p/F95kjQcYRgNweYr336P3gQ2T
         CYmOdtx0aOAbd38Cb0YnGT7XcDl02z/thgPQ1cVLQP04r1ULen+f2XTmlfQdhcjdxYem
         2U+0slnqde1tHtLOlwGl1mhhSV1ZtUbGwcp/ntNWXeRKi9tXRCoODEmG2W72GGGROPrV
         1PDXCQsfnTBF9e05kKSWnl+kS6tUBNc2aMEjadVzoeIfXNDc1LuYANUvq6+0yNMnybsv
         mKoQ==
X-Forwarded-Encrypted: i=1; AKwUvByAtQUzUqAJVzrVk6jknBjfYtOm93xSB8ZEE/H3YhhFxv/uzDal3aaxfY3d4xpV9cavziT6OtE+wdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6+Isf3lVTIlbeLAfXXvLh/Xqosi8hScsFX6UR1YkjRM/Jg/rT
	FoN5k9gNPo5tWvlpO/ll8G/2996sdxxs3Qb2iwyWBGKQRu7lIEsZeudGZ4wDLCzOC/8=
X-Gm-Gg: AYBFou0R4kNyuHRFoRC+7D8QMyttx5O1tehOZ/jFZHnLkM/fmFgmxVibusCDAPnDBYo
	S4ct4K+tHjqjFhIYJoaOJ4aqsReubqy4O+rfKeOxdtfJu65FA7KUoq4KIvmdhL4htez0fqKzxvn
	Q3V4uq1EZ73iCl8azR3bhpXqdX6MQia0WUwdj+GRUmj+FLVFohuZFHlChwLZlDrlsllVwoGex9h
	U+/tUnOQkpmZUNu81jtsOyn5mQtmqvWmXt65UAthjTWt4oCK7ZDu+zGnKUAd2/DKZ1485+78ZKs
	lGAOsZxs0XMF12JuBzJu6ZRudOFLboV9ws4pNpS6fzSOYOVmcIDGpFop/o0WcHVQ19s8iYlng0T
	d2RvVqlKPkjv6eMWKw0LmLG3Yz0g05ZS48Q98eETO64HFCMZwId1QgI64xuSHs1QCmvraHBSs3s
	5/RWS5/5yClzdbr7usYKWs8VGwC+lyyflz3P4/dQb4xz8mah69HbqU4dDEIEsnPJLVNorABvEAy
	8pFtXuL3LevAUFiO8dALHOel1WL1sVDsH8tgN3xtJYjodus4iZZrv9XKdBF3NuLag3nVJEfmfe/
	Ev8sRirv7pvE0OZlodAfBUbYZTZvQu+bJNg=
X-Received: by 2002:adf:ff81:0:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e3eb9e34amr6121463f8f.40.1792955786568;
        Sun, 25 Oct 2026 12:16:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm10082051f8f.13.2026.10.25.12.16.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 12:16:26 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: pwm: Add the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 20:16:23 +0100
Message-ID: <20261025191624.9219-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025191624.9219-1-olivier@mgcrea.io>
References: <20261025191624.9219-1-olivier@mgcrea.io>
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
2.39.5


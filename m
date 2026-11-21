Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244388;
	b=aWnWGaSuu/G6xv4UUo1HQWM0iJTtn1I1DIt4R3GdTkW+VZLKwQH+5Ma8Tc2U4EX/lbpK
	 PxMuJq5nsyi2apg2v2E+fcZXabTh2HB+l1dYeSFT4Yiga7ielL+pEQ3/z31JaKrbQrkAU
	 RPeDYjTHLz+XOY2zqvMtVsXsgM6Zdc1xQr6pO1I56kwO9M6qMP2csd4BToDEA6vDhsfDA
	 gzy7Q9W5bjPIXUGLIYC/g3JiTayKA4dmoOhQsKoW17Fi+sj4ZgndtGaqAhbAwZwkrMrF7
	 eCXt69fNpBRDsmPh+n0rGpxsh0OEgP0RQ2zeiBP9uVA8PnG7cSq/ti7anzqD/USR12Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244388;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Koju0qPt9fKMm+7kXLbrbiJyDSbVhbvXFb4WSB8Qbzo=;
	b=Khjn/OaPOEG9YuIx2UNXgQ/TTETA8g2YLkG/lE7qF92ar98asCxUdQzRkja2ZsSNxZQC
	 isSjZQvMdOm9rALMOOAQ60TrZNFTOhK9wshFOEkXXKB09SuKC7fvBHcID7DAuJ1DlF+ma
	 ake0jX2VioKJuZjMYxesUH6q2M4tNFs4LTIH81OYttwM6tPsDSkN6ozB4XKw8GHjvpUvS
	 cDMVGb64CAufxquweJ1aXOA7LLwu1UnDArdcOrofDjYjXoohzDIuZkbIiRvSQhwXiezVz
	 eFP3o87Kuv+vsGAZr1qQdwKILvz4nJt9A5dEwl4gQqOpcGAHXgbCDvs3YslHQluqgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="zPl8okH/";
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F301606A68C;
	Sat, 21 Nov 2026 06:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F301606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zPl8okH/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795244385; bh=Koju0qPt9fKMm+7kXLbrbiJyDSbVhbvXFb4WSB8Qbzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zPl8okH/oAVkc9qMRpg/okJocQnd6ocQI4OosZTK18lAkPAKyKfMzY1ciUIffKDjo
	 AuEmcbnP/gtbPcsDgwiseBotmaXGEDj2Lq3tYTlXdX16W69KSbo4/yLjZJiuni4zdA
	 IkE6DKYq72uRmMqLhtL/jtcbUTyduBDy4itpO2vU=
Received: from jerry-PC.lan ([2408:8249:5f:7101:71a:8713:56b4:5043])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id EE72042D; Sat, 21 Nov 2026 14:59:39 +0800
X-QQ-mid: xmsmtpt1795244380txnqd759c
Message-ID: <tencent_85AFCE164FAAD1CCAB95DC7CD804CA9BB309@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLgVnKCHPq4TJRX9EGGXwmMozjcwxP0/j/7DG/gqsvD5K21JBK3a
	 pap9y5kXKDQy7seYcvGsFgUJKk1DxkZSglfl/2+pgNil0T/IFcer25XcOKmyZqghmJr2VlVbUWSj
	 hzVqxCgInKWKB+KYqhfqJ1ExYVIQeQBUkmXBTrtSuTH2BuRyu0ERshoQW44ZvOUrR8eqlnSQk6dE
	 YNBC8+mWoaJJF7Wux/M5pAigMZEM2CcRpJrCZON5F8bXaqWwCyXrwN2sE3ynEqBYI21kGgf7qoRP
	 87qO5F+Ya5lGSfy9HhWyScgfgB7ZQxenWjB0BkHjR4hgUVjVaprLTyG8dp8nDEYxfXQcPSowl7iZ
	 VHy0V3HBxe45q/sp7i2mnA/3K4fdBCmICirzEdDLddhC6a7oiJT8RGX1WYKsw4de59IO70OzN3JF
	 EsSv+CvUT/0rlm7FBXJGbAXnQaAucUR82VgR5Aw6HNXHEsUgA0nI4oemzwmmA33vJ8OuVr3zX3XG
	 xHeMhkERAYno020BnWbyCm6/O6lvZ7sVD/Ah3cVvitSJCtUafnmVWeZmCY1SUecmiAyHeZBhEW53
	 RLGZCtRoSquZG+ysxORMus63SNP40vxdFhSTYWCJZ3RRGaK7lS5ZiELd2dP/Zzt0fEJaxoz849gM
	 aJ26Fvvkbr6+OBdbNzplLVzaZp9o/tJ1z+h5C5dEtwPZQI7i6pupHjmNV3vsFBeZUzfZMs7kPjtZ
	 TvGngM4SRn7hwZViRi+GPi/GrY1A9XhqyQj6euPULV09ioOhVzhKNEPBMAaO/j+pvspqk6CSrJ2q
	 a3GgLxwA7E9on6IoWMCzhvdHVVKpMaAGyoUx+a+mHaU9/e0u/s9Lk3je3ppNXJV14fpiGj5oVDCg
	 Pc18T294Go0wmNlDyx9Oum7zdtCX7iJOyHyOlvGVwezz+0VEhsIKRn12ordIQLiT9gLOzXV+WuC2
	 ZK/P/DrfgeXUD66cp2B6BDRf5rjsyBOnIvhONy0bUSirI+8QwliYS+pEa2dCz5jkGyc1D5Oh5vVB
	 oaqukonOep/jm0blWOxo8SJVlAZRN2HIjUVkP1aTiwmUUmpoFxZfdrcGAb+7UzFwwgdnSHybvFjd
	 qPgeaHy1OXx4EUROf9lHpUq0TYVQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: ZhuXiangyu <1194781887@qq.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	ZhuXiangyu <1194781887@qq.com>
Subject: [PATCH 2/2] dt-bindings: pwm: rockchip: add RK3506 and RK3576 PWM
Date: Sat, 21 Nov 2026 14:59:36 +0800
X-OQ-MSGID: <20261121065936.1125919-2-1194781887@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121065936.1125919-1-1194781887@qq.com>
References: <20261121065936.1125919-1-1194781887@qq.com>
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

Document the PWM v4 controllers found on RK3506 and RK3576. They use
the pwm/pclk clocks and may additionally provide the osc and rc
clocks used by the extended features.

Signed-off-by: ZhuXiangyu <1194781887@qq.com>
---
 .../devicetree/bindings/pwm/pwm-rockchip.yaml | 54 +++++++++++++++----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index c8cdfb72..ea6622d9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -15,6 +15,8 @@ properties:
       - const: rockchip,rk2928-pwm
       - const: rockchip,rk3288-pwm
       - const: rockchip,rk3328-pwm
+      - const: rockchip,rk3506-pwm
+      - const: rockchip,rk3576-pwm
       - const: rockchip,vop-pwm
       - items:
           - const: rockchip,rk3036-pwm
@@ -42,10 +44,16 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
-    maxItems: 2
+    minItems: 1
+    maxItems: 4
+    items:
+      - const: pwm
+      - const: pclk
+      - const: osc
+      - const: rc
 
   "#pwm-cells":
     enum: [2, 3]
@@ -66,25 +74,50 @@ allOf:
           contains:
             enum:
               - rockchip,rk3328-pwm
+              - rockchip,rk3506-pwm
+              - rockchip,rk3576-pwm
               - rockchip,rv1108-pwm
 
     then:
       properties:
         clocks:
-          items:
-            - description: Used to derive the functional clock for the device.
-            - description: Used as the APB bus clock.
+          minItems: 2
 
         clock-names:
-          items:
-            - const: pwm
-            - const: pclk
+          minItems: 2
 
       required:
         - clocks
         - clock-names
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3328-pwm
+              - rockchip,rv1108-pwm
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - rockchip,rk3328-pwm
+                - rockchip,rk3506-pwm
+                - rockchip,rk3576-pwm
+                - rockchip,rv1108-pwm
+
+    then:
       properties:
         clocks:
           maxItems: 1
@@ -92,6 +125,9 @@ allOf:
             Used both to derive the functional clock
             for the device and as the bus clock.
 
+        clock-names:
+          maxItems: 1
+
       required:
         - clocks
 
-- 
2.47.3


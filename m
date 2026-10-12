Received: from sonic312-20.consmr.mail.bf2.yahoo.com (sonic312-20.consmr.mail.bf2.yahoo.com [74.6.128.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500834F24E
	for <linux-pwm@vger.kernel.org>; Mon, 12 Oct 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815720; cv=none; b=tgC3aGf7WHtmbQgfkp/IFjKu1GGUu46eJ3Q4LEkGmnetSv7gIJAtQw49+RkhwQfCxf+t+4kYQJDwsrG5WFBBARHQQDpbNBtCTDDd8OISS3EtpjpzE0iFF5KGw/mhFinnf83gtYR9qBGkhkTjFTR4MMsSWMRXyMEDViOrEl1KJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815720; c=relaxed/simple;
	bh=HT0TXwWMj17JblcErkt+7GOKgaMKNsDosmRrGsBJ9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=TUhnxy6qfW195kldUDVeOFeODwRGn04LzEcpQ7FSYBhaqLunfhxqAF+Wvy5W0+xkINIch7WlVe/CKT+ldVV7dCQLt+hcpVNJfRAOUvIJ+p5ttselBjzgOIg87yhGS7wMa9fbFRlJMQlfLuHUBkNOZyKvDKTB6Q7EQSWwT0KdpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Z7KymzdG; arc=none smtp.client-ip=74.6.128.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z7KymzdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791815717; bh=gCX/LDnnjg5pxVmTukcGyCAsVe2HawPgkJZ36yq3vhg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Z7KymzdG8KvYG7S4l3/AzowST9r2NaEwQTNBxRJwaalobMj8JRfBhauUFK6AWaOXFJTy9UR3amOjPZTna/yHyRu8qxsOeKq2wX+4YVVPtNCZFTZFIytKPj20wpqIcoTOv0wNr0KBd/I9bUHdKki4DF+w4K0gPsDRYfVt8bSgJmI/RagE5dkKG91OCMvzegQlQ/V3lVZyIdD8qSqfqq481Ovy6piQ9sINQaxWlT5LbUDSMjZQYEbsuDwjRpJLjqKQ7lO+v8uUE6/AZPNdkowXiLOGrraU1nfXwcs9Cu+5jhBDeZRgoRIkcDUhmUAIbWD6V6nNA1pWuonpG+BUTZzXNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791815717; bh=bLOSqy8zc1kOfhnhldTNaYRcIxIpy02mqZb3g1t91ba=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nT17jFn9IVPxrzwZKgi6vwi4ajysPeGRu3swEPwNxh0SbYmMts8xXzxNE1hpAhBYTGs5Z+hGNpUYnCHRlUA3SlPBfbhN5ZjBAOuZ1ldvwMXppp2Me/elbI9Pba8xuNY4tRklOVftBXiNQc0JwVWuow9OkMl5JMF2PsvpnPz0PorQasCF6auS3VlWEiBfDG8orJyDa7gyxziMqBL3FVw5cwWnKW3KMQjj3aTBy4G/t79Tfxw8DttZVbHAL2EaoT+2yvRUZYZNxnsk/JJIC/DLxuuiSgXTNZpMW7EokR9j4F7PuuZuwciRo+AOWE0K/+HN8SNciqySsmIIfLKUuCm8cQ==
X-YMail-OSG: NxPO.JEVM1nxbMNGZsNTEOTe_tePn1QUt9gZWGGt.H16ot3ff0hIVTQzeYDCDX6
 G98firEUddHRSRBc1lr4dBxXHg49_n1M9y5ZkmKQ7ocWwn1J4tZLJaeS.57YOKwIZ1bhD71CPTiz
 OgPp.qwFPBeJG7hYRdVxO53RdcxpOTDUehzjYrpeybRCVMV.kU7plH7PkpuiwaxSC9BRT_wjzBzH
 LL.uHQdaYHaPtylnX1gHlcu0TFoMF3cyVFiR40jb6FuP8060Pey0hFvwzVoFT3K8OElAeW_DX5u3
 rwegjz1F.hGCMHs05NsZpDFgcJPYcXTCaAMBmNghaVstBjDtt2XZ2RB73c2Tle0ldp_VxeHcYb76
 yka2.BmeRCmj0jXpHbkVT_sWWf..wnga4gQoZLLPMs6P2afiCgtoK2.sSu2CqNE76p5hLxNtks8e
 _nLrqftROY3_TNGqGG64lzvxFoyXIDr0Y_4VLF0q3RLoUx01ztMpklAWARxPkgIUrVcT6ATGK.hg
 Iv_19XLieWUl72WhKERTWCwzPkPzDyyH2kJNJgjg0jl.SyfZeuOx79TAVWCWrvYOoz1Lb2uHKGsU
 TR4_8n4Dt70xVpbwMx7X9POITMbz6H5WjacYprahm5mPk0mF28dSZqeH2DEuZP8LDbH13SPOp78h
 iS3FsCBNp5Q82WRcQ1NTqrh1QJAp7RWQZfXL4sJpb3UzCS3IMmz0Vml3stB8aE640OwYU3zQfilW
 9EOjDrCvFDXaxtuNvn8QlHkmJ6szVjjkX535xaE77mzarovUky8XNf1TJ1dSHuK36QMfkvrJL1Yc
 jieSg4LVrWmhtd.1tR833xI1C1VIRUQUWeeuB9N8IvCvxjHlcEqcsO2XNqV9n_QmC68zVDBcbGwQ
 qokb0dylHM5ViIz3bOY1thAWedHsf.iFDTcVdHUCceKZ8pFejAMwaIGm3bhFyi7JaS2j2sZXQHvY
 5VW2pBbqkj5jFpNa.yZdpq1uuSdH9MUJ0zgckpAvkSZgO93mzkCFM0LMuSIaRGM_iRKhhohfN6AW
 NZoDTDLwWndkf_JhHCQItTEU7JPvbpcs3fPzMh.gM_dWMrkaEoErwV41EGZaOv84jtlHM2aP5tzq
 fzSAdIXgHMVFuAMtJ61SUNYm6UWOHx0sGNev7bEHGEjxoyFU2Wxe1._v8G_gfTh.tIlaYN2IHvXe
 YPo.V8U61KPnsMuVL.Lygbxk_Ql.D4hahZ16A0TEZV1rxhcC2bDC0XhDMQzufgyysjQauPuFLEM0
 N3BUBggDANrugJKHF50rttMmzZ8AfcyqY_rERJn_lNmdD9QQrWvFrqdlCeoRur1kX_zJmckDHaVJ
 kN3DsAfbroHvp18MDaEiW4ZyxoyPwPaxQLmZUC7t4RMdpJgMN156brbm0Gdgfv0p3RClX2QPHx1.
 llEdTfNVVZO_tobLUsY_iUma.x6hy.mg0dJVd__XW._5AZBzxdvrP8gmbDf6p_g7vVpsVve1.tXz
 fQbnbmLG8qZ6yJEsdlbHbwobRAobeY.oMFtpPu69AVi_cpZTUK4B1mHznoACEjE2e5ST1hqpFLP3
 ByuUxi3i8sdZQBXLQ9n0ypNrQCavlltg.h2ogfFITZPfC3AoQVUFBPcVxaGcWYAKwNCJZtWAd0CQ
 EpYFkuaEidxCYCzMRXlI_p3_EhUAPu7RlEJpLh1zVzst_k7VM7bY6DCSuuz4Zd47Rg4TVWmBD5Lk
 lDsw3z0O.xEp3JadhWRtywguHIdeiunys_vmHEZIXZzF2O5oixXQ3hj_wXpRQeoikABRtNgO8GNv
 BDsnn9kochW_C9vg0iHcfQ2tuDD.a83G7SqzqvMEW3g96kPqx42P1JCQ0cbTHTptmFHFWLfWzki7
 QId2t1ZA8UDF3vDN5DV3EbqPA6bzWlcMLYtYk1.t1LvnWREEjhWIl5bfqwUS6OfG86y1sLO6Chdn
 S99FWag_lYdvkuKEoEQd9HhsPmrYMBuR4BXNbq5NOeY_CDFbe0csDv900G.6FDLBwwys1GfyEIju
 wbHNuTpKaqMMKsmJqJXQ7RXkbf7eZ_7K03WX5Aeh.XF9xtTYABJMfPVstknSlpK6iOpobdyqPpGj
 t_pmXOyyQpuDvQex8w13HY8Li.IcCtt2VDSAp45agmbYGM6Mh0oGPMq.9GK61v1CKfPei8X2y1PG
 kBUOK1.XVnKTW4FkT.0ESkNn7tWXXMjQjMS2N14_Ka0G3eXSnbSE3jWIx4DixYaezI6TN0fZJKmE
 .AgeZ5jwv_6mfyRry6Q9NKJ6l8KtaGtKiCs81M1_29ic-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 305669ed-14c4-4448-b4ec-cdc985f800df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Mon, 12 Oct 2026 14:35:17 +0000
Received: by hermes--production-bf1-6d6877594b-clgz5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e251438cb2097fb36b325920ed61dcc7;
          Mon, 12 Oct 2026 14:03:59 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Dean Clifton <deaner92@yahoo.com>
Subject: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller to DT schema
Date: Mon, 12 Oct 2026 14:03:46 +0000
Message-ID: <20261012140346.3065-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261012140346.3065-1-deaner92.ref@yahoo.com>

Convert the NXP PCA9685 PWM controller binding to DT schema format.

Changes from the text binding:

Document the 'reg' property and make it required. It was missing
from the text binding, although the example used it and the device
cannot work without the I2C address.

Rename the example node to the generic 'pwm', as required by
pwm.yaml.

Describe both cells of the PWM specifier, and state that 'invert'
and 'open-drain' apply to all outputs, as per the datasheet (INVRT
and OUTDRV bits in MODE2).

Assisted-by: LLM
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---
Changes in v3:
- Full name in From, Signed-off-by and maintainers. (Jeremy Dean 
  Clifton)
v2:
https://lore.kernel.org/all/0aabb9f2-a144-4267-b67e-a0972d228f2a@yahoo.com/
though the storage width was widened.
- Use the same name in 'maintainers' as in the Signed-off-by. 

v1:
https://lore.kernel.org/all/20261006033518.34332-1-deaner92@yahoo.com/

The schema and commit message were drafted with AI assistant.
I verified each property against the driver source, the
PCA9685 datasheet and the binding. Passes make dt_binding_check.

 .../bindings/pwm/nxp,pca9685-pwm.txt          | 27 --------
 .../bindings/pwm/nxp,pca9685-pwm.yaml         | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
deleted file mode 100644
index f21b55c95738..000000000000
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-NXP PCA9685 16-channel 12-bit PWM LED controller
-================================================
-
-Required properties:
-  - compatible: "nxp,pca9685-pwm"
-  - #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
-    the cells format.
-    The index 16 is the ALLCALL channel, that sets all PWM channels at the same
-    time.
-
-Optional properties:
-  - invert (bool): boolean to enable inverted logic
-  - open-drain (bool): boolean to configure outputs with open-drain structure;
-		       if omitted use totem-pole structure
-
-Example:
-
-For LEDs that are directly connected to the PCA, the following setting is
-applicable:
-
-pca: pca@41 {
-	compatible = "nxp,pca9685-pwm";
-	#pwm-cells = <2>;
-	reg = <0x41>;
-	invert;
-	open-drain;
-};
diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.yaml
new file mode 100644
index 000000000000..04d2ddd8f108
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,pca9685-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCA9685 16-channel 12-bit PWM LED controller
+
+maintainers:
+  - Jeremy Dean Clifton <deaner92@yahoo.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: nxp,pca9685-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+    description:
+      The first cell is the PWM channel index, from 0 to 15, or 16 for the
+      ALLCALL channel, which sets all PWM channels at the same time. The
+      second cell is the PWM period in nanoseconds.
+
+  invert:
+    type: boolean
+    description:
+      Invert the logic state of all outputs (INVRT bit in the MODE2
+      register). The setting applies to the whole chip, not to individual
+      channels, and is typically used when the outputs drive an external
+      driver stage.
+
+  open-drain:
+    type: boolean
+    description:
+      Configure all outputs with an open-drain structure (OUTDRV bit in the
+      MODE2 register). If omitted, the outputs use a totem-pole structure.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pwm@41 {
+            compatible = "nxp,pca9685-pwm";
+            reg = <0x41>;
+            #pwm-cells = <2>;
+            invert;
+            open-drain;
+        };
+    };

base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
-- 
2.43.0


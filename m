Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2236654F
	for <linux-pwm@vger.kernel.org>; Fri,  9 Oct 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582412; cv=none; b=rzKos/dJfhYqzz36xU6ZyIhbIiAlQduI5EIInQJcdd5UtpXajpoxDjCzDLOpqYQdvXZT2zcub89tRf3TLw7rmbtPz0id7CmPFFLobQARQpnlChhabSj2eWE0DYXU717DHHqgXGHR1o7rcdqGoplpNQOP5QW8JY1Ev1Cg0IM6ZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582412; c=relaxed/simple;
	bh=0ex8Sz5fobxXflXiE26sr9k+PG9iBqZjzi6hZN8XHg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Q4TjFpyCfz2EquzuATkXqfE2r2aq0oqZV19eMTR/jDN+MQk8QKPpemM1srHz/qsicmH3sEhB+2aOlFjzzRqXsY4CosS9Vyh+9bH/QD5sRRxfhO91LnkhdmrMJsu6C6lzZlXfCc2cHQVXI9lgX9ibrRb5wG3de0APlNisrb2jn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ALHIagYW; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ALHIagYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791582409; bh=qHgSxkdnVQlY19v7EQbRAz+8I29njKHZVqqI/RHgg1I=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ALHIagYWkXqzrqPmasIyRhIHEhpsEVOVhjMEPp4kjsRZ+kNG+zX2WPiWHyGGrX5ga1miuP/GPK543A8pnkWyF+/x51SIk1gJCqPn372mCMW7M7/xfKC2NIp3EsWi5rhs16DxLlqfOFSlSJ0+sXkFRZYkEd11IQGMLdT2eYP+C0uzJfom5neYZnsoCXTCbHz2Zogav+QXxiGCHTJ2Dn8WZHXWRdDRN3mIEBMstjIT1APhVIIjVCCwUXJOlFrVEAbFfTillRgWrjlIPNXujFPeEqSE1gHL9qe3ySOlJiDgx46bCQxMR4cUuj873D7IhlqBRYWJHHB4TqoZWIotFj83YA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791582409; bh=PLImmO45UcMzbETqDoH9n7qiXRBdYW95fxP7AMGvr87=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jj7uAWGL8CLK5RP8U8VbTHIPMKUYQ+VY1h0ayaJi34oVPqKYXItzDFf2qAV5s4SeaaLwDOehWfqevYpvFr/CyiHmXUQ7aM5cjpdDx2lzVdlOk1fOqJsBDeeua9Qahe/1oMpeGnsxnxfS6d7wezsiclqE6WwiHoABBk8xuhHrw6TeL4dXVP+13iGp6KPjv12BKl0loLf4yDwGNxPvt6r6UryQf6VJBSOsU0TfJmO82CF+U6Msdo42h15P9ZffX6/X7qp2ie9uJMDzOwDYH3Iw6Ho0fL1Qz6erRel+0KFEZDBWmSPfiP0dkocmKfO4popp5wqm5hFmFTaq+BFWcNGXHA==
X-YMail-OSG: HdACYQoVM1lJLtcHSfLxnpElQvH_U9.e7Fx71SDV2HcUDJtfyoDap3nvDDtQd5b
 n7.0MosL7f0peZblJeHSgMDZvUh5wRU7c5J15pkCCPtpB8CTewp8rPx8Wq4YuMOCiKSNrA0fyWyL
 G60338NwM5cDdC6J.xGPROT7fBNBTQrei8WwMtLvcbSDHhqcUwHj6ab1hXVVUsora8H.CuRCMSUf
 FbF1WglpAR5M2i5SOzz3TKW2a9YMw38QETWBK6yXz4H8NvjavQHFKEs5puH_DO1Ro_URKTyDlrnv
 BrnBtwh_88DPknNhOLbVSSCQOsv14MR3oN2I9LWJOZb8BpqWZHPuDbSrBaBMYC2LCCjgYxi8SJyH
 VbQuI15nJ0Vq4g5ef0VuZ9YBXH302XN2gGUajBnXHL90vFR86tRVQve2_4EdEzxEUL0EH0Svqict
 r_aeiHzRzv8_HIBXX8yelUeOotVzW1wt0HW6_I5M5eE8boOULbMqmwlXqEjia2aVPinWva05x9sE
 bCn6uC3KaVMQSP4HFTtqCIyA6vPeb_pVvl_VZSMXKzzF9xNZ.2tFGEfueD0KAy_E3NaquUQXyDI9
 3Om8Rfdap4.qC1GkhTWXMAskO56W9WczImH1T.y1at3GwNzVZlqb4WHsQudIzgg8PScIFOodF8DB
 pv1WB9K_2jNcO1VrkKjNV3J0B5mLP9XJ5FtmJyT9R_aJdpzOV0yH8MjqP4tkLAM8oGHxkNQye4RC
 UbJr442fg_6kdFq_XGH1tTeJltmpHvaz9bZnEtl5CGhjPgH9J7stVIe9gX1jbMkPiE4KrdoJVDxs
 iTuZm8QO20ranTHwT1t1RfLvAFVaSq2sN39aYX2qaLxWzjXH8JdmEPp5QUNNRaxhpHjsl5Bjsbpv
 NO1QDBJkztZtGtgjCJTbRLQ8i04qzpKW3Wugx2.cTi9ySlGBTQfA1NB5C.PjiZcmgUmqtI0fPSGH
 T0SpF4_eUKK6Gk8HIK5a_95OQeRf75Ra7aBkq7sDL1hMIB.GDKo.vTh1SDU13GFsiJCmgOAxhxQP
 zweGvVuy_33PGEzUShUBUjz_zJj.yB_2TT2vLsLO5kv.l5ytOBXxtTDBHIpA4ZCZp1GpqGgHnZyH
 yC9U9Q_2k5oq2f2Lmk_PGnrR5fPbbSbrLjpB2N.037XTHh0zsOynBuV_p929ISBrsEy9mcWDMrLJ
 s9Jph6Epzj.6CAmoUKev3btCGemyDSBVpMISRDI1zABXZ1cZf8KYF_HFpSvssL6cqsYLFmP2hIY2
 jsbjSLtvBdFSDKobpfaFd0G7SmpS5PmbRJExJtxL0I4VGRfQ5MfBaXfwBBBkuTOz9brMNc_Z6BT.
 _EWtNXacZ3L.LxzSIPmIaXwQPUURg.2BQQd8vTWDd.fDGFL2jnwh2rdFxF.IO1PigVj46d7wV7_z
 zdbhg12x3p3xnEz4ySCTR8RSKPfHBc5K_NufC1ykWZD4vi9fKuEevQ4Di7ntTmqpTFVBj8g.fyIG
 GC7_LgMo9gaatkdDhqmRocSGEsJ4chPH0r59b.pwZrGnMW77eXuUuWsjc3TFWYqQjj3_4puZRWau
 q9JQ.JWL5rDvf5D3YllL8I3Qfp2ezT3T2szBf3xjDmGybExCP2gHnKSIwEdw0REE68SQrSrtlc2i
 Z1Wp7LGwEmbk2YnK.JEAEfbwiwxmF8CKIf2dh.Yowu21jzDA0aW0LN1OTblf4XwX.bSXBVujp5AD
 G6VuXyjO24YOqnr00UucKuc.OTzPWobkpdXwlx7JBvLdMd7qUawCmMfyDPospbfImGAeQTi4RRLe
 cFaZ_3zrMa3GWKpE58VAhKw5A.R7jrroHfasK0pL5ynw6T3kNXhtaf.Cdi9QXO3.ZQs0mJCmUe3J
 Wm_UrqIRWzZMrPFNjh4qdplE1CVbdSEixi67REVvO2a6Wpy_Q3WQeFxaZ2js9DQN5CQmmMrmpj0x
 kevBTH7w8YIneLFrpU6V1O72OIIHoP2ssXWULPTJkTm91h3q8s.cvICXPqPxANbLyolTA4koOtf7
 7EOx5mWjBgIJoOUc6lfd7JCNcJHLNYeN.IzV23nZsLTIdeGGvIKgHVDbOImNfLPz6cJZ4HJPWrf7
 .CE70l.WNmZ7hbxqwihIwx1lztdmoV1L7qDncC_3Zg5w2Nsa3xsEnP4Aluav89YK7RYKOmEL3mQ2
 2ku.9J47HTqqkGHpvvQRKRpovVesNnq3RwddcLGWw.2UwN2ukCH43LP9Rgd1kQpdOoTDCpDGV3jS
 wzQ5_JudibCABHq86P4hgA_Hjmew5C0DS.Tf4xQ--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 47e50a12-97c2-4c6c-bcb9-ab6b9499186a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 9 Oct 2026 21:46:49 +0000
Received: by hermes--production-bf1-6d6877594b-r7rdv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 89dc1a489e21d216279610b62058c333;
          Fri, 09 Oct 2026 21:15:31 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Dean <deaner92@yahoo.com>
Subject: [PATCH v2] dt-bindings: pwm: Convert NXP PCA9685 PWM controller to DT schema
Date: Fri,  9 Oct 2026 21:15:23 +0000
Message-ID: <20261009211523.56122-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261009211523.56122-1-deaner92.ref@yahoo.com>

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
Signed-off-by: Jeremy Dean <deaner92@yahoo.com>
---
Changes in v2:
- Use the same name in 'maintainers' as in the Signed-off-by. 

v1: https://lore.kernel.org/all/20261006033518.34332-1-deaner92@yahoo.com/

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
index 000000000000..40d82a2437b4
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
+  - Jeremy Dean <deaner92@yahoo.com>
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


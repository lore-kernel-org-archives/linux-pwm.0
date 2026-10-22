Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.129.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627246;
	b=KjtggUUw6XtP0JuVH9vKQxPd0CVbchburTzidntS/V7Yom6YDR8R6q/yxUUFYVWyR2+r
	 NW48iIkffSHB6xaXcHNt4LtpzD/iJlBJnMvtZ2me5xH+lr0Ai1JtGk/fISfdwIQ9Si99u
	 xUjXytJ+QY0Adw47xlp7Kzgruy2UyZdfNqqxOZmUaEyYzhlNtei6fjamRG7YeawfJA7jK
	 8nuNS/oJZZNd/XzmLnBtgxjzOhe2yAJYeZJIgU1i44XrjOZxawNX3xR3P3Q7VMCU9IyX4
	 6JZ4hnFleUOTAgHIM5hc+tIuU1SoLUMwv2joB9zlw96H3hOO9UaB8SEiKgsbcj3HMfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627246;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 References;
	bh=druPvQMWSEwX5b8Wb6p1csxuRLy9IK+eHcT2X1I1yfM=;
	b=L2Z7uoQnGPBSHtEBijjGs72fUUBBOc+rim63CldtadrnaXq2MLrFZJqHo70qzkEku/VW
	 hifL/DnNxY6NkOLpnzTdl+37Xy6bR+wSl1288aB3BdVLc2SJaVlf+v+zQtEty2OS0MzSz
	 IdltfipUQz02tK2pkAqi9yIbX9icFMs5pHkSbxR1V5cQtUb9yfXWP5OQOndsglr7aM1Y6
	 EqJWikcpx0jGYcdLolXiXkEMC+/rHk/cRSt4HmpnfqU8oKwLjceG4pRSQL+P9w3KyouUn
	 iwEjYMswfaOLkYLe9ww2z4AI2xfFyJhTjPeZlKPkyxAdYJgVtVx0iXmjbdjYtxR5rtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VMebvADs;
	arc=none smtp.remote-ip=74.6.129.40
Received: from sonic301-1.consmr.mail.bf2.yahoo.com (sonic301-1.consmr.mail.bf2.yahoo.com [74.6.129.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D98606A335
	for <linux-pwm@vger.kernel.org>; Thu, 22 Oct 2026 00:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D98606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VMebvADs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792627244; bh=druPvQMWSEwX5b8Wb6p1csxuRLy9IK+eHcT2X1I1yfM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=VMebvADsY+fxA2EEGqi+t33HjuUafNeDG07G2ephR07Yw9IL+svnB6EYUzObRY4mFQHXEtoIlEGkyAdhkaHLzS6o9rN2OUp/Syxf0NRB1YrfLSzK7Ke4wWP5NeGq7uLupgt62Us+XErVU1ODArct9baiNrOwGL6OuFhV0wwu3bupu3yVQ2FN5rm3PwZGWg+1Fd++Cqxiu1LOgYlRYxA+D4Z6j9gqUcqfRvjsoMoF9YRW3b7iQOab9IUDsGksUiMNc7AhdCd9vAXiIILoJTs8bN3kh3cxjehHgRIOc4Y9zw5rBeO//JIfChm169nFS1oTnwUxslWeJwcNqyFdM+VQZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792627244; bh=gCVDNBxNxiyObti9oZoeitmApgHtlHkTPJ/LClGgnaI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OzKgTaWm1CDgiz7sAozzOxmmhEzEzE4Uq2dFYFYeyUk8WMVsax6Dt4GmZw5PNUvytO7xGWcHg1IzwrrfhNgbYlBOWnNzOm4JS62LxENwlwsZYG+PpyLZ+C8YJlUIU1aNoQAAJSu6kDCG3fO2fLkE9IPi+bfmcJ+iuoSNkoCJXtKlzqVTXrLFN8DLZPCFCFx0qwGjTmQfF883Mk2DlIMuoV6ukZKGoOHWOrUiXm+C7oEcicPmymyZYQHhts9YJA48/P6H/1m4IB9ZRv/UiMQm8cZOGoTrEkK88KcsNQdW60Um/WvRJ3yAR7ZTC6Z9W3YjcCm/s4hITMfBcWPAE0xhLQ==
X-YMail-OSG: 3s8FuNcVM1kSD0x5ae.6miMlXMElNDiQ3se_ISwJKbIQw7dM0h.Z3RbtTukAho_
 L2RRLppyZtkvq5xwjLZHXL.291ETaDtOYTjsteldRY2vwyVQoK3zhY8SAzk16EbrmwBd0E4o.OAt
 4Zgyv1EyPIhnK3BzIU5uSr6CAom_Sc5oxXxGyjQ5wvW6OtjCj6I8_qz2BvqtOVXkwsfsgbsH4Aq_
 Uv.jSM4w3Vtt3TXQvq6Xoc3nXcDZY6N6dGyCRRcwYRDFb_mPeSgEiWEmya4ZdEEKMZHT8A9qW3_W
 .TcqMKgYMdBUIhPhza3n5z5rmrUK2khdDJcYiV5k6xchkxRbi98AdORgHcwCTXn2h1lcREX5EfE8
 xOkfdsQw8tVhLzU3TuVeLvf6PsxR5CKmxqw1xm3uJoJbX_IYGXt7p84NbMpwy6kK2oGsoCu03yxP
 e7GhxVgtDYbFD7X0DiUx0hIP1dqHzIETOGOsUUsOIww1kWbgORRUh4p0tC.oS1T61ckuBPQ.9XIp
 UofoZfhldQlRW0RI68C8XcGxPwH7JIeCgLikxte.B8wb_x3dUj5Z3U3SXNkmDK.zgFo_p3taS4DB
 XBU5POxRoeCE7BvqXWlXbxzsH0YIEq4GrXKzp9bi0mLV.gH7Jyjyn4I58UK6wjsCji4FGmHeloIh
 FkbLVNZs0dsP5.tYQLwc9K_BbaA40H4IV6sMlEGijIfE11_lNvxL.vIj0DTOxi7sFxpNU6T.iXCi
 ak9W.65jH4Hyc0EaxFkd7kMDMlzMsBifspAVyalht_IRFeeJf5VeTxOKAzS.eeYohIiOb9tQDf2v
 73pd0c8in5VwRyX9exiWthfCDuaCHe5O5nyBJgjsj.zRxrYbihCGe0WjciQ95HLmz3vYbsUBdnw8
 EkEZHRmRXD43sqIzLHfKWtasJQ5B_TCFLOusANxRvNnEnzNbVkPTMj3ivmdwad8vaeND_IQOw9CB
 b9.e80bkxpFLnbeY7HmwjksEqX8SSauZLTqXT5aoWbYjNYyFD7iEPQ_jOaUTpuNWaJnd.GSeqh5r
 1HS6ndJChZx8muUYLlgQ8f3.b5S3LwZy_Ju3dugsGrMey.Ua6_Ho02u4mtGnydDC7Oowil9ahTKs
 Ew8HzN4nY0noAANYdK4SoyoXxgrrqR0H.3dcnuAzA3unkJF.KKyTrrx3gQvzdJ8IRyxrJMAa_nzP
 ApuxXPPNluGmDOwWYvoExnZtrqFt9SBP2LkGJ6.HiE1O6eiLWXjhIWM3J_dy4xGX4QIO.qDWQgoO
 LvNnAnF4306S7d0QNTeSN5lkfg.OFgZSpAe2dElByVykdOxI3smhItkAM9hQm.HLpDgDxqBayiND
 AmO75eexyN7mdoMJUVqWfAUrUbHC_izqGx_WntUTufm2Rc8FdxV_GPp7xUzyTtwOX9txeH0bk_hg
 1GDs_O7DZMYT0_zDpjZFOSGVm_lGrSTRAbgirU3E9.7l8u6iCjwm3dg_JrxAopDlqEJczqM.Eg2S
 6EK0l4lVxoFiQHUXItS38OIBbJ7_5SicK9V9zoEbGCAJEjCRqR9JVUCAHPx_zzXX0CYbzK2ODIUE
 OSWSn2Je6GRIF7T9P285DOjlotKUScKrIHT0tAzyvhSuF904ZO5t.pP98wR3zAqDfLVwSvlneTC6
 ApqVmURiqnJYLtcWS9SzHRPpN6LLMhk3iT3xhu6fJfg.qy7lR0PYdkvnJOsQmcHPgHMiG2Foyqq8
 gzKIe4aLkLAC5.VoelqU28FCwrxl9qwn3ee3_YwuJKP1HKUrzmT2VtPjy217ba0ARJ2H_g_DsdVs
 TIIBWDI4H0CZ9.H4bfPmTkPFMDXWApps9SzdxkICQCglgELD8w8nZEk6G35Im5F_jv_QGpkLGlQG
 nho2nKT75ugqVficfz1XEfXcscJ4qpSTUnj.ENO7LIECz3aP6U1iqhdAAP0MGD_PkwEwyNg9YUsX
 xo.mm0aRl8MGCQHYKDuAJefv0ReQflyLwJ71eaM4zfg8fac5MWhAyecckR5OdEcNh1c_BFRHzjl5
 H_hnmXavp_dkR88mj2kvYJ2T0pTpb1Xl_KudLeY_6IMt6Pq_7QYREpABJIWBlg2nacJYdCK9D8as
 _o9NFZGaVMINqGkBujl6ftDKg2M.G.I_ZWgaZUFExRQDqxq8KfLw9xKe4NfNePqgDxvW.j2Zt5s5
 38Qsitgv8e.VjGxD7y.ojgvOPBoFx3elZbP6v9fF7ftt6IJi_6ZU.ujdQ_Om6jIyyixlI3SMuBCE
 _4WVukgbQ.7QqZBvNLlFKIf8xdjQ_0j1i.j.ivZAeirhOe0D.ELAdBf4UWkFNjgKdg3Vic0_P
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 7a71e304-921a-4213-bafc-1a598fb0340a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 22 Oct 2026 00:00:44 +0000
Received: by hermes--production-bf1-6d6877594b-7nfrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aade7a6eefc81e54893ba8797da94197;
          Thu, 22 Oct 2026 00:00:39 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Dean Clifton <deaner92@yahoo.com>
Subject: [PATCH v4] dt-bindings: pwm: Convert NXP PCA9685 PWM controller to DT schema
Date: Thu, 22 Oct 2026 00:00:28 +0000
Message-ID: <20261022000029.125691-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20261022000029.125691-1-deaner92.ref@yahoo.com>

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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---
Changes in v4:
- List Uwe Kleine-König as maintainer instead of me, as he requested:
  https://lore.kernel.org/all/athTVpsanlK9_mVJ@monoceros/
- Add Rob's Reviewed-by.
- Rebase onto next-20261021.
- Drop the Assisted-by tag, which checkpatch no longer accepts in this
  form; the AI assistance is disclosed below.

v3: https://lore.kernel.org/all/20261012140346.3065-1-deaner92@yahoo.com/
v2: https://lore.kernel.org/all/20261009211523.56122-1-deaner92@yahoo.com/
v1: https://lore.kernel.org/all/20261006033518.34332-1-deaner92@yahoo.com/

The schema and commit message were drafted with an AI assistant.
I verified each property against the driver source and the
PCA9685 datasheet, and the binding passes make dt_binding_check.

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
index 000000000000..4c60f4260922
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
+  - Uwe Kleine-König <ukleinek@kernel.org>
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

base-commit: 9a482184d910775cf648863148944945b74e2815
-- 
2.43.0


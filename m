Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300313;
	b=vH3ErvP+hUje/ynOJR/iweWj0g7GdeuDHquRG7W4SsdTu926zfQ9FsaNXGkbnqrbG+kK
	 1DlqZ4vlY+umP0PCKtYeBlNF0+N50TSY8quWRZTZfO90GUymFs/s0UmayUWGMX2jnePpZ
	 I53svZWpjxZIEpOb7qjxAW/gbaAaDM3KlH0qocX06mZo6WAvmb0cvVupPHe+NGDf66M9j
	 I1MX+XQyQY4uv/S7DdRWXdOTJqCKYHKkgciuKjhzxGCInMlBPOTa+Eg7MdhJdoThLl+K3
	 97yOkiPiX9nmG/y+XuurGYh8qBqfHBRsCw3XWxE/5xY3UtuotAwUgPUjVBxoeuZGCuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=M+wiJCV1x+v0QDGzccqhRocm82FSe8QlrnpPbyiwKCc=;
	b=ZJk7YzyXvb9PlTYfFBuUyqYuJ3rQmwKah6uiJFwGRMk0kUx+hGp+67LfvDKHABTF+Q/p
	 rmPPDp8EQ6efJNn01zqjZm8+g1nuhYHmMIZqaDN8kxr7aNxJXPx99UGOpK09YCOHRT1OO
	 uFLDfjAs9wkxAT26HAHKBqGoJ08dsUVGarrDsrhFPzQ1tZ790YkLUt5R45TR1Yk1xDPWH
	 bkdXN7BTOJxSh6aNl2jlb21dZ7wSImtSdWKzwlsalInGl6pstiTcbbNQyd35KCJCuXNbG
	 7RRA0Ju09O9vMxUPr4V2Ephc+dYrCrkcGRAHAprvHwiojOXsZZXKBFC3wYpJxTzRHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VXzQ5glI;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E26660A2611
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 18:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E26660A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VXzQ5glI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso21813975e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300311; x=1793905111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+wiJCV1x+v0QDGzccqhRocm82FSe8QlrnpPbyiwKCc=;
        b=VXzQ5glI2g226G8b5VF+cTmQTh/85ZGlxiS7ucb5EfghgRH6byHCQ2JFXewEOMGGkR
         xvB2Xk83WOrI/yEk7ie0ofB1myI3FzH8Try9ktOLhQcQohcgPLgreNYYh0cVQ3l9i09y
         LHsvB/oX99fwEIHBzlcEUrsj+T8t4B5csE8JT9JRhYawCD3fmZWODODuErpndfSral2W
         wjcmDLd3yPkBqYp3cGzSqRneAyIVzfVJqc8doXb1I7nJ6UGXAWJNFA6ca32TEWMqQkDo
         YnOEitvHqiNWPh6XM5+jSasZFUQwWaz6TB+KuRLRSrXHA+rVn5RfP3htjNbuAUACpvx1
         n9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300311; x=1793905111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+wiJCV1x+v0QDGzccqhRocm82FSe8QlrnpPbyiwKCc=;
        b=t5d6EQt/oOwOpNuLfXEPOnUcVu6C4+62iCkOobdsja88+X4Pmt+okdF+VCHe48sjcU
         7CPrswBh5PQyEE1LtKbRjkl7MG020EPQVCU4cp5RdQ+b+uKQC676bshB2PNXDqIl4gSM
         FDVfaxLGcvLmN2kvzjBYd71rTJ77WBHN7MIRUnUm8HLvA1LtdaLEwg7FOYbNfssVxLG/
         Y6LlZqCIXrlLhPaiDX4ExeSuddaNT7VB+7IrhfTFG9JAtMvZ0vX5AXXUfiu+fNFRvu43
         5GKPcxn20sC9jD0TJKPyqbr6+0c+p74e5giqkb6TWpR6X1RGqJOYCh2G3PjXQM2fHv+y
         1xRA==
X-Gm-Message-State: AFq9FYLEQaxJ16Rd4LOTryO0qh9KvPPWlDghKxRq7QUHPQ5bg5m7NSZY
	kw1JHzbyVh5NDnfPJrBxs/sWo5byztWlRhf4+nhxMXjEDRY9DJyRMgPtJkeTag==
X-Gm-Gg: AYBFou3nT5m+TqRWW9mJ3JKvcubhe+jw9qZEW+M+kU+umi5iyBHjiIwFD3ppRAU8R6T
	uEA7ZXhcPUBefpGswKSjhG6wZMVUSNKXjIGZ7G4BLaOByQyPUa9a9U0pBJc7KwAVGOxKchJGbtI
	FImOTjev9SwYeJL0RTLqZYpWIrDh4bzl3Vt23lGg0QwytoZ+JuS7t0TDjcphLJ4AVyo0aEEwplW
	Xi02YJCWUWV8F5F7laLFNDexBc9d9iNMyEzXOEbH7N3hC1nkD2NSgSBe59zE8uavtSoPCdFS2pw
	j7M3qCjqqU9f2YgA4dCBbnFAteBgXPyTdOedj8tEie/mhU6vQqzqGATzh7FvSravFbjWzBtRCF0
	buas9lo3U3tpPMCVg6wWDkyj9kVBpPq+3AF1HswLsfU0OAzkDnTPBTuWKGefq+OZ/wjEubh6fwY
	HHsqmtFLuDvlkF/v8c8a4lvp6HdtC83QDexUZa0EJU4XJSI8rOieLnynW8nn11TcL1RGMb/CNJs
	4TBDPBtyxVUKLhvxdn0Fz+q/1+ICwPlGdBKm/XuvZtO1/mPmtD5tYtftF41eVgO5Gdd2D+hqSLL
	WJqD699+kGKBJyokyQZ1nKzjvpJHNjngYuNApCYTsdwmqn+M6z4vH1Z3HYcKBgoQfg==
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4a96720213bmr149370545e9.28.1793300311428;
        Thu, 29 Oct 2026 11:58:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:eafc:6fb2:6c68:5ae0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm94291535e9.10.2026.10.29.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:31 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 29 Oct 2026 18:58:27 +0000
Subject: [PATCH v9 6/7] dt-bindings: pwm: Document RZ/G3E GPT support
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-gpt_rzg3e-v9-6-f3a5520388d3@bp.renesas.com>
References: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
In-Reply-To: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793300303; l=16225;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=ajKn7hvIy5GiG/SotjMvlQ2ODed/m6ZTDXrq3AaLMew=;
 b=QBLtRgtkCczzdIXH7F3K2GamCvorbbju+PdWS5tLABxBwS/PSPzlp39kRJA41YCeCrwo5c4bd
 R3dizUDNpNpBSnC5yDdRKhLW6QA08+/UwQyfTz5QyYLLExNjgG8vXJX
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
SoC.

The GPT is a 32-bit timer with 16 hardware channels (GPT0: 8 channels
and GPT1: 8 channels). The hardware supports simultaneous control of
all channels. PWM waveforms can be generated by controlling the
up-counter, downcounter, or up- and down-counter.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Updated commit description channel->channels and '8channels' to
   '8 channels'
 * Retain the tag as the change is trivial.
v7->v8:
 * No change.
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * No change.
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Rob.
v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description.
---
 .../devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml | 323 +++++++++++++++++++++
 1 file changed, 323 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
new file mode 100644
index 000000000000..cb4ffab5f47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
@@ -0,0 +1,323 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzg3e-gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E General PWM Timer (GPT)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  RZ/G3E General PWM Timer (GPT) composed of 16 channels with 32-bit
+  timer. It supports the following functions
+  * 32 bits x 16 channels.
+  * Up-counting or down-counting (saw waves) or up/down-counting
+    (triangle waves) for each counter.
+  * Clock sources independently selectable for each channel.
+  * Four I/O pins per channel.
+  * Two output compare/input capture registers per channel.
+  * For the two output compare/input capture registers of each channel,
+    four registers are provided as buffer registers and are capable of
+    operating as comparison registers when buffering is not in use.
+  * In output compare operation, buffer switching can be at crests or
+    troughs, enabling the generation of laterally asymmetric PWM waveforms.
+  * Registers for setting up frame cycles in each channel (with capability
+    for generating interrupts at overflow or underflow)
+  * Generation of dead times in PWM operation.
+  * Synchronous starting, stopping and clearing counters for arbitrary
+    channels.
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to a maximum of 8 ELC events.
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to the status of two input pins.
+  * Starting, clearing, stopping and up/down counters in response to a
+    maximum of four external triggers.
+  * Output pin disable function by detected short-circuits between output
+    pins.
+  * A/D converter start triggers can be generated.
+  * Compare match A to F event and overflow/underflow event can be output
+    to the ELC.
+  * Enables the noise filter for input capture.
+  * Logical operation between the channel output.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r9a09g047-gpt  # RZ/G3E
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+  interrupts:
+    items:
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.0
+      - description: A and B both high interrupt for channel GPT{0,1}.0
+      - description: A and B both low interrupt for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.1
+      - description: A and B both high interrupt for channel GPT{0,1}.1
+      - description: A and B both low interrupt for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.2
+      - description: A and B both high interrupt for channel GPT{0,1}.2
+      - description: A and B both low interrupt for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.3
+      - description: A and B both high interrupt for channel GPT{0,1}.3
+      - description: A and B both low interrupt for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.4
+      - description: A and B both high interrupt for channel GPT{0,1}.4
+      - description: A and B both low interrupt for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.5
+      - description: A and B both high interrupt for channel GPT{0,1}.5
+      - description: A and B both low interrupt for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.6
+      - description: A and B both high interrupt for channel GPT{0,1}.6
+      - description: A and B both low interrupt for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.7
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.7
+      - description: A and B both high interrupt for channel GPT{0,1}.7
+      - description: A and B both low interrupt for channel GPT{0,1}.7
+
+  interrupt-names:
+    items:
+      - const: gtcia0
+      - const: gtcib0
+      - const: gtcic0
+      - const: gtcid0
+      - const: gtcie0
+      - const: gtcif0
+      - const: gtcih0
+      - const: gtcil0
+      - const: gtcia1
+      - const: gtcib1
+      - const: gtcic1
+      - const: gtcid1
+      - const: gtcie1
+      - const: gtcif1
+      - const: gtcih1
+      - const: gtcil1
+      - const: gtcia2
+      - const: gtcib2
+      - const: gtcic2
+      - const: gtcid2
+      - const: gtcie2
+      - const: gtcif2
+      - const: gtcih2
+      - const: gtcil2
+      - const: gtcia3
+      - const: gtcib3
+      - const: gtcic3
+      - const: gtcid3
+      - const: gtcie3
+      - const: gtcif3
+      - const: gtcih3
+      - const: gtcil3
+      - const: gtcia4
+      - const: gtcib4
+      - const: gtcic4
+      - const: gtcid4
+      - const: gtcie4
+      - const: gtcif4
+      - const: gtcih4
+      - const: gtcil4
+      - const: gtcia5
+      - const: gtcib5
+      - const: gtcic5
+      - const: gtcid5
+      - const: gtcie5
+      - const: gtcif5
+      - const: gtcih5
+      - const: gtcil5
+      - const: gtcia6
+      - const: gtcib6
+      - const: gtcic6
+      - const: gtcid6
+      - const: gtcie6
+      - const: gtcif6
+      - const: gtcih6
+      - const: gtcil6
+      - const: gtcia7
+      - const: gtcib7
+      - const: gtcic7
+      - const: gtcid7
+      - const: gtcie7
+      - const: gtcif7
+      - const: gtcih7
+      - const: gtcil7
+
+  clocks:
+    items:
+      - description: Core clock (PCLKD)
+      - description: Bus clock (PCLKA)
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for bus clock (PCLKA/PCLKD)
+      - description: Reset for core clock (PCLKD)
+
+  reset-names:
+    items:
+      - const: rst_p
+      - const: rst_s
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwm@13010000 {
+        compatible = "renesas,r9a09g047-gpt";
+        reg = <0x13010000 0x10000>;
+        interrupts = <GIC_SPI 538 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 546 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 562 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 570 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 586 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 594 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 539 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 547 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 555 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 563 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 579 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 595 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 540 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 548 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 556 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 564 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 572 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 580 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 588 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 596 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 541 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 557 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 573 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 581 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 589 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 597 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 542 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 550 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 558 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 566 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 582 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 590 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 598 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 551 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 567 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 575 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 583 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 591 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 599 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 552 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 568 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 584 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 600 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 545 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 553 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 577 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 585 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 593 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "gtcia0", "gtcib0", "gtcic0", "gtcid0",
+                          "gtcie0", "gtcif0", "gtcih0", "gtcil0",
+                          "gtcia1", "gtcib1", "gtcic1", "gtcid1",
+                          "gtcie1", "gtcif1", "gtcih1", "gtcil1",
+                          "gtcia2", "gtcib2", "gtcic2", "gtcid2",
+                          "gtcie2", "gtcif2", "gtcih2", "gtcil2",
+                          "gtcia3", "gtcib3", "gtcic3", "gtcid3",
+                          "gtcie3", "gtcif3", "gtcih3", "gtcil3",
+                          "gtcia4", "gtcib4", "gtcic4", "gtcid4",
+                          "gtcie4", "gtcif4", "gtcih4", "gtcil4",
+                          "gtcia5", "gtcib5", "gtcic5", "gtcid5",
+                          "gtcie5", "gtcif5", "gtcih5", "gtcil5",
+                          "gtcia6", "gtcib6", "gtcic6", "gtcid6",
+                          "gtcie6", "gtcif6", "gtcih6", "gtcil6",
+                          "gtcia7", "gtcib7", "gtcic7", "gtcid7",
+                          "gtcie7", "gtcif7", "gtcih7", "gtcil7";
+        clocks = <&cpg CPG_MOD 0x31>, <&cpg CPG_MOD 0x31>;
+        clock-names = "core", "bus";
+        power-domains = <&cpg>;
+        resets = <&cpg 0x59>, <&cpg 0x5a>;
+        reset-names = "rst_p", "rst_s";
+        #pwm-cells = <3>;
+    };

-- 
2.43.0


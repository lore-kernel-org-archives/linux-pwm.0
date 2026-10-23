Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750336;
	b=I9/hUlUl+dO6RvgVUvWgiSZeniZIVsOrGLX98EYLBjwmr3mEEHMItLcwscUVfTHAbbY+
	 wb1cX4tIba7+SsOL9YaLvdB9iWGljvyIGAunaEebFxxZ80e/VhXMZxjZpeBNur9LUP2L3
	 ox4h2yCbr/LUBJfsY2hkuPd3FuSpPPGNdmV4tjV0yUTwEyKXDn/RMlJ6cclT2T99i9GrU
	 9rG1TKhWFKMOPHBVF2JsvL+dMwMYzH7mQ4vlRHn5zEjhPpq9wGaW1CR4LKAC1vEH3+EU/
	 vpyH/UhfYBSx6/bXRDtKpozoZALlF+0acZT/HDKeed1FF5iDkhsfEdFHPlo+/bqJ/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dq6GJJsBaSDY1IzgGawT/TFz8VL5osKrrjfnYgKJzYM=;
	b=vzWCJHN+Y0e4UQbTvqAj+6CHtpknRhCIdmZM+dN+5hJ+OfnsZrBWWhy+3IKZLfrTw2V2
	 a4i/pa8BUHnDAXIevsILThE/8LQFxOndpkt3N1AYbmHZlFjFCkSQJZ6xo80/BiNEhvR22
	 mBmW1ZFENRzdqciV+tRdpXPeHS/eonpfR2dRc8kJyDycWsttE036Pp1oXPQK9hp5uWVut
	 UfI+C0qME11orYHz8Vfqder5v9ndxEN1SDpxxuY631DZIxHN+TAJPikhDkN+L7jDOcCaW
	 DBrpvNHvJhbMGKQtEJ5+jiE+3h+5Owo1Va4jb+kpUinwsEFr+ugCSBjfH+D0xjVb9Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IWpQ4mhj;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79560A260B
	for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 10:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E79560A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IWpQ4mhj
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so1423505e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792750335; x=1793355135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dq6GJJsBaSDY1IzgGawT/TFz8VL5osKrrjfnYgKJzYM=;
        b=IWpQ4mhj/pj4bJh7MP/vuwmzTylNCkSm5qEGtWhOQtmmvPT5IVx9weMxPItekIw2dE
         UIuPuYiLLCs+z2+QbEPtwC739zCnY0WJBZ+1kn++bUAIqd/ljke5fS8Y9y9JS65pAUlR
         U+y3VP2jNC4yavrsbZNGYxuAZc81aXSZRRfUaj147D/RORJhI+T/G1Nz3lGvWO76/xaH
         cSUQZNVtXSQmq6ru9hXj4O3FyfGAnuTKlYWZ8IIXaFBlrVMfGUSHqGJOSkUUa2KkGS4/
         Q2DcRr90fnljjn+r1qN/pyNqmhEQ76pH1fLTCKe7Tes2yWkPX/J0Kd3prY9jBSOLwEjq
         8XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750335; x=1793355135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dq6GJJsBaSDY1IzgGawT/TFz8VL5osKrrjfnYgKJzYM=;
        b=uRNfis/Skv2AuT3Vek5htnoheu27UlgN54EFEwmQAhPJQTPn269fDW3+fqocDjgNiP
         O0UScCgnWHeBNYJzDwLdZCHNhSm7daV4Rrx2kSMeQReZfySEZGPYbkjv9CDal0ZCRqW5
         AgB+wJfI6PXt3DzRHFW3OImQhXNSLrYNB/dtJPGv1bdgr8qjQxtarxljRvmHrIt+Lm5Q
         NhRj0Ji9zamnTYe+AF2DANoFhMDNfYffqn8FH6KAx22UwCHpx4S5/Usa/xgn7ZNX9YPV
         QjAjGyLEQYjdNtoUCHlMVNo8c2USOmf4LERddjVm61I5lkK6oHfsHxi460RSr5Q7/QOa
         WCnA==
X-Forwarded-Encrypted: i=1; AKwUvBxfs2JazI5lOfy7ZQplFqPO88Ie1ZygHhYGnSKW95sGQvregA/Q8nit/abQYGwV3sJ6DIkNZcx+ceM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcbHheY7kiAdfdOkXVdaVuQ5UD8ktVVZoJnT0a2IseSgWoaVMM
	w3O6dr7G2AlR01feOBvpIfrSdG+oxP2SesL5DVb5/aRyDRVQi46V7fUEKyDS23LHfz4=
X-Gm-Gg: AYBFou0SqTijAwQo6Eg5UFr/cSzqYg5+jst5rqqjwfsm6QrXXDTqnvvhmhxTa/fvhlM
	quDQ0MI2IbezncwxB21z2f1Fsx5L+aFG8ymK6jP3V0ZKnK/2Y2Wo3QbTlNDQlGhvPItV75XlrSs
	qCxhRZUqX0taj9ODE9xT//hDLBoMB8PcudwDqgibSPnYL3QAaBoZEH+KhI3zb9AuOM8QfqyrI4K
	sx6DlbC7sL27opMCW39oUZEEpEgIRXH4naNnfv9HA95EkxG2rQZOrtaAKgsmWOBgMbs5NzfKDqc
	6GSgR9RN/BP8OEcWdUVJzy/j4I36dctnrg+m/MDEWpEMAu6HCXa5nCMXxzNmTSq1nqBhnx7uBlF
	9oarC3BOl+6NPxSdORsqd/68JrMmiKizViOi6ltxeYnTj4L2V5gvd9+IsDiiM2dGFUQRay1Q+GP
	w+mH+oJukAsZ2g7+T917Ec+qatx7XTfMr2K0HsWKk2dun88ZQ3OFK0dghF++2P3tCbXsyBxm3cF
	IRpgc9cK28qvQ4Di5p8xdqrLf1ijLC5utCu4ySlpiw1KyFXJxX9M5Y=
X-Received: by 2002:a05:600c:4fd4:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a211f3a5f5mr23914985e9.35.1792750333373;
        Fri, 23 Oct 2026 03:12:13 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b898d2sm50139165e9.4.2026.10.23.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:12:13 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RFC 2/4] dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
Date: Fri, 23 Oct 2026 12:15:55 +0200
Message-ID: <0a9a27c58336449e5a2e243b987a8bc85b05aaf8.1792748690.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1792748690.git.andrea.porta@suse.com>
References: <cover.1792748690.git.andrea.porta@suse.com>
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

The Raspberry Pi RP1 is a multi-function southbridge used on the
Raspberry Pi 5. Its internal PWM controller block includes a built-in
hardware tachometer logic, which calculates the fan RPM by measuring the
tachometer pulses. The computed RPM is updated by the internal Cortex-M
firmware into specific MMIO registers within the PWM block.

Currently, the Linux PWM subsystem lacks a standard API to report
hardware-calculated tachometer values back to consumer drivers.
To avoid abusing the standard 'pwms' property, this binding introduces
a custom property, 'raspberrypi,pwm-tachometer', to link the standalone
hwmon fan driver to the RP1 PWM controller node. This enables reading
the tachometer MMIO registers and exposing the RPM via sysfs.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
For the rationale behind this design, please see the cover letter

 .../bindings/hwmon/raspberrypi,rp1-fan.yaml   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml
new file mode 100644
index 0000000000000..53e5b67fa856b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/raspberrypi,rp1-fan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi RP1 fan tachometer
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description: |
+  Hardware monitoring driver for the fan connected to the Raspberry Pi RP1
+  southbridge. The RP1 PWM controller hardware contains a built-in tachometer
+  logic that calculates the fan RPM. This binding links the fan to the PWM
+  controller to read the tachometer values.
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-fan
+
+  raspberrypi,pwm-tachometer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the RP1 PWM controller node that contains the tachometer
+      registers for this fan.
+
+required:
+  - compatible
+  - raspberrypi,pwm-tachometer
+
+additionalProperties: false
+
+examples:
+  - |
+    fan {
+        compatible = "raspberrypi,rp1-fan";
+        raspberrypi,pwm-tachometer = <&rp1_pwm1>;
+    };
-- 
2.35.3


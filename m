Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616889;
	b=4X1FVqTcspAetpGXm6oX3hoJiS5SbTzlzy+TNfcPMIi7eM1Ip1yPr2UvmuSTWvCpsgX/
	 zaod7UF0wT+lgG1uKPqNGerVCTIQ4BPPHRrQKs/1sUc3LIzEXJwqGzDa50N+EQ2l5Cp94
	 6chibwFF1SAB9Euy8X9cN4i1w1YjIQCR1PIvr4zTic94gOeJcxTZJIiAY06AUeCbJ1kIo
	 6zkoR07SMFoGQIwpqNMk5zhtXtK+zmOLTStV8Xjwge2o/G+wv1auBIvW+pp059AWSXAlB
	 Bz5yDfK1CZGVyET+cEw3lMtsdUSWj35mOZu8Pj15nArKI91LYIOmziOlDm+EYRgeJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616889;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MAqczCNcy22o2fAo9tLhJs4HsvOqxtHZppQ1RGZ+biU=;
	b=Aci+MaqymLZgjRIYTX0MopYNkxKtua/8vE8TFs7QPNRayRdXYyDVxT8sIHE2B7lGfFcY
	 F5VPEP955CHtHTvUorQoy9PD5KZbrY4z29vfHFAg2QxQP0g3sOQKy0GopoTSqTViw5Koj
	 1tXfojJx5JhdIkwlTwBnlFb+jce236QIBqk01oyTMeYWNfZqQGfcVT/qpK4KJEsMjfR1Q
	 3JKRi/WiUO6r2NXDukYA5SFiW8vDgVvVhT4E927VInwFUDN3c740e1pyfq21zTucYL8Ke
	 yrX8+hFB9rW3ldAWRan/V79yWtwKNkba4d4mpRKEilzgDnnDkBqRfLmtgD8si0u3uxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dsg.is;
	spf=pass smtp.mailfrom=dsg.is;
	dkim=pass header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=KqDT813h;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBD606A339;
	Sat, 14 Nov 2026 00:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBBD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dsg.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsg.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=KqDT813h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dsg.is;
	s=protonmail2; t=1794616886; x=1794876086;
	bh=MAqczCNcy22o2fAo9tLhJs4HsvOqxtHZppQ1RGZ+biU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KqDT813hXsmmKzNsf273CDJGBWcCnWeeLBYbxRUUzz0r0QG/BwCExiMZaQ5hRtd/U
	 4d8pMsD4J8/7c1rw2R8LFlYFbzon1wTIkrYLam1KVm5dApyPhoMHgKhiDg2ipaGkSw
	 0GZob3UsokNRTqjLzZPZkrlRV+fcNolDFwK2K5ePqFasJkQ2q5E/faMgQcz4yPWqvZ
	 it7LlLP75QW7EKiVUYPdemT8GUFP6G0du7CsVmu46zSMjsRaM9DZNLbUj7RmxLMS4x
	 XXXWzh2no2LRxxe54w/k9kLIPp3P9As+5J6oiKUv/Qu5Uhx4j/aE4Mr8+qxq6MNNvP
	 3zSZvUznunw8w==
X-Pm-Submission-Id: 4jRFg74XvCz2ScQ9
From: =?UTF-8?q?Dav=C3=AD=C3=B0=20Steinn=20Geirsson?= <david@dsg.is>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Dav=C3=AD=C3=B0=20Steinn=20Geirsson?= <david@dsg.is>
Subject: [PATCH 1/4] dt-bindings: hwmon: adt7475: Add #thermal-sensor-cells
Date: Sat, 14 Nov 2026 00:41:07 +0000
Message-ID: <20261114004110.328050-2-david@dsg.is>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114004110.328050-1-david@dsg.is>
References: <20261114004110.328050-1-david@dsg.is>
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

The ADT7473, ADT7475, ADT7476 and ADT7490 measure two remote
temperatures and their own. Add the "#thermal-sensor-cells" property so
that thermal zones can use these as sensors. Its single cell selects the
temperature channel: 0 for Remote 1, 1 for Local and 2 for Remote 2.

Signed-off-by: Davíð Steinn Geirsson <david@dsg.is>
---
This patch was written with Claude Code, using the models Claude
Opus 5.5 and Claude Fable 5.2. They wrote the code and the initial
commit message draft, which I cleaned up. I directed the design,
reviewed the result, compared against the datasheet as far as I
could, and ran tests including on actual hardware.

 .../devicetree/bindings/hwmon/adt7475.yaml       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
index 43e9fe225870..cbd44bf6759a 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -73,6 +73,14 @@ properties:
       - 2: PWM flags 0 or PWM_POLARITY_INVERTED
       - 3: The default PWM duty cycle in nanoseconds, defaults to period.
 
+  "#thermal-sensor-cells":
+    const: 1
+    description: |
+      The cell is the temperature channel.
+      - 0: Remote 1
+      - 1: Local
+      - 2: Remote 2
+
 patternProperties:
   "^adi,bypass-attenuator-in[0-4]$":
     description: |
@@ -111,6 +119,13 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      required:
+        - "#thermal-sensor-cells"
+    then:
+      $ref: /schemas/thermal/thermal-sensor.yaml#
+
 additionalProperties: false
 
 examples:
@@ -128,6 +143,7 @@ examples:
         adi,pin10-function = "smbalert#";
         adi,pin14-function = "tach4";
         #pwm-cells = <3>;
+        #thermal-sensor-cells = <1>;
 
         /* PWMs at 22.5 kHz frequency */
         fan-0 {
-- 
2.56.0


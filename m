Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89A3D669C
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447031; cv=none; b=EQ0xDxlwsiiwvdNMlCHYMOj322zrbyO1/lNLmJSOMmieeEGe+eO1VjU6/v5N4yBQdAaO0tbuO9ILFd2p2lK5aCa2mWnnN/DbSOAjjtCfz5kd/XW4GLpTTLMpma585qsqt2VT+XePf8edEGrnbZ19UwkjVWyvtc/dTE9sY6nAfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447031; c=relaxed/simple;
	bh=kPSU8K3hloJk0CA8KkjVBFkdAjOTtZpzNvFwM4OXI18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzeDvgKr5tnrcniXZ3gX4DgsR9StJUxWrSduPAC+02vYQpzIdqp6CjGsKmhCun8hXs2xeIPL8sT2OA4J7hgYoouIhpVNOHTHr+KImfdCxznKNHe9AtyY7J+FU1U9Fvha6tb4/9tIiUJbtUiE3RVcv/a6VwUWFhYIVnjG5GSqfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtVPEDWU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtVPEDWU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so3529455ad.2
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447028; x=1786051828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJRlG/nhDfRO8KA3xYrGnvb0TOuHPcGeB7eh7wI6Y04=;
        b=mtVPEDWUCuTdz+e3LgqNxygHIqzI93ShgLoTjYwLyfwwCKdknXR4bmJWl4IpcWC4FT
         Pn9OsH2/eoz6XgEdcezCjbxlpOppi2z1mZzd8XEyHmgbEaBfFJLqDIELNdjsoKljIFlm
         FbZwBTTLpyB2KOnB9ejpSmM47gwU4XdbJLJHYWdpn0QGks8WxnBcStYCDVnb7NfEu4eF
         JCPEsJljds0rD29i4T9aWCLbG+wc3tbD4I+WcxUCaQizKWpeqfFyPTzRtjb+ejy9SFqt
         GUD2i5iB7Nzg8oODFw8gunT9xpsuJrm0CXUFGsNxXDYoHBmSuVtGW6BZedIZa5dpAtUd
         m1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447028; x=1786051828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJRlG/nhDfRO8KA3xYrGnvb0TOuHPcGeB7eh7wI6Y04=;
        b=U7b51wJ6D0sv0qkMX+vm5Wq/p+h8KbF9BUa2zw0b/j3qnmxOCXr59e+MEnyU+TJPLn
         p1/kYgcBrC5DP3oOVoNZtSs+flRfnmG1E0/VpiWJgdIeCKgT4CTpKsq8oUers+BHS8BC
         35EwLThnn8LU/VNlzAFwcD7sJjdB1frSpL7Ool0hQOyz3gVf9rotRHPuVLiO5XE4Yiqk
         pZeaC5Hv2ZabVgZpA3xwqhjNBlCOLAZOOmL7NrC+rucrwjAVqTsi85wZ+iMFmnCSSQiL
         RetD+w8jfo/URlkyrO17yISTdW96UUPdbVui6XPqqtRalLAgLNwH5+q+pbxYJlP5iR2i
         bXfw==
X-Forwarded-Encrypted: i=1; AHgh+Roy7zNdRpg7lS01MAotkqDHqpZvi3jE9oZogpMCDxQMa5NTHYZ4gNa1bHunj0Px8vRaLii8J/tG/OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc65EHG5WJvyfuq+2DTjtrB31AE/tmdVInf17A/gBVHr0jUEN7
	j+D0LU57KiaeO3O8sXoG0tuBXPDvVajOQwC9cL6q+E3WH5M9V2YnoFo5B/1jSKN1
X-Gm-Gg: AR+sD11hQcEWwSSeV3SZNj7b7QqZZIDFozvlzXCMQCwche/zFHwphErt8ydY81wFaej
	PfkoBOhnqeLy2Qy2xs49c58wycaf5havkIC1dkyfkOrmLoiMDR406zsgSmrdSScpHmpsmr+3mUC
	N72+pOzpGiZQlszSxDXjHdSxV07QLYa5SN/PF+9mQguxhkd6DPJslNz7871DYZp3osDV3HY7g/G
	ripCP9OEEU7eWr/YoITHntZYqR0rEkY76D4jrRJuj61f58gG0tbxa7NgUV8BGLUGH+kCKafu33M
	muAva97p+ldzTCIzdPXaP+Sr+SKNnsr/PGc8ZJO5oZwHrj6m3EO5/O9QnXqlqR5NF+qqOClqvYE
	tCGsB9Qlax5kdZCPpk+PrGHw0ld1lc0DtX4CSQJ+/LOs43yB+CFQGC+w3iPt7YjjkEOmqQFdC/7
	xomjktAz59erXXQ3MZyMYpUN+N1dsaHi/gvz1ycmPcq88EYxRVNW+Fmc5MdwC6QhXPgvyldEMt6
	duy
X-Received: by 2002:a17:902:ec81:b0:2ca:2073:3119 with SMTP id d9443c01a7336-2d035ce64f1mr38650655ad.32.1785447027541;
        Thu, 30 Jul 2026 14:30:27 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm28584728eec.21.2026.07.30.14.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:30:19 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 30 Jul 2026 18:29:56 -0300
Subject: [hwmon-next PATCH v5 1/4] dt-bindings: hwmon: add adi,adt7470
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-adt7470_thermalzone-v5-1-42995a6bb8c5@gmail.com>
References: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
In-Reply-To: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

The Analog Devices ADT7470 is a multichannel temperature sensor and
PWM fan controller. It supports monitoring up to 10 external
temperature sensors and controlling up to 4 fans.

Add the device tree binding documentation for it. This includes
support for the thermal framework by defining the "#thermal-sensor-cells"
property, and models the fan control lines as PWM channels by
defining the "#pwm-cells" property.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
new file mode 100644
index 000000000000..f653a06f241a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADT7470 hwmon sensor
+
+maintainers:
+  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
+
+description:
+  Multi-channel temperature monitor and PWM fan controller.
+  It supports monitoring up to 10 external temperature sensors and
+  controlling up to 4 fans. The fan control lines are modeled
+  as standard PWM channels.
+
+allOf:
+  - if:
+      required:
+        - "#thermal-sensor-cells"
+    then:
+      $ref: /schemas/thermal/thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: adi,adt7470
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Valid index values are 0 to 9, corresponding to temp1 through temp10.
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
+        hwmon@2f {
+            compatible = "adi,adt7470";
+            reg = <0x2f>;
+            #pwm-cells = <3>;
+            #thermal-sensor-cells = <1>;
+        };
+    };

-- 
2.55.0


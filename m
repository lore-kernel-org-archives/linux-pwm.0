Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5830C361
	for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208048; cv=none; b=ITTf45/4xYGh6bt9jKx9efLX31qY2It+fP1Pu+Z9CR99EnJlbhjt1ovogD1l6pPrRx7okb7rb/jV4gbFeaafAOeFo4Tpi/7xa5o0dWCyCyM1u810DVUWQezm/LiWrSINVpAN5SN4rkn1sS8iZDyc+p7dV/5CEsa2nswbMSezzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208048; c=relaxed/simple;
	bh=2Xkx9JAuHJBa2T/HnZYT+PlavJJoOnMUktYCNznAllI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXCcKMvWlzpEY23JLo4LkvtnEwolCOQuW13fAsLt6jSejElwVxAqfwUawxvhaW5bkp/HgZ39bB5rd2FSzBfvzgdCUoPWdl27w1WKuYXHCCOvbPm9t6e8lYXLsKJdoemI3kIYYIvfSCjnGLPz5TnW3hbJF3VuBhzOu7Vb3xeDMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZapjHw0L; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZapjHw0L"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso869585e0c.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208045; x=1785812845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqIK17VASkWy77WTHqz/JQwmCp+MwjwqAuZ+PhSBltc=;
        b=ZapjHw0LPC34P2HugFtgqaxU+EnvMxtHbZlivdE/kP2P3jUqtVaS0BCQzV8BT3GzKo
         S4C9w4lC+0COrZDf3kNRcditxhXS08XgBmkAHh3vTWKkz+d3Znm4wcn0nk4QbYZVXwsk
         9WWW11CWhcLovudICPZ6J7OaqmkesnEndvXI7UdNkRsCjrkq8F9hFKyEP6UcRLO38bXH
         wqEWJm82y5OHON8YBNTHOTOXW+U7yf2qzI+NFoVv3kjq5Ht1NM2R6EIWex8ThJRwVCJC
         Dex0p5fZWZQS0IQXaDVDO9JJtcmpXWx/hTAKuSCnFVUvukBFTamlcAPiXY8Vh/BRh5NJ
         65fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208045; x=1785812845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UqIK17VASkWy77WTHqz/JQwmCp+MwjwqAuZ+PhSBltc=;
        b=Fr8WQ5SiPz1GGW8QCJddDa9Q/Vs4c0NbfunW1vdPrNiwfaGj1rNSCN4kiVMxUmE5P3
         zM/5Ih2B7SRbNC7I5wRMW35eM+9w8MltVjc8tPA/ZWZUeVlvZluX/g7iFAmGPZtjkvBW
         hDmQ+fZUGsIGbRaXf3EgqPf9Z06yviSldQcyuIl8q0TkR4AMYso5WMRfHZWDRIHMUsQ1
         K4qhg5fqDBCYoE1CCnSYeMYgr9lCofclokDxvmLN1/vhpPD5Ut0GkSKQgtk53SsINNxa
         Nmvbvw++44hAjm5NYK/w1AzLKT5WYfUghP/Q8qevZa423A3pV+ygwXfsvxBj7ol2KrOy
         geYg==
X-Forwarded-Encrypted: i=1; AHgh+Rpfn4R6zksiJHhb3LovAOfWMcieUzcbdYS2qkE/cQ0M506jM03dzxiwVz8NW8rTYCIO8fzarTy8AuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCviKQWBvSncvq4BczIJeh0T+AVKEUEmEUFmDZkyJ/LT1W3inj
	Yx1i81ZVoApDqHDVMEiCQBJ/53uebY6uCGszn1Ota5ugFhTT0iK4oea6
X-Gm-Gg: AR+sD11Az+BHDCCcGxot4+2yiRR7izOyrVV3FXfeOC0YMnPA7rq8hNv0867Tnr4bVzQ
	nD7fVgsLJIwj5fDoTR7beeWw/OqpUjwLIsuYaKHccob15b4ajfGyulNM2SNUJdEZ/9kgDSkmVkh
	FjUK5nz+Byb5KVYljDoGBJBIhSzGxHyxALB4cCgAgnEUbFiKP8o6BkRUV9AX4pwfcD65rUueXZW
	RR8I7b7AzI/ueLHvxBU5EfVt5WMpgCUgsl6lIKomHFhmottNuELwsRJC9qL0krHYmTBUp2hOUro
	mgLPO1bEEERTq+Kw5bIAG55gy+scqX2RUpNp+cF7QoUDM0t4+MGNNwrA6FYm/bbmtueBttpAwcr
	4rbNMg/ZpEN7+9z3eb5dmlF+CcmT1IFmlZuuHcs/A4l2eVR5wtBCLwDW43mvN4waGmpQcsskcYM
	9F8FGEhCLwqCThSN53lg==
X-Received: by 2002:a05:6122:310b:b0:5c2:acd2:5b43 with SMTP id 71dfb90a1353d-5c33f86f6dcmr233593e0c.1.1785208045509;
        Mon, 27 Jul 2026 20:07:25 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c305759d35sm8148812e0c.18.2026.07.27.20.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:07:24 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 28 Jul 2026 00:07:09 -0300
Subject: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
In-Reply-To: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
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
 .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
new file mode 100644
index 000000000000..bb2375a4a490
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
@@ -0,0 +1,55 @@
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
+  controlling up to four fans. The fan control lines are modeled
+  as standard PWM channels.
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
+    description:
+      See Documentation/devicetree/bindings/pwm/pwm.yaml for the
+      generic PWM binding description.
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the temperature sensors.
+      Valid index values are 0 to 9, corresponding to temp1 through temp10.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
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


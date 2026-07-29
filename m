Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660F30D3FA
	for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300399; cv=none; b=fbmM9HY203hktrhKkYc2nfu3uYwG6mPM74NP9cFzptxM/HjWWcWQTljKk95H0FmSmZ664tPrGoX6780RxLoLVNKLFZ5pymQxpS02pQuK1GisBqhlrGu3qgrXhkBeMaaQOkfPWyGOnL2QskGq2nIIJqchhBWeWmp17PpxVwSfaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300399; c=relaxed/simple;
	bh=11Bn+MrkIAOgkwrRbb2qpLu8l/EytirIMnmCjvMjRYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxjNosaXja2lu/TGudTLmQ4zqCDo5hDtuwLdqTu88vxDJUbIk4oW/OWVKAf/Yvzr66WjcSEpmxHW9rMGOKjgOnrmQoRhaummEjfBqcag/PdR6+IMpcxsKrw3vN0PZDfh6mtjNJVDgbcD4BQDWDvQrrh33x7qg3OAwZeMyFdhCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmCX6Q08; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmCX6Q08"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e7109321dso311105a91.3
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785300398; x=1785905198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzPNV24PItXqemQdsd0JvPXqyRjBFLfEI8T1ngUt8+o=;
        b=kmCX6Q08irPGzFC75g9SBqgOX/yDfoVadzMO+5Sq7sAm3CTURx/4kJFT8MgAOacgh7
         /7VMOt43MvnxRVn1mxgQKZMvLoWv3NpS66Dkrqmux6uvWgczZJPMEQ503AsTgKiR1EII
         QRr+22aN5cwaVQ1zIs46o3rBbd7gLc1vPcAInVd5w+UGyY1RXhkdR2VJpnwT0+fyYPMP
         zduJY9x/OtZMZ7WU7qtCPM8TejcevDqHG8+JtSv3NIy/umLJNUaoz8ZoO0xJ1G2wtgkq
         SAV9e1JuFJ81NiuAv15k26khD69rK25Zg+8HhSWXpodVyLHBgkbT/Vl8Wr7ZEUE6D84p
         cyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300398; x=1785905198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzPNV24PItXqemQdsd0JvPXqyRjBFLfEI8T1ngUt8+o=;
        b=F9RaYJw2L5jD4on/oh9WXAJtPTrKMAKIKpKbmy0hK1ncb3KfnkQ78zUKA0GY9J1pcG
         IHU+XdWBK1aPKNG7R/VCAibkIGbZvbFdG/+TO6gSnCBe7JTzu+DG5Ys3o9XxlQ/55Cxq
         Qli933YwvW7uKfU+yBNQEbAnQOg6tpWZdlwEQjp/HuTo+CDrpctZlLvhhnbFlzCQniJA
         6yUDhPb/G1TgBksr4/eDe+T+Iyc3RqSfUwdqFdMEVCCU9Gia0Su0WCKgwfLSwca+HQlU
         fUkU6MkyDNEAAPWkp4mINSJq12ZpSdTXh8u43GB8kN+P1tCUns3ELNP7JR6qr/CCqaJf
         MB0g==
X-Forwarded-Encrypted: i=1; AHgh+Rof2lrIS7iEGJE3wvZIh0fyF9FmBXqirx4O5gCxgky3hCyhuTW/CWsTzxxa0mde33O/9CvYZx1Hb/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4r82mut3vSUG9n9ZbWd1lkx1sCbN2MTA7xgS22h9pRAv/C5T
	v6mfDqE2Rigj52XdEowVnBZ/A0f26XdwPHa1IlpNHHvoMFA2b/a/CHfx
X-Gm-Gg: AR+sD13qcdO3LZp2QPo98hoESXah92kdHjjEmUTStjLXV2D+v61dj3GzGBeGyPXJbb5
	UzLlw9z2tfobG8yPdRbgbPUTDus3GHLsHb9OwUaSwluKEdD9PB9VU9ItswUKQ4iiDwTYmBLVmRX
	nNDbDZTf7MwhQxxnElqFr2x7H4IbA1kb1vyR7DjEB3Ol6kL6SswbwevDLd+i9BCxIADsbqQUzkK
	Z+MUbKS8xUlP7GHZQthtJ9ZPV5WPtpcnl16VNkV0Zf9S0pArFDq4b7I3KTr2ctT/LEUZoYe0zsc
	01nKeiiGjB9FWhXK/czAHVD0I4wUR8PBu5F1ahOIHHbBHoaU81pm4jN2BSEuEKakBPNJzNzd6Mx
	X2YkbAUZjk4PZq2W+rwfUPuE2EA/OuQq6nVs8/SGI38HemDfH9hxGvDoxZeyAymiw9lTlAzhMU8
	ATwVTbrEFzLuN4SA3JMy25tiINPgbzrFiepPHdoX2hDlWPdyTUcfHQkY8Ek8s5ma2mbnUaau3h0
	E1i
X-Received: by 2002:a17:90b:5150:b0:38e:21da:9257 with SMTP id 98e67ed59e1d1-38f6a447a10mr5707584a91.37.1785300397876;
        Tue, 28 Jul 2026 21:46:37 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b6d14bsm4730437eec.10.2026.07.28.21.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:46:36 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 29 Jul 2026 01:46:09 -0300
Subject: [hwmon-next PATCH v4 1/4] dt-bindings: hwmon: add adi,adt7470
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-adt7470_thermalzone-v4-1-c14039dfa0e6@gmail.com>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
In-Reply-To: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
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
index 000000000000..06881e521111
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
+  controlling up to four fans. The fan control lines are modeled
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


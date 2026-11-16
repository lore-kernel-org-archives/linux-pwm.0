Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812933;
	b=QvpP56w3KFoeWof433+/2mcNFzWQTjCM/qOauIzuz8wK0JmNkEBJTCX7c6ZYk5F+wiK8
	 j9UQhiWo7NMgYbUYAJLWnq5KSkDEmmsO1LmZPzBFsKX/0Du5O2k2XGbfxXf0XlBf77Q8P
	 woQgZO8GupuXYjnBrKZH8d2b0ymCUF/5b09l4h8LaNVpmJWHEPYxZNNpaBtSueBVMMU9i
	 NBhDfa1m4lMFZ++Qa0WDwO76XFSTuPcBWrDkSDx9e4o0UwEK7dm0KuuMWOZ3fAiljh0fQ
	 h3PtBGKaeUuuS/LX2wWU3wU8+LRW8re4m45NI5bADnk1Z4Pj5HBfxZuLKzyC1KCPHmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=o3qN5tZBkITol3f6feQbbTIZa9RormwqtNgp1Ia5x6c=;
	b=5TneUSrZjWBtn0TWR4m7J9nMTDjSHYsK2lTDpAQQ39gPLJMYNArPF1q7eHjChZ14p+t+
	 Xb25ryGKnt6G6naqtj9E2cegv1fU33N62iocRTDhCGBcaAA/cpBrbpHG7j3XPMEI2o9ZP
	 CNOkCRELfggQau+QxQtW9+x9y5y/ILtdoT1KNbZ0nqmp/rYrZATtUT7MVv6BvXWmttldd
	 7aTKMYeM0KEn5K7hHDqttt81Nidq0rirS5N0Dtw/LxpEwxmhc9/sME7MKIkBnYoGnkZlQ
	 QRgx+SHGy4+nKLm79JtmiIUEi67W5K5tYwv3/4U2bez8fttGdL+e73QWanadKBDMaEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CW033N34;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VbHZ+cnE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A420606A330
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A420606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CW033N34;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VbHZ+cnE
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5LBYP795956
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o3qN5tZBkITol3f6feQbbTIZa9RormwqtNgp1Ia5x6c=; b=CW033N34TCHMbCCq
	fb/UQF7pe68zjqe6SXKueuMXwPbNLsn9AAoGZYY46qATprEf6yu+jKVTIy1I/Qq1
	JYsgg+xMvmuMLewGruS/AQlAJCUPOhQmSbb8+jfHKjIetfsP1Nm8Z02CTMyxrEKt
	AX2wPkY8EHBO3UXmcOKlTlQczSoSSOpKXgGc25Rt8Y3FTcb848e9+1wuegGrCHJl
	GWJxLbs7z4dsRUf6ooJ44XFhDuTJ52jmKtvUW2p2zKdZp4otHqotEKEWCIBWkYLJ
	gqWTQbYvgOPBczxP8VUjhWM9HsShQrCazd9p8WK0vzML2TwXNZoO2VkuLGOW5+b9
	FHDOXg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc0y0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b15e47e57fso1874133a91.3
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 23:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794812931; x=1795417731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3qN5tZBkITol3f6feQbbTIZa9RormwqtNgp1Ia5x6c=;
        b=VbHZ+cnEX/vmXU29bkSSR8wGZKYYWfe5Yzsf/F7CXjMIVFeuiPmnZ4RyitjBoilFtA
         aouE2HRWEH0FBd8BfIl5NJzK+tg6m2SrUK7iGqk8xEUkWr0AyyBmQqdFzWZ7PZ49708f
         078fcWA5K1nKCAvDBQT4eyU7NQ0DYm4btFOQ4VafUzXuY7UeOuZ1TUjLGJ4X8AhuPW8w
         i2rLI450fBJ89BCMnF24ZXir2IOD4/mFvx9Yv69c3cY/r1vqwbH4dHbgis5DffBpMpIJ
         dPCw4dqg7sJEB6avRDEZ+SKI/FIEA7VFxjd5FWZFWugJwfvemdccsVDT8nuBP9uKSeak
         z+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812931; x=1795417731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3qN5tZBkITol3f6feQbbTIZa9RormwqtNgp1Ia5x6c=;
        b=KRrfy+rNCJd8mWKtURdWpmRLrDsXmb3gA9969jJyIJftkVjtLVYF9lsgMIoHgFlK0W
         S+80lKq4thAgFoBUMIWcNSLlbOdfUhVcKrp0wsxK0eZl/cIm9kIT59DdUhHUw/obuVPt
         1HqveucLcEHeIk9A8rKYda8N1laLxL6lk6OWAXuIZbT5MRdLnMERJldvEcSffqSJfvNX
         TpuuYlf8CNSdnVDq9os5Ji8dKsNcigeNUA2bNpdXwKBpeH94CyPLk2yGKA9yyhq20Q7W
         1CackCjpnju/41oThmNptcjAzNcWQJ63pLfoTVV2YXxNanV9R12jekKR90+Y2cmr8prw
         ww4w==
X-Forwarded-Encrypted: i=1; AL+hErEQcVeOgmjwgPf2vKLXAuRohtl629QVi/1a24mOA2LXe3kLXEqTp8/DtGyLbZNKVm8tOHVyyVH0E5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pqsnADCNH8VoiwHoHggAFwP2g446akknkboOIfyLHavnAum6G
	OIHwr7B4D9s5qnARCOAVdupQRQukHBfayuzWEtLjFgfR+Uk+reA5oTJPzFy8Q07P9X1OlPmuA6u
	2ua2p8/DpPQuPn9FSjJzU86aERx6Zrhe4mWolpdZd+gGdJUMlgEHR7hLLby3Qcr8=
X-Gm-Gg: AZFdTZei/J4bvoU4dclPk1iDh669u1rB7X8u/7h9FV2xYT6iv867yoNHCe3zuU8kq/v
	PTAWMVyjiBgci19AUn1qcZ/V8zH21zasX0CNCb3Mvd5tr9Bd/KZAJIWotKunhU5Z8pzq2eQf3oH
	xwaFTbu48tf9s8Zoj0Hw5hwEMyu8igF+7q7AYYPa5QXSUIuDV8la71KfhBFtgnmpIC2o2UuUwKq
	0LqUvTdmM05LgdQdGwAC82ZZITyInT9tZjS0gasUj2sk8KPvCe8ScbzVN5wXkmp5qQ0YKdJEYp/
	KJwbSfWuRcupYtsXNuZ8jh6pIi7P1LJhzDNu/u5fP6EGaiq3EyAA6abf3hY6JgmoeFMeM5MnjkO
	qLoe9JBLCgx2luSdn0FumUpUe9zsWX1BDus9ZRWmzkxeS3WW+fvex38xITNLMx4LFpTGku7/tGw
	==
X-Received: by 2002:a17:90b:4c05:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3b1b0a47cf5mr9564403a91.41.1794812931242;
        Sun, 15 Nov 2026 23:08:51 -0800 (PST)
X-Received: by 2002:a17:90b:4c05:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3b1b0a47cf5mr9564376a91.41.1794812930764;
        Sun, 15 Nov 2026 23:08:50 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm8658667a91.0.2026.11.15.23.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:08:50 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:29:48 +0530
Subject: [PATCH 1/3] dt-bindings: pwm: qcom: add Shikra PWM controller
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
Message-Id: <20261116-pwm_qcom_shikra-v1-1-67ee4553adc5@oss.qualcomm.com>
References: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
In-Reply-To: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX538jOgAPIRef
 1Rnr1VIkbYwMN91yTW0/lfu3VbA2mazMvHdxmOXvvTUG2Pc6t1Te4JJfk10DpApzwETYnBl9eeh
 PE521LwVNL32GiiLAy78QMoEl7f9wZQ=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afaac03 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VyN_33r0_AOcASJYCIQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: SpGFboeu24ZO7WBv_GpqxVnhv7PCxsDg
X-Proofpoint-GUID: SpGFboeu24ZO7WBv_GpqxVnhv7PCxsDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX2eMSzxfBR2Sa
 NsnqVh1eGJLkdPOoNbsVCMRjDzJk/iH0Rgqcz80wWx0V5glpbVPaj3C/8PRRP1lIejFOkiaUZy7
 cd40RZAPwNKWwEfZUcfSx+RiBJJTdHI3FUTiq+7G3VUVet4myS4kOjKMrFHNqY968m3pRwxepk/
 ShzWBmONf+GS2qd4uQRUwPBB9/SzHAR/u3kTZl7j4XweL0wy7ndiNyZSNiX/CkDd48PrgonGkw3
 ZD6awJDAoHo4AiOPjAOitGAHOvhLeFcQhWLPxxWqFaMw16mA4kvr2J2fun33NfZVFRREV5BBMb7
 O9Lu98UjRiagV0Rn5+BpF6+WGmy6hpn4DDoGpeGHCXG6GCQqBmDTnrdp25Pk69/AXkpmg56LJqP
 RvvR3i9Wj8qP+l/QNcPmUJMEP+OYJ7FFyt3s54j7GR+15GqwWhpxOsBWnbtrdFovrTc6U6+/Cr0
 MhTphxAnvdMcE9vLc3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160028

Document the Pulse Width Modulation (PWM) controller on Qualcomm Shikra
SoCs. The controller has a shared enable register, ten independently
addressed frame blocks, and shared AHB and PWM core clocks.

Describe the frame child-node address mapping and the consumer PWM
specifier needed to select each hardware frame.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../devicetree/bindings/pwm/qcom,shikra-pwm.yaml   | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,shikra-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,shikra-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d7f2bdab68f68b822fc93ecabd628ab53d408249
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/qcom,shikra-pwm.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/qcom,shikra-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shikra PWM controller
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  The Qualcomm PWM (Pulse Width Modulation) block on Shikra contains
+  up to 10 independent PWM frame channels. Each frame is a child node of
+  the PWM controller node and owns its own register range. All frames
+  share a single PWM core clock owned by the parent node. Child frame reg
+  properties use the parent SoC address space through an empty identity
+  ranges mapping.
+
+  The PWM source input clock, pwm_core, is given by:
+
+    F_PWM_CLK = 19.2 MHz / N
+
+  where N is an integer from 1 through 512. The output frequency range
+  for a given PWM source clock is:
+
+    f_out(max) = F_PWM_CLK / 2
+    f_out(min) = F_PWM_CLK / 65536
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: qcom,shikra-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHB bus clock for the PWM block.
+      - description: Gate clock shared by every frame (pwm_core).
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: core
+
+  "#pwm-cells":
+    const: 3
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^pwm@[0-9a-f]+$":
+    type: object
+    description: Per-frame PWM channel sub-node.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: This frame's own absolute register range.
+
+      qcom,frame-index:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Hardware frame index within the PWM block. It is the PWM index
+          used in the first cell of a consumer PWM specifier and selects
+          the corresponding enable bit in PWM_TOPCTL0.
+        maximum: 9
+
+    required:
+      - reg
+      - qcom,frame-index
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#pwm-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,shikra-gcc.h>
+
+    / {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pwm: pwm@4700000 {
+            compatible = "qcom,shikra-pwm";
+            reg = <0x0 0x04700000 0x0 0x10>;
+            clocks = <&gcc GCC_PDM_AHB_CLK>, <&gcc GCC_PWM0_XO512_CLK>;
+            clock-names = "ahb", "core";
+            assigned-clocks = <&gcc GCC_PWM0_XO512_CLK>;
+            assigned-clock-rates = <9600000>;
+            #pwm-cells = <3>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            pwm@4701000 {
+                reg = <0x0 0x04701000 0x0 0x1c>;
+                qcom,frame-index = <0>;
+            };
+
+            pwm@4702000 {
+                reg = <0x0 0x04702000 0x0 0x1c>;
+                qcom,frame-index = <1>;
+            };
+        };
+    };

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812939;
	b=IBgADo0LP44zwh9d0OJdjZ/PtdGJ+DekS5ZF9RqjBMk1ZzSkB7Ell52O+o5Snoyq884S
	 DJpXQvabCT+wxLl6SvLGHFeXyjN/fxRIrwKOHNge2eAcdOi/N8IbUY58oGkv/pHCyJw2u
	 hZBKIVrN9PICV/OJaBliZKsmT6qcgQ3nbGQgtB0o5hzUaKZs2ignmav8MaJDP04/uLAJw
	 hnOd1TQEuhVOMy9KyqwHijguqtkS7pg6e467lLdAjdv2xNPu9e6I0EDRIjZqaw2SQIQns
	 LRAfkCuPgB7lsy5cksoOCvyjpv8EdlkfuJ6+IKvnjq1jE/MiVmdTK5SkX58LAhnd1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FG82KA3ITJk+qxqSHRsESc2kECZErXEwgu1nAZqqrnc=;
	b=gPuBN9r+krBscf6thEVRU2fUfjsEuis9bDDk/Q8rXBF4Jbkdyl5kpMSh6NP+VvOALauE
	 9zbwq6z/Fs3S5Q+i2/DoR5o3ZQxtAcJe/xsZeTKlrh6gehl/6Cmg29pnXNAdZaM7JUKRr
	 anYcN3Lhf6IaBwZMvwyXp6ds9HNd7pjw62JPThxCwVM0P3+eNeM9u6wkJ86xElgO3QTqn
	 9N3QzAlBi2IWBXAp5HC/IPkkB0FIGgfUtfG88Peq6iIMeSr9SbCVAe0LxVdWLhRd6T6xQ
	 dgN+0GcLKbReW6rT/XR10dTf/kNfrxW1adxexC1Echft+nnvmFgs/ZXQNIZJBkw3+/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K72Wz9pF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FhXTP3NK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C3606A32A
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K72Wz9pF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FhXTP3NK
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5LIoR796248
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FG82KA3ITJk+qxqSHRsESc2kECZErXEwgu1nAZqqrnc=; b=K72Wz9pFQWBkW+2r
	fNG1aOQ19DVmmmlPKg45OS+ZfKGmQaNDDOXxJEPnYrOzLpG4Fg8Bq/0mE4iiBjrL
	Kv0zq0VnyiAGokOb4gAXq137MaaK+FQRJcPEQdiMMjhI3vrycT6wK2buQLu0ck1k
	iYNHU/yMa6atHBtTxR9QvIqZMLnbUVcRxPCpu7lUIXSS663YL4XyYk3stsBmiD45
	rTyLJeX3xIQjMkk9fHA1dOpzAF4UkcraJw+hhGpFfM0uqOvxXtmGRXmQgW2Gwrx1
	L7T3AIuH+8IvAwY18PgK0KGtoIraapiokpdPijGMt0a+8PzNeDEMrertmm4GWFSv
	veVBBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc0y1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0afbf532eso2826123a91.0
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794812937; x=1795417737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FG82KA3ITJk+qxqSHRsESc2kECZErXEwgu1nAZqqrnc=;
        b=FhXTP3NKpoXOrWJjG+nRwz05n/YaLzCs1ZzPyf/v+JnEhU8PgVWj1zo0VXBzcPxP6o
         bUl/52RNVgo/nV8+Itddb++zAJC6LYCOC2kV+gNer0vESUr38MIhJTpXnBJvraRN3s6H
         t9fql3/HGqvIkRKInH2ioTF3qUkulrYKzppmYYa1IvSdPxMEGs6426xR0+OdJ4ZLx5b1
         L801/N4uSrXUM1BQRBB3OTdxzDs+ei9eBB8FMqxbWTUZLvmd/VdjqSb/hEYzu4a/elEl
         wEBNk2fDinOowckdZ/D/BEfdNPjr9t0TYwF4oEsnj9NlPpoOI1ebOpXw35uWHazOFans
         mbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812937; x=1795417737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FG82KA3ITJk+qxqSHRsESc2kECZErXEwgu1nAZqqrnc=;
        b=PpHU5mrWrs/yEJYAG4YEOzUyWJzo1VS0d+9BmslpNzLEQ/93k9K1YdIt/drCAsHIFa
         XOKQIlNWa6tcg9uNxb2DCIRniGtRik8sTQzbHg4RCqYZRZeupmvoxm39kPRrDhXOJezl
         +qsh1p2eIlGNi06QAkJE1AKZbhgzs7LX7O81IbMPDZzzu5WxjDYeRrEEHWheDjE44yvY
         o82B9FCRBjpbuh/6ZsyCJROAUBMCtAeWc1HTJp/gOlTP3SH27D1E3LbN2iOpU11+lIFK
         eplHS8KeFnmR699Yc5m4tk5Tldz8Uf/IP+B4wjznvYF9aksR3n8NPdT7ad1XtpdjoYML
         99Jw==
X-Forwarded-Encrypted: i=1; AL+hErE5Q3f7HgpJ21evAxz5QhSHq5c6WbO5Ke7airxl/QDhvb5jKeEopt8YRoM66QUuLzd9suHoUUn7+kM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a8+vhM2Z1hWJPCluN70Ap0DaDOr7WI2CffmPiGdByi1heowva
	0I5tthWgNYeVhwlhD77AFJqlf8+AntQ/Ie9gX4mkQZl0liFPfRGDLODgZFeQIxupZ+oLejre2hi
	3WTqK9ddEqYMAVd7X04QRzBplj3KtNFW+SRoAmAv3ReF5bYzK41xH1vQrqY6TrY8=
X-Gm-Gg: AZFdTZclnJuukGAkT2UjAKF/WhGmX3+qPvV8jLCesrMeY0df0AmsW3sA06kiAFwmx3X
	KUoQq2cL3wy300bBM1Wp3tBRRk5ah95HZhdTkU6IMtjDGe17AbzjkW23h9EpgttECqTAhWquG7O
	uyH2+6cS+mgr+oS9JBvuzc7dvwGj0h4gYLNUKBkY4+84W1/5v42oK0lzYi03lQcXVsxGh4f8+yI
	FA9y5jwbeQSw/IHbuzojT46B6aShDRmkZeYlnUj1raR9uutsM95toT2PR/D2y++bcKSCXdyT/K/
	w4dYQwaU4PRrD4auZvPJHIgmIQ2Us5GI6414UVp8BS6wSuluSpFj5eJF8epmKckPOt2ht0dh882
	e7XIt0tBgcacZNxbVmmQWNlIbjq+rk8SUWKmdfLGHnOKRkwXVacHJTzwjMjVmFAHBgAu44yxqeQ
	==
X-Received: by 2002:a17:90a:c88f:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3b1b0b5d611mr8448053a91.51.1794812936694;
        Sun, 15 Nov 2026 23:08:56 -0800 (PST)
X-Received: by 2002:a17:90a:c88f:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3b1b0b5d611mr8448038a91.51.1794812936077;
        Sun, 15 Nov 2026 23:08:56 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm8658667a91.0.2026.11.15.23.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:08:55 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:29:49 +0530
Subject: [PATCH 2/3] pwm: qcom: add Shikra PWM controller support
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
Message-Id: <20261116-pwm_qcom_shikra-v1-2-67ee4553adc5@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX7MNXoPFCtFdd
 EK9ffMVo3OS3FWnHPMjMb3Tf/EZU1uPSE4hMCnZTsqPFhWkJTr+AxW6Nov0FV43+0+V6bDrIwjX
 ZW61MTPoQE+8PLVYz3UWlkk8dQoasoI=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afaac09 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tUE8Ju4hAUQuexWuWzgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: xf8NdrT_QXFZLnkO9PA3cal3TJs5lEs-
X-Proofpoint-GUID: xf8NdrT_QXFZLnkO9PA3cal3TJs5lEs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX+fv5bCPqFZpu
 nUQqB+SFYDhV2zp7y8gyj4WDt4+FW+rssNa/SeY2FEdYK0s8XkxXcWG/VaHWHjJyuSYS9PGwr6P
 V8zdU6sCJjhGy58NNEASbh4Bl+p2nD1isWwEttDmkGxez8NspFTgtJ19S3QHG+SuiZH6QpBUb/i
 JTdg2szxulZ5lz93Jf3ejoy+vW9QauLsAVQbLHemSmpZN7oX89jwT8C2MwMMRNgw+Kp60MkMqDl
 S+4ykAvS1G3ROpajkOnYzUOyBH+Rm2u/JWdQZAQ519S88sMGBsIEA4ttHasEBS0kPViPBjG1J5L
 eEBMmSdmWfc9NnKH4pngKBHMU3jlbsnpNa8VUFmOera63HGdoYFr/M6rDf+WYK09f4ahrXwHkt/
 fx0/4gGn6dBeOzRXMbU5l/Wo1ObgeVVk+ewrJA7BVytlNLrS6Y8NayAqmytfxbeT+8qkPM8rrgR
 lXgDIEbHeLn+qBtnncg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160028

Add support for the Pulse Width Modulation (PWM) controller on Qualcomm
Shikra SoCs.

The controller has a shared output-enable register and up to ten frame
blocks with independent configuration registers. Model each available
frame from its DT child node, and retain the shared AHB and PWM core
clocks while an output is active.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/pwm/Kconfig    |  13 +
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-qcom.c | 685 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 699 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index aacd800687e7c98b2272ddb01447356349425032..ae229e922521e97d88610887da5ccb0f7433fbd3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -566,6 +566,19 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_QCOM
+	tristate "Qualcomm PWM support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on COMMON_CLK && HAS_IOMEM && OF
+	select REGMAP_MMIO
+	help
+	  PWM framework driver for the PWM block found on Qualcomm SoCs,
+	  which supports multiple PWM frames. Each frame can be
+	  configured independently of the others.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-qcom.
+
 config PWM_RASPBERRYPI_POE
 	tristate "Raspberry Pi Firmware PoE Hat PWM support"
 	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7e2c34cc4f6a955b04edcdd08721264d0d477f2e..a7e0095b573448cb643b19f4da2e6f02ada4bc39 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_QCOM)		+= pwm-qcom.o
 obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RENESAS_RCAR)	+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
diff --git a/drivers/pwm/pwm-qcom.c b/drivers/pwm/pwm-qcom.c
new file mode 100644
index 0000000000000000000000000000000000000000..9b15cdcaa5c76a3f2a9d7871b4e12d52cf89610a
--- /dev/null
+++ b/drivers/pwm/pwm-qcom.c
@@ -0,0 +1,685 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+/* Offsets */
+#define PWM_TOPCTL0			0x0
+
+/* offsets per frame */
+#define PWM_CTL0			0x0
+#define PWM_CTL1			0x4
+#define PWM_CTL2			0x8
+#define PWM_CYC_CFG			0xc
+#define PWM_UPDATE			0x10
+#define PWM_RESET			0x18
+
+#define PWM_FRAME_POLARITY_BIT		BIT(0)
+#define PWM_FRAME_ROLLOVER_CNT_BIT	BIT(4)
+#define PWM_FRAME_RESET_BIT		BIT(0)
+
+/* All per-frame 16-bit value fields (CYC_CFG, CTL1, CTL2). */
+#define PWM_FRAME_VAL_MASK		GENMASK(15, 0)
+
+/*
+ * struct qcom_pwm_priv_data - per-compatible hardware description
+ * @max_channels: number of frames supported by this hardware variant.
+ * @pwm_reset_support: whether PWM_RESET is implemented, allowing the period
+ *	to be changed after it has already been set once.
+ * @pwm_cnt_rollover: whether PWM_FRAME_ROLLOVER_CNT_BIT is implemented,
+ *	needed so period changes don't get stuck waiting on the counter.
+ */
+struct qcom_pwm_priv_data {
+	unsigned int max_channels;
+	bool pwm_reset_support;
+	bool pwm_cnt_rollover;
+};
+
+/*
+ * struct qcom_pwm_frames - Information regarding per PWM frame
+ * @frame_id: Id number associated with each frame.
+ * @polarity: Current polarity of the particular frame.
+ * @regmap: regmap covering this frame's own register block. Each frame now
+ *	owns its own "reg" range in DT, so registers are accessed at their
+ *	plain offsets within this regmap instead of as an offset into a
+ *	shared parent regmap.
+ * @current_period_ns: Current period of the particular frame.
+ * @current_duty_ns: Current duty cycle of the particular frame.
+ * @current_freq: Current frequency of frame.
+ * @freq_set: This bool flag is responsible for setting period once per frame.
+ * @frame_lock: mutex lock per frame.
+ * @cnt_rollover_en: This bool flag is used to set rollover bit per frame.
+ */
+struct qcom_pwm_frames {
+	u32	frame_id;
+	u32	polarity;
+	struct regmap *regmap;
+	u64	current_period_ns;
+	u64	current_duty_ns;
+	unsigned long current_freq;
+	bool	is_enabled;
+	bool	freq_set;
+	struct mutex frame_lock; /* PWM per frame lock */
+	bool cnt_rollover_en;
+};
+
+/*
+ * struct qcom_pwm_chip - Information regarding per PWM block
+ * @regmap: regmap of the shared PWM_TOPCTL0 enable register.
+ * @frames: structure for all frames of each PWM block.
+ * @priv_data: per-compatible hardware description.
+ * @ahb: AHB clock providing access to the PWM block.
+ * @core: shared clock providing the PWM frame rate.
+ * @lock: mutex lock per chip (enable/disable path).
+ * @num_frames: number of frames in each PWM block.
+ */
+struct qcom_pwm_chip {
+	struct regmap		*regmap;
+	struct qcom_pwm_frames	*frames;
+	const struct qcom_pwm_priv_data	*priv_data;
+	struct clk		*ahb;
+	struct clk		*core;
+	/* This lock to be used for Enable/Disable as it is per PWM channel */
+	struct mutex		lock;
+	u32			num_frames;
+};
+
+static inline struct qcom_pwm_chip *to_qcom_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int qcom_pwm_clks_enable(struct qcom_pwm_chip *chip)
+{
+	int ret;
+
+	ret = clk_prepare_enable(chip->ahb);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(chip->core);
+	if (ret)
+		clk_disable_unprepare(chip->ahb);
+
+	return ret;
+}
+
+static void qcom_pwm_clks_disable(struct qcom_pwm_chip *chip)
+{
+	clk_disable_unprepare(chip->core);
+	clk_disable_unprepare(chip->ahb);
+}
+
+static int qcom_pwm_calc_frequency(struct qcom_pwm_chip *chip,
+				   u64 period_ns, unsigned long rate, u32 hw_idx)
+{
+	struct regmap *frame_regmap = chip->frames[hw_idx].regmap;
+	u64 cycles;
+	int ret;
+
+	/*
+	 * PWM client can set the period only once if the HW version does
+	 * not support reset functionality.
+	 */
+	if (chip->frames[hw_idx].freq_set && !chip->priv_data->pwm_reset_support)
+		return 0;
+
+	/*
+	 * Number of core-clock cycles in one PWM period. Round down so the
+	 * implemented period never exceeds the requested one, as the PWM API
+	 * requires. PWM_CYC_CFG holds (cycles - 1) in its low 16 bits, so
+	 * cycles is bounded to [2, 65536], i.e. an output frequency from
+	 * rate / 2 down to rate / 65536.
+	 */
+	cycles = mul_u64_u64_div_u64(period_ns, rate, NSEC_PER_SEC);
+	if (cycles < 2 || cycles > 65536) {
+		dev_dbg(regmap_get_device(frame_regmap),
+			"period %llu ns out of range for rate %lu Hz\n",
+			period_ns, rate);
+		return -ERANGE;
+	}
+
+	ret = regmap_update_bits(frame_regmap, PWM_CYC_CFG,
+				 PWM_FRAME_VAL_MASK, cycles - 1);
+	if (ret)
+		return ret;
+
+	chip->frames[hw_idx].current_freq = div64_ul(rate, cycles);
+	chip->frames[hw_idx].freq_set = true;
+	chip->frames[hw_idx].current_period_ns = period_ns;
+
+	return 0;
+}
+
+static int qcom_pwm_get_state(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct qcom_pwm_chip *chip = to_qcom_pwm_chip(pwm_chip);
+	struct qcom_pwm_frames *frame = &chip->frames[pwm->hwpwm];
+	unsigned long rate;
+	u32 topctl, ctl0, ctl1, cyc_cfg, cycles;
+	int ret;
+
+	if (!frame->regmap)
+		return -ENODEV;
+
+	/* Both clocks are needed for register access. */
+	ret = qcom_pwm_clks_enable(chip);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(chip->core);
+	if (!rate) {
+		ret = -EINVAL;
+		goto err_clks;
+	}
+
+	mutex_lock(&frame->frame_lock);
+
+	ret = regmap_read(chip->regmap, PWM_TOPCTL0, &topctl);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(frame->regmap, PWM_CTL0, &ctl0);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(frame->regmap, PWM_CTL1, &ctl1);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(frame->regmap, PWM_CYC_CFG, &cyc_cfg);
+	if (ret)
+		goto out;
+
+	cycles = (cyc_cfg & PWM_FRAME_VAL_MASK) + 1;
+	state->enabled = !!(topctl & BIT(frame->frame_id));
+	state->polarity = (ctl0 & PWM_FRAME_POLARITY_BIT) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	/*
+	 * Round up so re-applying the returned state reproduces the same
+	 * register values, since qcom_pwm_config() rounds the period and duty
+	 * cycle down.
+	 */
+	state->period = DIV_ROUND_UP_ULL((u64)cycles * NSEC_PER_SEC, rate);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)(ctl1 & PWM_FRAME_VAL_MASK) *
+					     NSEC_PER_SEC, rate);
+out:
+	mutex_unlock(&frame->frame_lock);
+err_clks:
+	qcom_pwm_clks_disable(chip);
+
+	return ret;
+}
+
+static int qcom_pwm_config(struct qcom_pwm_chip *chip,
+			   u32 hw_idx, u64 duty_ns, u64 period_ns, int polarity)
+{
+	struct regmap *frame_regmap = chip->frames[hw_idx].regmap;
+	u64 ctl1, duty_percent;
+	unsigned long rate;
+	u64 current_period = period_ns;
+	bool clks_enabled = false;
+	int ret;
+	u32 cyc_cfg;
+
+	mutex_lock(&chip->frames[hw_idx].frame_lock);
+
+	if (!chip->frames[hw_idx].is_enabled) {
+		ret = qcom_pwm_clks_enable(chip);
+		if (ret)
+			goto err_unlock;
+		clks_enabled = true;
+	}
+
+	rate = clk_get_rate(chip->core);
+	if (!rate) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Set the counter rollover enable bit, so that counter doesn't get stuck
+	 * in period change configuration.
+	 */
+	if (chip->priv_data->pwm_cnt_rollover && !chip->frames[hw_idx].cnt_rollover_en) {
+		ret = regmap_update_bits(frame_regmap, PWM_CTL0,
+					 PWM_FRAME_ROLLOVER_CNT_BIT,
+					 PWM_FRAME_ROLLOVER_CNT_BIT);
+		if (ret)
+			goto out;
+
+		chip->frames[hw_idx].cnt_rollover_en = true;
+	}
+
+	if (chip->frames[hw_idx].freq_set &&
+	    chip->frames[hw_idx].current_period_ns != period_ns) {
+		if (chip->priv_data->pwm_reset_support) {
+			ret = regmap_update_bits(frame_regmap, PWM_RESET,
+						 PWM_FRAME_RESET_BIT,
+						 PWM_FRAME_RESET_BIT);
+			if (ret)
+				goto out;
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = qcom_pwm_calc_frequency(chip, current_period, rate, hw_idx);
+	if (ret)
+		goto out;
+
+	if (chip->frames[hw_idx].polarity != polarity) {
+		ret = regmap_update_bits(frame_regmap, PWM_CTL0,
+					 PWM_FRAME_POLARITY_BIT, polarity);
+		if (ret)
+			goto out;
+
+		chip->frames[hw_idx].polarity = polarity;
+	}
+
+	ctl1 = DIV_ROUND_CLOSEST(rate, chip->frames[hw_idx].current_freq);
+	duty_percent = mul_u64_add_u64_div_u64(duty_ns, 100, current_period / 2, current_period);
+	ctl1 = mul_u64_add_u64_div_u64(ctl1, duty_percent, 50, 100);
+
+	ret = regmap_read(frame_regmap, PWM_CYC_CFG, &cyc_cfg);
+	if (ret)
+		goto out;
+
+	if ((ctl1 > cyc_cfg || ctl1 == 0) && duty_ns != 0) {
+		dev_err(regmap_get_device(frame_regmap),
+			"duty cycle out of valid range\n");
+		ret = -ERANGE;
+		goto out;
+	}
+
+	ret = regmap_update_bits(frame_regmap, PWM_CTL2, PWM_FRAME_VAL_MASK, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame_regmap, PWM_CTL1, PWM_FRAME_VAL_MASK, ctl1);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame_regmap, PWM_UPDATE, BIT(0), 1);
+	if (ret)
+		goto out;
+
+	chip->frames[hw_idx].current_duty_ns = duty_ns;
+out:
+	if (clks_enabled)
+		qcom_pwm_clks_disable(chip);
+err_unlock:
+	mutex_unlock(&chip->frames[hw_idx].frame_lock);
+
+	return ret;
+}
+
+static int qcom_pwm_enable(struct qcom_pwm_chip *chip,
+			   struct pwm_device *pwm)
+{
+	struct device *dev = regmap_get_device(chip->regmap);
+	int ret;
+	u32 val, hw_idx = pwm->hwpwm;
+
+	ret = qcom_pwm_clks_enable(chip);
+	if (ret)
+		return ret;
+
+	mutex_lock(&chip->lock);
+
+	dev_dbg(dev, "enable: hw_idx=%u frame_id=%u\n",
+		hw_idx, chip->frames[hw_idx].frame_id);
+
+	val = BIT(chip->frames[hw_idx].frame_id);
+	ret = regmap_update_bits(chip->regmap, PWM_TOPCTL0, val, val);
+	if (!ret)
+		chip->frames[hw_idx].is_enabled = true;
+
+	mutex_unlock(&chip->lock);
+
+	if (ret)
+		goto err_clks;
+
+	return 0;
+
+err_clks:
+	qcom_pwm_clks_disable(chip);
+	return ret;
+}
+
+static int qcom_pwm_disable(struct qcom_pwm_chip *chip,
+			    struct pwm_device *pwm)
+{
+	struct device *dev = regmap_get_device(chip->regmap);
+	u32 val, hw_idx = pwm->hwpwm;
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	dev_dbg(dev, "disable: hw_idx=%u\n", hw_idx);
+
+	val = BIT(chip->frames[hw_idx].frame_id);
+	ret = regmap_update_bits(chip->regmap, PWM_TOPCTL0, val, 0);
+	if (!ret)
+		chip->frames[hw_idx].is_enabled = false;
+
+	mutex_unlock(&chip->lock);
+
+	if (ret)
+		return ret;
+
+	qcom_pwm_clks_disable(chip);
+
+	return 0;
+}
+
+static int qcom_pwm_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct qcom_pwm_chip *chip = to_qcom_pwm_chip(pwm_chip);
+	struct pwm_state curr_state;
+	u32 hw_idx = pwm->hwpwm;
+	int ret;
+
+	pwm_get_state(pwm, &curr_state);
+
+	if (state->period &&
+	    (state->period != curr_state.period ||
+	     state->duty_cycle != curr_state.duty_cycle ||
+	     state->polarity != curr_state.polarity)) {
+		ret = qcom_pwm_config(chip, hw_idx, state->duty_cycle,
+				      state->period, state->polarity);
+		if (ret) {
+			dev_err(pwmchip_parent(pwm_chip),
+				"failed to update PWM configuration\n");
+			return ret;
+		}
+	}
+
+	if (state->enabled != curr_state.enabled) {
+		if (state->enabled)
+			return qcom_pwm_enable(chip, pwm);
+
+		ret = qcom_pwm_disable(chip, pwm);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_pwm_request(struct pwm_chip *pwm_chip, struct pwm_device *pwm)
+{
+	struct qcom_pwm_chip *chip = to_qcom_pwm_chip(pwm_chip);
+
+	if (!chip->frames[pwm->hwpwm].regmap)
+		return -ENODEV;
+
+	return 0;
+}
+
+/*
+ * Reset the software state and the frame's own registers (the same
+ * PWM_CTL0/PWM_CTL1/PWM_CYC_CFG registers qcom_pwm_get_state() reads back)
+ * to their power-on defaults, and disable an active PWM frame.
+ */
+static void qcom_pwm_free(struct pwm_chip *pwm_chip, struct pwm_device *pwm)
+{
+	struct qcom_pwm_chip *chip = to_qcom_pwm_chip(pwm_chip);
+	struct qcom_pwm_frames *frame = &chip->frames[pwm->hwpwm];
+	bool enabled;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	enabled = frame->is_enabled;
+	mutex_unlock(&chip->lock);
+
+	if (enabled) {
+		ret = qcom_pwm_disable(chip, pwm);
+		if (ret) {
+			dev_err(pwmchip_parent(pwm_chip),
+				"failed to disable PWM on free\n");
+			return;
+		}
+	}
+
+	ret = qcom_pwm_clks_enable(chip);
+	if (ret) {
+		dev_err(pwmchip_parent(pwm_chip),
+			"failed to enable clocks on free\n");
+		return;
+	}
+
+	mutex_lock(&frame->frame_lock);
+
+	ret = regmap_update_bits(frame->regmap, PWM_CTL0,
+				 PWM_FRAME_POLARITY_BIT | PWM_FRAME_ROLLOVER_CNT_BIT, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame->regmap, PWM_CTL1, PWM_FRAME_VAL_MASK, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame->regmap, PWM_CTL2, PWM_FRAME_VAL_MASK, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame->regmap, PWM_CYC_CFG, PWM_FRAME_VAL_MASK, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(frame->regmap, PWM_UPDATE, BIT(0), 1);
+	if (ret)
+		goto out;
+
+	if (chip->priv_data->pwm_reset_support) {
+		ret = regmap_update_bits(frame->regmap, PWM_RESET,
+					 PWM_FRAME_RESET_BIT, PWM_FRAME_RESET_BIT);
+		if (ret)
+			goto out;
+	}
+
+	frame->freq_set = false;
+	frame->current_period_ns = 0;
+	frame->current_duty_ns = 0;
+	frame->current_freq = 0;
+	frame->polarity = 0;
+	frame->cnt_rollover_en = false;
+out:
+	mutex_unlock(&frame->frame_lock);
+	qcom_pwm_clks_disable(chip);
+
+	if (ret)
+		dev_err(pwmchip_parent(pwm_chip),
+			"failed to reset PWM registers on free\n");
+}
+
+static const struct pwm_ops qcom_pwm_ops = {
+	.request = qcom_pwm_request,
+	.apply = qcom_pwm_apply,
+	.free = qcom_pwm_free,
+	.get_state = qcom_pwm_get_state,
+};
+
+static const struct regmap_config pwm_regmap_config = {
+	.reg_bits   = 32,
+	.reg_stride = 4,
+	.val_bits   = 32,
+	.fast_io    = true,
+};
+
+static int qcom_pwm_parse_dt(struct platform_device *pdev,
+			     struct pwm_chip *pwm_chip,
+			     struct qcom_pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(pwm_chip);
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *frame_node;
+	void __iomem *base;
+	unsigned long frame_ids = 0;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	chip->regmap = devm_regmap_init_mmio(dev, base, &pwm_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				"failed to initialise regmap\n");
+
+	chip->ahb = devm_clk_get(dev, "ahb");
+	if (IS_ERR(chip->ahb))
+		return dev_err_probe(dev, PTR_ERR(chip->ahb),
+				"failed to get ahb clock\n");
+
+	chip->core = devm_clk_get(dev, "core");
+	if (IS_ERR(chip->core))
+		return dev_err_probe(dev, PTR_ERR(chip->core),
+				"failed to get core clock\n");
+
+	chip->frames = devm_kcalloc(dev, chip->num_frames,
+				    sizeof(*chip->frames), GFP_KERNEL);
+	if (!chip->frames)
+		return -ENOMEM;
+
+	for_each_available_child_of_node(np, frame_node) {
+		u32 n;
+		struct resource res;
+
+		if (of_property_read_u32(frame_node, "qcom,frame-index", &n)) {
+			of_node_put(frame_node);
+			return dev_err_probe(dev, -EINVAL,
+					"missing qcom,frame-index property in DT node\n");
+		}
+
+		if (n >= chip->priv_data->max_channels) {
+			of_node_put(frame_node);
+			return dev_err_probe(dev, -EINVAL,
+					"invalid qcom,frame-index %u\n", n);
+		}
+
+		if (test_and_set_bit(n, &frame_ids)) {
+			of_node_put(frame_node);
+			return dev_err_probe(dev, -EINVAL,
+					"duplicate qcom,frame-index %u\n", n);
+		}
+
+		chip->frames[n].frame_id = n;
+
+		ret = of_address_to_resource(frame_node, 0, &res);
+		if (ret) {
+			of_node_put(frame_node);
+			return dev_err_probe(dev, ret,
+					"failed to get frame-%u resource\n", n);
+		}
+
+		base = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(base)) {
+			of_node_put(frame_node);
+			return PTR_ERR(base);
+		}
+
+		chip->frames[n].regmap =
+			devm_regmap_init_mmio(dev, base, &pwm_regmap_config);
+		if (IS_ERR(chip->frames[n].regmap)) {
+			of_node_put(frame_node);
+			return dev_err_probe(dev, PTR_ERR(chip->frames[n].regmap),
+						 "failed to initialise frame regmap\n");
+		}
+
+		mutex_init(&chip->frames[n].frame_lock);
+	}
+
+	/* The hardware requires all PWM outputs to be disabled at probe. */
+	ret = qcom_pwm_clks_enable(chip);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(chip->regmap, PWM_TOPCTL0,
+				 GENMASK(chip->priv_data->max_channels - 1, 0), 0);
+
+	qcom_pwm_clks_disable(chip);
+
+	return ret;
+}
+
+static const struct qcom_pwm_priv_data shikra_pwm_data = {
+	.max_channels = 10,
+};
+
+static const struct of_device_id qcom_pwm_of_match[] = {
+	{ .compatible = "qcom,shikra-pwm", .data = &shikra_pwm_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_pwm_of_match);
+
+static int qcom_pwm_probe(struct platform_device *pdev)
+{
+	struct pwm_chip *pwm_chip;
+	struct qcom_pwm_chip *chip;
+	const struct qcom_pwm_priv_data *priv;
+	struct device_node *np = pdev->dev.of_node;
+	u32 child_count;
+	int rc;
+
+	priv = of_device_get_match_data(&pdev->dev);
+	if (!priv)
+		return -EINVAL;
+
+	/* At least one available frame resource must be described. */
+	child_count = of_get_available_child_count(np);
+	if (!child_count)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				"at least one PWM frame must be described\n");
+
+	pwm_chip = devm_pwmchip_alloc(&pdev->dev, priv->max_channels, sizeof(*chip));
+	if (IS_ERR(pwm_chip))
+		return PTR_ERR(pwm_chip);
+
+	chip = to_qcom_pwm_chip(pwm_chip);
+	chip->priv_data  = priv;
+	chip->num_frames = priv->max_channels;
+	mutex_init(&chip->lock);
+
+	pwm_chip->ops = &qcom_pwm_ops;
+
+	rc = qcom_pwm_parse_dt(pdev, pwm_chip, chip);
+	if (rc)
+		return rc;
+
+	rc = devm_pwmchip_add(&pdev->dev, pwm_chip);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static struct platform_driver qcom_pwm_driver = {
+	.driver		= {
+		.name		= "qcom-pwm",
+		.of_match_table	= qcom_pwm_of_match,
+	},
+	.probe		= qcom_pwm_probe,
+};
+
+module_platform_driver(qcom_pwm_driver);
+
+MODULE_DESCRIPTION("Qualcomm PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907959;
	b=X6g1qymrINAYjs07urWBfyKnrVSEnL4TEvM7KnOPPbt5FTRMVNejjAaDjh2/vclw01QL
	 BVC6/N+QqbE17HCOyiPuD0Lwd4h7ziocvDZdTYkRxsG8/2OVxdjrlS5b9Y81BLNK2IioM
	 qaEwp5aSzBf+Cx5YbZbiLLtfi6hTVmn709t/TgH8PU1EpLOsUy8w16OpQqWNWOB2bDXeV
	 QgLjmuHQTKSJrrHKQtPeaWOE21RPGEkgU69luJZ+NQD3YRcUCeS/kV+E29W9vV/p+CgB2
	 hyEct5Fz4fMUYWtR+/V3KG9t+PO5FgSmre5F8FgqW0Mna+j9+Lx5LBW4pxDg/A/f5xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VLiNXftdCYQAkP1ETrrjoQTw6hSEwVHspkQilFxmO4w=;
	b=1fXZYq0BPfheWPrMiJfCxGB0k7oWJjGcvnBNEK3K1nzNxdS+IM1bPuYl4Hicv/OY38tM
	 oU3+hYVG0aGYQsnKmKkwPnuLvtaEKqGtUDyBMyPTm9y94RCVHd2KIigiKfnGDhemuAerM
	 w34XGkqhpdOZN2q+ShMpnkFPYluIHiCbzimc91ad5WHl2xtVlbeM4o6PRT4KWwL/uLUAq
	 BgW0NviKI4Vdhv89NOtjQjUsiwJSp9CP9vzoa7GUd1Jad8/+YNDngU/hCMTV2VJzvtfOV
	 2sLJesUvle3gy8pViNov+KqSZwHOWe3BjfEt6EkuWIPaAopj/EuMS9nmK1Kcj6KplLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U4p2IHsg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ueuhy05p;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9320606A8A7
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9320606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U4p2IHsg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ueuhy05p
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH6f76O2998768
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VLiNXftdCYQAkP1ETrrjoQTw6hSEwVHspkQilFxmO4w=; b=U4p2IHsgH+a/f8XJ
	Jgcr+bPX2hFEz3DO7/XnX+/vyV755sbw29mXCzHr+OwKyIvaSDuVdQMZj8WUxVNA
	1nlRwrG8KwtTLM5JT5i310m7CSi+6N6Cr5uu74/NM2u1QbDLLEGwIDvj/r83BjXG
	pImxZy7TOn0ZyQp+1PuqDRWDt/ieC2HHVzAUdtcMufz2e+dBAq6GCGrOV8zJ2nRy
	SdwHmWDyr16WzQXWiFWacrldvPJ+vbjVP7D3M0d/HtRQadazrhTDtvoWxJ3CYN2w
	hD36LJpP12uS8TuO7p0vEyugD6RZpzqezZ/Cqu/nD/KpIVgAwdeHs5lW/BpCDv9X
	64oGVA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve0pbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:37 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-55bf11583d9so869150b6e.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794907957; x=1795512757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLiNXftdCYQAkP1ETrrjoQTw6hSEwVHspkQilFxmO4w=;
        b=Ueuhy05pYuV/8fvtyLHUJAj3HWNOPvXUcdpg8S62lz3yAxDKXM/7HnXdy1gZBoIQcR
         W0pWjbC0ikr8JQDVoD7+8oJdB4ep7f092Xhhdb/7Ua3MQcREBkyy+IvGtStV10UYPXOd
         +vQr2dRMlJ2sIzsyCoued3Mchvv70sxl3QK6XbZOkN81B7FnIFqTZaOZYpQlxNEiTfpE
         i7htWXNNBw2Y2AquwV4FQ41vzrUtxND0xBVQLHpXtsDVVApKfNwJJnCzMctCzo856atG
         Wp6gYJjh7LSPcuO+78SMP/QrO9z2T/PegSh/0r8gzLiPGdEZEoA4f2MnntlWcWV1cNDZ
         TwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907957; x=1795512757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLiNXftdCYQAkP1ETrrjoQTw6hSEwVHspkQilFxmO4w=;
        b=Xaj+JzfqczVQakieh+bWp1PFUc8h5HBJS3HHD/NDBS38GathwvESGu1vnqH98P4193
         /Pc2apMa64MD51BCSiat4JbJriqV+RGQXHV479QnKObaiLurbDfETyrm331qxg/ZBIt7
         vhHlnntzqSv7ogdkvcP2h3y6xbTE4BFt41By2Y/hcTgilukft/zPKZpG0LSau8yk/NTe
         xOVHT79lvLyFoTuVhFPsskd+0dJuDgX0MLQfLj1ZIdw//SIN4HfX9eiNMwEvtdGlsIyt
         +u5p6TkaO0ZtV7jiUNRTiFfKI39Lu9PJLZsscW7fZKByKvMYePJGdE/r+4lREXyCID1a
         Aw0g==
X-Forwarded-Encrypted: i=1; AL+hErFNMcUGghp17NDI2O6hQdVfsdqcy7I5YFep6q0HKZUsfHBtv50znaBKsfbFxiLasVh4iz3SlMKuEzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uKLlCPTYFZr3m9viEwCTrIWog8c1VchJl5kfP8DVVacY7mvrf
	k1iVwourAjk67kc8Ycv4NoZRk3MsuEaGupP/oojPeIWsByGZpjU74JsvVEty6HxHi2fSipktahS
	zaKp1d4TrDVQF2ulzDrLyR+McnQ4vpm42Nt88hmVa5bAQ1ghtdakAesZSVvQqXBZHCTUEkzLtPQ
	==
X-Gm-Gg: AYBFou33yShwOU7FjPHbQpmmrr7ltuob9xFbZeuWZAIsC1ABvwxwZnCNIYQm+N2WxN2
	POrI4T4qUG/y9tuzm4e0V61cvVTOFLB560M321GUM4s5evI4kgLP8kiYX8RUPCH1mwZoO2xSgse
	7/TXoaBSGhA+krcw8aYz8tWMcqJxzMMFWMROFrc6hcZDi5u9N/Dzzn2UMs21yLzfCOlB6I97u6t
	i5TNNRSKS9x/aD0T111Y6ooydlNy4U8bHkrJfgYrNwBxKqTStoCsXH3SqEoXZ8czEGdMB208+ib
	MNb4sh+V0WuwYLv3O97Fo81QM0wyz2Y4xGGRzGfy9BqQWVuK0WN1/Ell5YWq2x1ZTIleffjowIv
	gQw/pFeC6LVqHssF0A/r/FNm4DIU+CYrV7l6o0/KnlGwuZv6vN86pcFoAj4caaR1vtNQcmBGkeC
	LH19KEQxUimBmAd75WT25e66E7
X-Received: by 2002:a05:6808:170b:b0:573:8745:a98a with SMTP id 5614622812f47-575db150217mr1532940b6e.1.1794907956710;
        Tue, 17 Nov 2026 01:32:36 -0800 (PST)
X-Received: by 2002:a05:6808:170b:b0:573:8745:a98a with SMTP id 5614622812f47-575db150217mr1532925b6e.1.1794907956171;
        Tue, 17 Nov 2026 01:32:36 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2206dc0sm8678928fac.5.2026.11.17.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:32:35 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 01:31:36 -0800
Subject: [PATCH 4/4] leds: rgb: leds-qcom-lpg: Add PWM frequency mode
 support
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
Message-Id: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-4-7a862240683f@oss.qualcomm.com>
References: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-0-7a862240683f@oss.qualcomm.com>
In-Reply-To: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-0-7a862240683f@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Griffin Kroah-Hartman <griffin@kroah.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907947; l=16906;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=/khxyldUXjeCvRyaP/KoC0cvpNj+qQ73ja1Aro7kOkM=;
 b=wrGYY2N6zjXHNKdDAG6A+hbedONQTDlfjPfAZUG/df0c6U6bYsBTQQ8rYrC3c1yF+ErkNpznC
 XpktFiHWgvFDXDYet8a3GiZ7z/BlKkGFc0zGeJfri3KHjA8mF2YU1Cu
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXxZ2Yw4Pqgrq/
 TKjbvKknbVoLSZkR5h944lJc/qTC8wTFl9lR+BNGLiOlTZB8/0jLionVWv7B/mrSSki/67Z9s/j
 N2Mf9giemcM8smIxrJtsjC0oobE9QbQ=
X-Proofpoint-GUID: kUZQ1v79vYciT--WpGeWAJf96vXqdXQn
X-Proofpoint-ORIG-GUID: kUZQ1v79vYciT--WpGeWAJf96vXqdXQn
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc1f35 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NSaPA566YKEXnaOw_k0A:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX6RBco2ZFX72X
 qk9eekYH9D0x1JCM9CWIjugdFj2qVN2V55sOUZlrKFJVLWEPjF7N5G4Ug46HZ98k8lfdJhLMNKc
 6CekgiLzMF4SEyxm5FebENQKQkZ52WtwYbImgpn0GKQkPdIjR+k4h+nuxc50dsuTTiZsrtz1VGR
 /2r1yK9eHc00UJIB4W6TEoetb2BzI/dmToPQYHcPhlTRrOnSzZgkV/Hycorkmm27+vPFDS5pSfl
 BfKKDmYrjRstA6I379RAsgLmKxBwB4c6U99GVQ3a7kSpVxp6huM7Xpqki/L/R3EyyHhEn5zObEK
 2HbviQjj/8jWaG6UPBsNvMLFO5A3351KqLArJKS1S1Dt//1q1zAvTT0Bxf1eYEL4RFbqNgJz3MV
 fsWWR/TzlP4K5nVXhzOGu7WqotMb/ORwDHdyAS/3LtqasT7bKwimPDY6yYSQnUNje1keYXZnIAC
 d0V4sL8soOXUfJtfcng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170037

Certain PWM channels on a PMIC (e.g. PM8350C PWM4) support a Frequency
Mode (FM) that can generate waveforms with more frequency points than
the standard LPG PWM mode. The trade-off is that the duty cycle can
only be fixed at 50%. Add the FM support and try to use it When the
PWM channel is requested to set a duty cycle to exactly 50%.

Instead of always selecting the frequency mode which might generate
the PWM waveform with less timing accuracy, the Codex AI suggested
and implemented an update that compares the PWM period and duty timing
accuracy in standard PWM mode versus frequency mode, then selects
the better option.

The change was tested on the Maili QRD device with pmh0101 by exercising
the pwm4 channel with a fixed 50% duty cycle and a period range of 40us
to 55us in 0.5us steps, and confirmed in the log that correct frequency
mode configuration was selected.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 349 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 330 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 971f92911606..68c73bce103c 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -22,6 +22,8 @@
 #define  LPG_SUBTYPE_PWM	0xb
 #define  LPG_SUBTYPE_HI_RES_PWM	0xc
 #define  LPG_SUBTYPE_LPG_LITE	0x11
+#define PWM_STATUS1_REG		0x08
+#define  PWM_FM_PRESENT		BIT(0)
 #define LPG_PATTERN_CONFIG_REG	0x40
 #define LPG_SIZE_CLK_REG	0x41
 #define  PWM_CLK_SELECT_MASK	GENMASK(1, 0)
@@ -43,6 +45,10 @@
 #define PWM_SEC_ACCESS_REG	0xd0
 #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
 
+/* offset 0x50: PWM_FM_MODE_REG on LPG_SUBTYPE_PWM */
+#define PWM_FM_MODE_REG		0x50
+#define  PWM_FM_ENABLE		BIT(7)
+
 #define SDAM_REG_PBS_SEQ_EN		0x42
 #define SDAM_PBS_TRIG_SET		0xe5
 #define SDAM_PBS_TRIG_CLR		0xe6
@@ -111,6 +117,8 @@ struct lpg_data;
  * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over pattern
  * @pattern_lo_idx: start index of associated pattern
  * @pattern_hi_idx: last index of associated pattern
+ * @freq_mode_capable: hardware supports Frequency Mode
+ * @enable_freq_mode: set the period using Frequency Mode
  * @has_lut: channel has the associated LUT allocation
  */
 struct lpg_channel {
@@ -148,6 +156,8 @@ struct lpg_channel {
 
 	unsigned int pattern_lo_idx;
 	unsigned int pattern_hi_idx;
+	bool freq_mode_capable;
+	bool enable_freq_mode;
 	bool has_lut;
 };
 
@@ -247,11 +257,13 @@ struct lpg {
  * @sdam_offset:	Channel offset in LPG SDAM
  * @base:		base address for PWM channel registers
  * @triled_mask:	bitmask for controlling this channel in TRILED
+ * @freq_mode_capable:	channel hardware supports Frequency Mode
  */
 struct lpg_channel_data {
 	unsigned int sdam_offset;
 	unsigned int base;
 	u8 triled_mask;
+	bool freq_mode_capable;
 };
 
 /**
@@ -448,6 +460,116 @@ static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
 static const unsigned int lpg_pwm_resolution[] = {6, 9};
 static const unsigned int lpg_pwm_resolution_hi_res[] = {8, 9, 10, 11, 12, 13, 14, 15};
 
+/*
+ * Compare exact physical durations without rounding to whole nanoseconds.
+ * Return positive if the candidate is longer, negative if the best is longer,
+ * and zero if both durations are equal.
+ */
+static int lpg_pwm_compare_candidate_duration(u64 candidate_duration_numerator,
+					      unsigned int candidate_clk_rate,
+					      u64 best_duration_numerator,
+					      unsigned int best_clk_rate)
+{
+	u32 candidate_remainder;
+	u32 best_remainder;
+	u64 candidate_whole_ns;
+	u64 best_whole_ns;
+	u64 candidate_fraction;
+	u64 best_fraction;
+
+	candidate_whole_ns = div_u64_rem(candidate_duration_numerator,
+					 candidate_clk_rate,
+					 &candidate_remainder);
+	best_whole_ns = div_u64_rem(best_duration_numerator, best_clk_rate,
+				    &best_remainder);
+	candidate_fraction = (u64)candidate_remainder * best_clk_rate;
+	best_fraction = (u64)best_remainder * candidate_clk_rate;
+
+	if (candidate_whole_ns != best_whole_ns)
+		return candidate_whole_ns > best_whole_ns ? 1 : -1;
+
+	if (candidate_fraction != best_fraction)
+		return candidate_fraction > best_fraction ? 1 : -1;
+
+	return 0;
+}
+
+/*
+ * Period calculation for PWM working in Frequency mode:
+ *
+ *          (pwm_value + 1) * 2^(exponent + 1) * NSEC_PER_SEC
+ * period = --------------------------------------------------
+ *                            clock_rate
+ *
+ * The duty cycle is fixed at half of the period.
+ */
+#define PWM_FM_PERIOD_NUMERATOR(exponent, pwm_value) \
+	(((u64)((pwm_value) + 1) << ((exponent) + 1)) * NSEC_PER_SEC)
+
+static int lpg_calc_freq_in_freq_mode(struct lpg_channel *chan, u64 period_ns, u64 duty_ns)
+{
+	unsigned int best_clk_sel = 0;
+	unsigned int best_pwm_exp = 0;
+	unsigned int best_pwm_value = 0;
+	u64 best_period_numerator = 0;
+	u64 max_period_ns;
+
+	max_period_ns = div_u64(PWM_FM_PERIOD_NUMERATOR(LPG_MAX_M, U8_MAX),
+				lpg_clk_rates[1]);
+	period_ns = min(period_ns, max_period_ns);
+	duty_ns = min(duty_ns, max_period_ns / 2);
+
+	for (unsigned int clk_sel = 1;
+	     clk_sel < ARRAY_SIZE(lpg_clk_rates); clk_sel++) {
+		for (unsigned int pwm_exp = 0; pwm_exp <= LPG_MAX_M; pwm_exp++) {
+			u64 duty_counter_length;
+			u64 counter_length;
+			u64 period_numerator;
+
+			counter_length = div64_u64(period_ns * lpg_clk_rates[clk_sel],
+						   (u64)NSEC_PER_SEC << (pwm_exp + 1));
+			duty_counter_length = div64_u64(duty_ns * lpg_clk_rates[clk_sel],
+							(u64)NSEC_PER_SEC << pwm_exp);
+			/* The counter must satisfy both period and fixed 50% duty bounds. */
+			counter_length = min(counter_length, duty_counter_length);
+			counter_length = min(counter_length, (u64)U8_MAX + 1);
+			if (!counter_length)
+				continue;
+
+			period_numerator =
+				PWM_FM_PERIOD_NUMERATOR(pwm_exp, counter_length - 1);
+			/*
+			 * All candidates are within the requested bounds, so the
+			 * longest period has the smallest timing error.
+			 */
+			if (!best_clk_sel ||
+			    lpg_pwm_compare_candidate_duration(period_numerator,
+							       lpg_clk_rates[clk_sel],
+							       best_period_numerator,
+							       lpg_clk_rates[best_clk_sel]) > 0) {
+				best_clk_sel = clk_sel;
+				best_pwm_exp = pwm_exp;
+				best_pwm_value = counter_length - 1;
+				best_period_numerator = period_numerator;
+			}
+		}
+	}
+
+	if (!best_clk_sel)
+		return -EINVAL;
+
+	chan->clk_sel = best_clk_sel;
+	chan->pre_div_exp = best_pwm_exp;
+	chan->pwm_value = best_pwm_value;
+	/* Frequency mode does not use PRE-DIV and PWM resolution settings. */
+	chan->pre_div_sel = 0;
+	chan->pwm_resolution_sel = 0;
+	chan->period = DIV_ROUND_UP_ULL(best_period_numerator,
+					lpg_clk_rates[best_clk_sel]);
+
+	return 0;
+}
+
 static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 {
 	unsigned int i, pwm_resolution_count, best_pwm_resolution_sel = 0;
@@ -575,6 +697,112 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 	chan->pwm_value = min(val, max);
 }
 
+static u64 lpg_pwm_duration_numerator(const struct lpg_channel *chan, bool duty_cycle)
+{
+	unsigned int resolution;
+	unsigned int pwm_value;
+
+	if (chan->enable_freq_mode) {
+		u64 period_numerator;
+
+		period_numerator = PWM_FM_PERIOD_NUMERATOR(chan->pre_div_exp, chan->pwm_value);
+		return duty_cycle ? period_numerator / 2 : period_numerator;
+	}
+
+	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM)
+		resolution = lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel];
+	else
+		resolution = lpg_pwm_resolution[chan->pwm_resolution_sel];
+
+	pwm_value = duty_cycle ? chan->pwm_value : BIT(resolution) - 1;
+	return (u64)NSEC_PER_SEC * pwm_value * lpg_pre_divs[chan->pre_div_sel] *
+		BIT(chan->pre_div_exp);
+}
+
+static bool lpg_pwm_config_has_smaller_timing_error(const struct lpg_channel *candidate,
+						    const struct lpg_channel *best)
+{
+	const unsigned int *clk_rates;
+	unsigned int candidate_clk_rate;
+	unsigned int best_clk_rate;
+	u64 candidate_duration_numerator;
+	u64 best_duration_numerator;
+	int period_comparison;
+	int duty_comparison;
+
+	clk_rates = candidate->subtype == LPG_SUBTYPE_HI_RES_PWM ?
+		lpg_clk_rates_hi_res : lpg_clk_rates;
+	candidate_clk_rate = clk_rates[candidate->clk_sel];
+	best_clk_rate = clk_rates[best->clk_sel];
+
+	/*
+	 * Both configurations are within the requested bounds, so the longer
+	 * period has the smaller error. Use duty only to break a period tie.
+	 */
+	candidate_duration_numerator =
+		lpg_pwm_duration_numerator(candidate, false);
+	best_duration_numerator =
+		lpg_pwm_duration_numerator(best, false);
+	period_comparison =
+		lpg_pwm_compare_candidate_duration(candidate_duration_numerator,
+						   candidate_clk_rate,
+						   best_duration_numerator,
+						   best_clk_rate);
+	if (period_comparison)
+		return period_comparison > 0;
+
+	candidate_duration_numerator =
+		lpg_pwm_duration_numerator(candidate, true);
+	best_duration_numerator =
+		lpg_pwm_duration_numerator(best, true);
+
+	duty_comparison =
+		lpg_pwm_compare_candidate_duration(candidate_duration_numerator,
+						  candidate_clk_rate,
+						  best_duration_numerator,
+						  best_clk_rate);
+
+	return duty_comparison > 0;
+}
+
+static int lpg_calc_pwm_state(struct lpg_channel *chan,
+			      const struct pwm_state *state)
+{
+	struct lpg_channel standard = *chan;
+	struct lpg_channel frequency = *chan;
+	u64 half_period_ns = state->period / 2;
+	int ret;
+
+	standard.enable_freq_mode = false;
+	ret = lpg_calc_freq(&standard, state->period);
+	if (!ret)
+		lpg_calc_duty(&standard, state->duty_cycle);
+
+	if (chan->freq_mode_capable &&
+	    (state->duty_cycle == half_period_ns ||
+	     state->duty_cycle == half_period_ns + (state->period & 1)) &&
+	    !lpg_calc_freq_in_freq_mode(&frequency, state->period,
+					 state->duty_cycle)) {
+		frequency.enable_freq_mode = true;
+		if (ret) {
+			*chan = frequency;
+			return 0;
+		}
+
+		if (lpg_pwm_config_has_smaller_timing_error(&standard, &frequency))
+			*chan = standard;
+		else
+			*chan = frequency;
+
+		return 0;
+	}
+
+	if (!ret)
+		*chan = standard;
+
+	return ret;
+}
+
 static void lpg_apply_freq(struct lpg_channel *chan)
 {
 	unsigned long val;
@@ -815,11 +1043,50 @@ static void lpg_apply_dtest(struct lpg_channel *chan)
 		     chan->dtest_value);
 }
 
-static void lpg_apply(struct lpg_channel *chan)
+static int lpg_apply_freq_mode(struct lpg_channel *chan)
 {
+	struct lpg *lpg = chan->lpg;
+	bool enable_freq_mode = false;
+
+	if (!chan->freq_mode_capable)
+		return 0;
+
+	if (chan->enable_freq_mode && chan->enabled)
+		enable_freq_mode = true;
+
+	return regmap_update_bits(lpg->map, chan->base + PWM_FM_MODE_REG,
+				  PWM_FM_ENABLE,
+				  enable_freq_mode ? PWM_FM_ENABLE : 0);
+}
+
+static int __lpg_apply(struct lpg_channel *chan, bool check_freq_mode)
+{
+	bool enable_freq_mode = chan->enable_freq_mode && chan->enabled;
+	unsigned int val;
+	int ret;
+
 	lpg_disable_glitch(chan);
+
+	if (check_freq_mode && chan->freq_mode_capable) {
+		ret = regmap_read(chan->lpg->map,
+				  chan->base + PWM_FM_MODE_REG, &val);
+		if (ret)
+			goto out_glitch;
+
+		if (!!(val & PWM_FM_ENABLE) != enable_freq_mode) {
+			ret = regmap_update_bits(chan->lpg->map,
+						 chan->base + PWM_ENABLE_CONTROL_REG,
+						 LPG_ENABLE_CONTROL_OUTPUT, 0);
+			if (ret)
+				goto out_glitch;
+		}
+	}
+
 	lpg_apply_freq(chan);
 	lpg_apply_pwm_value(chan);
+	ret = lpg_apply_freq_mode(chan);
+	if (ret && check_freq_mode)
+		goto out_glitch;
 	lpg_apply_control(chan);
 	lpg_apply_sync(chan);
 	if (chan->lpg->lpg_chan_sdam)
@@ -827,6 +1094,17 @@ static void lpg_apply(struct lpg_channel *chan)
 	else
 		lpg_apply_lut_control(chan);
 	lpg_enable_glitch(chan);
+
+	return 0;
+
+out_glitch:
+	lpg_enable_glitch(chan);
+	return ret;
+}
+
+static void lpg_apply(struct lpg_channel *chan)
+{
+	__lpg_apply(chan, false);
 }
 
 static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
@@ -1388,28 +1666,30 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+	struct lpg_channel config;
 	int ret = 0;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	mutex_lock(&lpg->lock);
+	guard(mutex)(&lpg->lock);
 
+	config = *chan;
+	config.enable_freq_mode = false;
 	if (state->enabled) {
-		ret = lpg_calc_freq(chan, state->period);
-		if (ret < 0)
-			goto out_unlock;
-
-		lpg_calc_duty(chan, state->duty_cycle);
+		ret = lpg_calc_pwm_state(&config, state);
+		if (ret)
+			return ret;
 	}
-	chan->enabled = state->enabled;
 
-	lpg_apply(chan);
+	config.enabled = state->enabled;
+	ret = __lpg_apply(&config, true);
+	if (ret)
+		return ret;
 
-out_unlock:
-	mutex_unlock(&lpg->lock);
+	*chan = config;
 
-	return ret;
+	return 0;
 }
 
 static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -1417,8 +1697,10 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+	bool freq_mode_enabled = false;
 	unsigned int resolution;
 	unsigned int pre_div;
+	unsigned int clk_idx;
 	unsigned int refclk;
 	unsigned int val;
 	unsigned int m;
@@ -1432,7 +1714,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
-		unsigned int clk_idx = FIELD_GET(PWM_CLK_SELECT_HI_RES_MASK, val);
+		clk_idx = FIELD_GET(PWM_CLK_SELECT_HI_RES_MASK, val);
 
 		if (clk_idx >= ARRAY_SIZE(lpg_clk_rates_hi_res))
 			return -EINVAL;
@@ -1440,7 +1722,8 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		refclk = lpg_clk_rates_hi_res[clk_idx];
 		resolution = lpg_pwm_resolution_hi_res[FIELD_GET(PWM_SIZE_HI_RES_MASK, val)];
 	} else {
-		refclk = lpg_clk_rates[FIELD_GET(PWM_CLK_SELECT_MASK, val)];
+		clk_idx = FIELD_GET(PWM_CLK_SELECT_MASK, val);
+		refclk = lpg_clk_rates[clk_idx];
 		resolution = lpg_pwm_resolution[FIELD_GET(PWM_SIZE_SELECT_MASK, val)];
 	}
 
@@ -1456,9 +1739,28 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
-						 pre_div * (1 << m), refclk);
-		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
+		if (chan->freq_mode_capable) {
+			ret = regmap_read(lpg->map, chan->base + PWM_FM_MODE_REG, &val);
+			if (ret)
+				return ret;
+
+			freq_mode_enabled = !!(val & PWM_FM_ENABLE);
+		}
+
+		if (freq_mode_enabled) {
+			u64 period_numerator;
+
+			pwm_value &= 0xff;
+			period_numerator = PWM_FM_PERIOD_NUMERATOR(m, pwm_value);
+			state->period = DIV_ROUND_UP_ULL(period_numerator, refclk);
+			state->duty_cycle = DIV_ROUND_UP_ULL(period_numerator / 2,
+							     refclk);
+		} else {
+			state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
+					((1 << resolution) - 1) * pre_div * (1 << m), refclk);
+			state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
+					pwm_value * pre_div * (1 << m), refclk);
+		}
 	} else {
 		state->period = 0;
 		state->duty_cycle = 0;
@@ -1646,7 +1948,8 @@ static int lpg_init_channels(struct lpg *lpg)
 {
 	const struct lpg_data *data = lpg->data;
 	struct lpg_channel *chan;
-	int i;
+	unsigned int status;
+	int ret, i;
 
 	for (i = 0; i < data->num_channels; i++) {
 		chan = &lpg->channels[i];
@@ -1658,6 +1961,14 @@ static int lpg_init_channels(struct lpg *lpg)
 		chan->sdam_offset = data->channels[i].sdam_offset;
 
 		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
+
+		if (chan->subtype == LPG_SUBTYPE_PWM && data->channels[i].freq_mode_capable) {
+			ret = regmap_read(lpg->map, chan->base + PWM_STATUS1_REG, &status);
+			if (ret < 0)
+				return ret;
+
+			chan->freq_mode_capable = !!(status & PWM_FM_PRESENT);
+		}
 	}
 
 	return 0;
@@ -1981,7 +2292,7 @@ static const struct lpg_data pm8350c_pwm_data = {
 		{ .base = 0xe800, .triled_mask = BIT(7), .sdam_offset = 0x48 },
 		{ .base = 0xe900, .triled_mask = BIT(6), .sdam_offset = 0x56 },
 		{ .base = 0xea00, .triled_mask = BIT(5), .sdam_offset = 0x64 },
-		{ .base = 0xeb00 },
+		{ .base = 0xeb00, .freq_mode_capable = true },
 	},
 };
 

-- 
2.43.0


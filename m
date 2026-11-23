Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417335;
	b=WL7+gXEbBgu5koB85byjEVBS1T5jpsLl4DKZ71tFPwxfGoCMHK3xOjdJIqXbM4f15GIa
	 ff9k8KRvOm/pYkkFQFZnbO4PLadus5ADQbVzmiRvRwYfibhpqvZ1inOGrFIzMtRIKsNZ6
	 gGCHGxrsT0eSCdYgo1VQHLrdlUk6zWMic1Yb/Swd3fJODafbBgO+bjAfN5G0oAEkoEF7a
	 p10b11+xfAMHPdIuUTy8cinfMuZGI8PbRyDfmG3tAzOY990aDHIyoxtQOfawu6GFjgBEN
	 V7kzXaYVKvWlsL5dd5OmveYl55dBG24XIDqCfVXEcqgl/uKEhchQCBScvSI6xSuHwww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K9JpqlfcL8HIucW/6j9l/B+Qv3MjaTxEvxst2jH2hUM=;
	b=F9W+977qgoio8ExiCOglPuZUjWGCEeHr/kMQzjVJV54a8Zwl4ElR3iDwtdL9BN1DZ3FA
	 4IVRczXaIYNSrIOkaNkndE1SOuNC+m29j08bbYj3M2DlAyUa6FWWZ7Sia1q17nvFhJ8mt
	 S3xZofoJLYjwHbhBM6UF2AtI3HJhFdosM2TZUnhxtQ07JK45r8I99OV6Dx51BdEu9iMMt
	 +zIQ35AChYAzYbFMz+c2uUFFVLWJv1QMHr7A3OjpyWvvY+G/Pdaw44L9HHY1+/W/y8xPW
	 0ytJ+FfpXVzuqCtHhKDmqBHqUSAMNfyaMhpePXa9gqJZklNVIBCCud7U+pC00yEIwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EqS5c6BG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMRbnSaO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A1606A6A3
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF5A1606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EqS5c6BG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMRbnSaO
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN68CmU1126878
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9JpqlfcL8HIucW/6j9l/B+Qv3MjaTxEvxst2jH2hUM=; b=EqS5c6BGLx+IWxei
	DzdqH9q7FuT3Mjfw2jvDZ+5W7zeamuFA97EnmH8xwYY6puxGNHuYIcvRxYaH/djy
	CDXzPh1csOl9PopQdtpIkscrFxnPe3IyN/acbfWwQ7sAXv17/DeT2orG4kj5nyuE
	Xua/x+vKYiQs0PaN6bTQBJ7g4glgRBBPqTnFG69Zr5hd66p/10GSDZq11ZbiVfYJ
	5bnikCFE57vqPGHqKH4fmdolLrRs27Az18qEavAsdo09au/sY8URNuMMVT6QNkFi
	w0zlRnUBfppn9VJvf6rxpjw2LwM7L6e+vwhMIMKbDa6Okr5bGwUZd+TN+3JkPdeM
	EiJ/pg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00644-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:13 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7de733fa9so3255723b6e.3
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795417333; x=1796022133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9JpqlfcL8HIucW/6j9l/B+Qv3MjaTxEvxst2jH2hUM=;
        b=aMRbnSaOgNnNelgp7XlllV5Unav4F1OKUl9Ylu6MzNNoaSEx31Q6vyDQNvy9aG+rO8
         rGOkecaUL88udti8vkLW3vFXzoaV+cQ+hsxZ6fAxZm1PXoOfAuydqxFZSXJKKaqYkVHQ
         VWRsytizF+cKlwlHmaSWXjc4RANPyMJYhS0heWdUZ/OvyTEkrmfydk2/URr1Mdo9J8sX
         nTHT03w2J0L/gvDw8DIWbJJZTwdYQ3zVAq7PFXo5HShN1+93aqs6KT6MdPX1AaTEuj5g
         fYNZbjYliDeTJunclXEWY9CrqMOg3SPtA8OnaL/0B5IqIuzscaxblCiER1lhmKkMJk78
         9uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417333; x=1796022133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9JpqlfcL8HIucW/6j9l/B+Qv3MjaTxEvxst2jH2hUM=;
        b=p038XvhwxPnwJBcETePe6LmoaM0ldWe5SZTZS2jCuA/NW+isvddglq18oGwWlax+iv
         44X/szbOXR6JeomFQTQfoUi3bUd+KWQFIbeSCjKZFFZJ/NkYZqYk7wLErMCfc25oaqhU
         ZrQxh96s/T2Cn7eA/nCMRvS3gAxN/NzTRMsav0lOHH3upa6HBLQjyWNiCl0VrIrCsDAO
         Cyvn5hmfK1xjl+ZW2UHNrQt6luW5bBxoXHn1Fo6Rt+6bi4t6N7iWTpHCr1HrnZMoAuMG
         wpWIbL9NoE6LekrmKI4Pt86tZmYTNnJHcx37Ii/jQD+Y5reBwTUSgb6Z1yHrkZX9N6Rl
         cafg==
X-Forwarded-Encrypted: i=1; AL+hErEuZjGCPkZui1/3Qw2YoVPRVxresZz49YqJYjfZ+cvn/G7SwcJXkdJoKswKkeo6LQnutCL/S8OR7qE=@vger.kernel.org
X-Gm-Message-State: APuU4Z//RzZc33xNB/61Yv0ovcbVDRirYfo6bqHt1/+jExwpBKC/dOJ2
	GEM8WFz491ex2RGXgu1LtP3pwTXFBiRGBnwl6xQtPoAxsJkRHdVw5OG+sQKOCwDuYhYe0+JKG9l
	u1JgwosZRF14gHwnJMcb/TfXWNuY/maBj3KFwFGEIWf6uvD8snMSiNNos9lDnH0o=
X-Gm-Gg: AZFdTZeG8rBsVVaiH6Ep523nCcLQ3rMVB+NFi554cpXAZNQeXGnT4SS8Uuqv/G2szxY
	phYnhtDeZd9HoZ0WQZS2/KKYaWcsTdRs0BA9ZnuZN+j5BLY6fZqKnL7ABeThUucLgQZxfAfetuv
	3vPKPxfN403Bo51Mt2jJJ5kXE6xkHwHWkgQ+28sciTphijB3YNuqtUZxKwyohwgoHadGB/BtWKR
	uxNeLyvfzYXi52R41b0lDP9QCD/wSm2kByDf9sjEAz26X33/HYJDI+EkOGsZJkAuaaVR/FXDevd
	iDYur5FI7VzI300cEpenjd+Ep6tzL8e2+mSKfa2AEf4Thx5EoVH6Kdmc6vf26dLGdnoMgjiv3TZ
	z2OX18QGaiFHG/z4LZeeH/CQNz4FNtnzTQ5jobbi5msXmyOd82uK2AtMEfQZVpWSNQQyJuVKH4J
	Y/pfVkvUAZirx3zJmQ+LAOA4UXtw==
X-Received: by 2002:a05:6808:1a1f:b0:4d6:93c3:3e8e with SMTP id 5614622812f47-57a0d2e7173mr10159734b6e.65.1795417332480;
        Sun, 22 Nov 2026 23:02:12 -0800 (PST)
X-Received: by 2002:a05:6808:1a1f:b0:4d6:93c3:3e8e with SMTP id 5614622812f47-57a0d2e7173mr10159713b6e.65.1795417331881;
        Sun, 22 Nov 2026 23:02:11 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8817213b6e.17.2026.11.22.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:11 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 23:02:04 -0800
Subject: [PATCH v3 2/4] leds: rgb: leds-qcom-lpg: Fix LED color balancing
 in HW pattern mode
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
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v3-2-f911edd40a31@oss.qualcomm.com>
References: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v3-0-f911edd40a31@oss.qualcomm.com>
In-Reply-To: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v3-0-f911edd40a31@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Griffin Kroah-Hartman <griffin@kroah.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795417325; l=17695;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=aSccxiislBtC+X867wOC55ZGgpMDY72xsssQhTbwWQ4=;
 b=9odSjzs6LoCyOxmzvaHu4X/a1AEj9v6hUDdOfhszTILy9E9naDWKvA8Jk2k4ZfauDjPMYlP8P
 gLJkGIq8UgvCJ5qm4yUS8rHI2t2Kl49z8Ssl0bNvlzXMssDw3amJVbQ
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX+4ahDxBztDrz
 uDSPn0zfylDyVcRdjOiYsDTqHQf2OJd9wG79TBpbdITa/iclTVky5cPAk08YcdnV6RgNZX+XfaC
 YwuyUF6QcppZthABDoBCnY5n15gncrLWvHfG0l62HGhw+GofVfo55C02Wo6yxquVGu3I4pRO+ml
 AChn/PnfHOZSYqtkLWedvnaIIoQP+8AsOEzocGx3RTgbct51Bp3sc6SlvyO+jTXkCDC9IQUfiwv
 i5JVmfdAq6ngvq1+YZW7MNJ0xDt+g050MAkxs+c7OOydyReqF5YwGNVq0pq65F/nfgsDccWWWG4
 8Axqs5q5WX/ffxJF8rcdabMxZXasIxlWTy/5dlZ1kOFgZp4nUyj66JPz2bcZ3OZqA+G1if/1hUt
 AL18Z9ISac8MleCPL93xiO2rWDazt7S87sBJxkBhkjFaDREBH/CSXBpRxma3aJtAx3QSRdgdy+z
 WWSkLJmeSo3tQ8en06w==
X-Proofpoint-ORIG-GUID: wUprRKbuhrAGj81N1HMNg3bUDvKI3kw_
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b03e4f5 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZLilY_8t9WCuVEyZRTcA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: wUprRKbuhrAGj81N1HMNg3bUDvKI3kw_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX3mD2vjkiEbm5
 8nVsAtGjoQAtBpOKrlSJZzu1x5bg5X+nqixSX7CBRLX4jSEHve77MAFqxj4KtTBBzROaJl4fS9P
 RBLlNBq2fnWFtDfwrMUCx9MNj5Bng38=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

The multicolor hardware-pattern path has two related issues.

First, lpg_pattern_set() programs one unscaled LUT and assigns it to
every LPG channel. RGB and multicolor LEDs therefore replay identical
brightness values regardless of multi_intensity, making the output
white-balanced rather than preserving the requested color.

Fix this by normalizing the requested pattern once, scaling its
brightness values for each enabled sub-LED, and allocating and
programming a separate LUT range for every active LPG channel. Stop the
channels before replacing or releasing their LUTs, and roll back all
per-channel allocations if an update fails.

Second, a pattern is scaled only when it is installed. Updating
brightness or multi_intensity while it is active leaves already-enabled
channels with stale LUT values. A channel that was disabled when the
pattern was installed has no LUT and falls back to static PWM when it is
enabled later.

Fix this by caching the normalized, unscaled pattern and repeat state.
On each multicolor brightness callback, stop the running pattern,
release its per-channel LUTs, rebuild them from the current sub-LED
intensities, and restart the active channels. Clear the cached active
state when the pattern is removed.

The second issue was identified and fixed by OpenAI Codex when I used
it to review the original change.

Both of the fixes have been tested on a Maili QRD device and confirmed
that the HW pattern of a multicolor LED could be scaled and refreshed
correctly whenever hw_pattern, brightness, multi_intensity were updated.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Fixes: 6ab1f766a80a ("leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM")
Fixes: 5e9ff626861a ("leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT SDAM")
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/leds/leds-qcom-lpg.rst |   9 +
 drivers/leds/rgb/leds-qcom-lpg.c     | 324 ++++++++++++++++++++++++++++-------
 2 files changed, 275 insertions(+), 58 deletions(-)

diff --git a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/leds-qcom-lpg.rst
index d6a76c38c581..e83d8dde7eab 100644
--- a/Documentation/leds/leds-qcom-lpg.rst
+++ b/Documentation/leds/leds-qcom-lpg.rst
@@ -39,6 +39,15 @@ described below). As the LPG hardware is not able to perform the linear
 transitions expected by the leds-trigger-pattern format, each entry in the
 pattern must be followed a zero-length entry of the same brightness.
 
+For multicolor LEDs, each pattern brightness value is scaled by the component
+brightness calculated from the global ``brightness`` and ``multi_intensity``
+values. A component whose calculated brightness is zero does not have a LUT
+range allocated. Consequently, if ``hw_pattern`` is configured while global
+brightness is zero, the pattern is cached but no LUT range is programmed until
+a brightness or intensity update produces a nonzero component brightness.
+Changing either value while a hardware pattern is active rebuilds the
+per-component LUT ranges.
+
 Simple pattern::
 
     "255 500 255 0 0 500 0 0"
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 5a63f3bc5dcf..eec942f2af6c 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -151,11 +151,32 @@ struct lpg_channel {
 	bool has_lut;
 };
 
+/**
+ * struct lpg_pattern - The LPG pattern normalized from the LED pattern
+ * @data:	The pattern data array
+ * @len:	number of entries to write to the LUT
+ * @delta_t:	common step duration in ms
+ * @lo_pause:	low-pause duration in ms
+ * @hi_pause:	high-pause duration in ms
+ * @ping_pong:	true if the pattern support reverse
+ */
+struct lpg_pattern {
+	struct led_pattern *data;
+	unsigned int len;
+	unsigned int delta_t;
+	unsigned int lo_pause;
+	unsigned int hi_pause;
+	bool ping_pong;
+};
+
 /**
  * struct lpg_led - logical LED object
  * @lpg:		lpg context reference
  * @cdev:		LED class device
  * @mcdev:		Multicolor LED class device
+ * @pattern:		unscaled active multicolor pattern; zero length when inactive
+ * @scaled_pattern:	scratch buffer for per-channel LUT updates
+ * @pattern_oneshot:	whether the cached pattern is played only once
  * @channels:		list of channels associated with the LED
  * @num_channels:	number of @channels
  */
@@ -164,6 +185,9 @@ struct lpg_led {
 
 	struct led_classdev cdev;
 	struct led_classdev_mc mcdev;
+	struct lpg_pattern pattern;
+	struct led_pattern *scaled_pattern;
+	bool pattern_oneshot;
 
 	unsigned int num_channels;
 	struct lpg_channel *channels[] __counted_by(num_channels);
@@ -179,6 +203,7 @@ struct lpg_led {
  * @lut_base:	base address of the LUT block (optional)
  * @lut_size:	number of entries in the LUT block
  * @lut_bitmap:	allocation bitmap for LUT entries
+ * @lut_bitmap_tmp: scratch bitmap for LUT allocation preflight
  * @pbs_dev:	PBS device
  * @lpg_chan_sdam:	LPG SDAM peripheral device
  * @lut_sdam:	LUT SDAM peripheral device
@@ -203,6 +228,7 @@ struct lpg {
 	u32 lut_base;
 	u32 lut_size;
 	unsigned long *lut_bitmap;
+	unsigned long *lut_bitmap_tmp;
 
 	struct pbs_dev *pbs_dev;
 	struct nvmem_device *lpg_chan_sdam;
@@ -876,18 +902,25 @@ static int lpg_brightness_single_set(struct led_classdev *cdev,
 	return 0;
 }
 
+static int lpg_pattern_mc_update(struct lpg_led *led);
+
 static int lpg_brightness_mc_set(struct led_classdev *cdev,
 				 enum led_brightness value)
 {
 	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
 	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	int ret = 0;
 
-	mutex_lock(&led->lpg->lock);
+	guard(mutex)(&led->lpg->lock);
 
 	led_mc_calc_color_components(mc, value);
-	lpg_brightness_set(led, cdev, mc->subled_info);
+	if (led->pattern.len) {
+		ret = lpg_pattern_mc_update(led);
+		if (ret)
+			return ret;
+	}
 
-	mutex_unlock(&led->lpg->lock);
+	lpg_brightness_set(led, cdev, mc->subled_info);
 
 	return 0;
 }
@@ -966,23 +999,16 @@ static int lpg_blink_mc_set(struct led_classdev *cdev,
 	return ret;
 }
 
-static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
-			   u32 len, int repeat)
+static int lpg_prepare_pattern(struct lpg *lpg,
+			       struct led_pattern *led_pattern, u32 len,
+			       int repeat, struct lpg_pattern *prep)
 {
-	struct lpg_channel *chan;
-	struct lpg *lpg = led->lpg;
-	struct led_pattern *pattern;
 	unsigned int brightness_a;
 	unsigned int brightness_b;
-	unsigned int hi_pause = 0;
-	unsigned int lo_pause = 0;
 	unsigned int actual_len;
 	unsigned int delta_t;
-	unsigned int lo_idx;
-	unsigned int hi_idx;
 	unsigned int i;
 	bool ping_pong = true;
-	int ret = -EINVAL;
 
 	/* Hardware only support oneshot or indefinite loops */
 	if (repeat != -1 && repeat != 1)
@@ -1002,15 +1028,16 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	if (len % 2)
 		return -EINVAL;
 
-	pattern = kzalloc_objs(*pattern, len / 2);
+	struct led_pattern *pattern __free(kfree) = kzalloc_objs(*pattern, len / 2);
+
 	if (!pattern)
 		return -ENOMEM;
 
 	for (i = 0; i < len; i += 2) {
 		if (led_pattern[i].brightness != led_pattern[i + 1].brightness)
-			goto out_free_pattern;
+			return -EINVAL;
 		if (led_pattern[i + 1].delta_t != 0)
-			goto out_free_pattern;
+			return -EINVAL;
 
 		pattern[i / 2].brightness = led_pattern[i].brightness;
 		pattern[i / 2].delta_t = led_pattern[i].delta_t;
@@ -1023,7 +1050,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * through the entire LUT, so prohibit this.
 	 */
 	if (len < 2)
-		goto out_free_pattern;
+		return -EINVAL;
 
 	/*
 	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
@@ -1080,13 +1107,13 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 			 * specify hi pause. Reject other variations.
 			 */
 			if (i != actual_len - 1)
-				goto out_free_pattern;
+				return -EINVAL;
 		}
 	}
 
 	/* LPG_RAMP_DURATION_REG is a 9bit */
 	if (delta_t >= BIT(9))
-		goto out_free_pattern;
+		return -EINVAL;
 
 	/*
 	 * Find "low pause" and "high pause" in the pattern in the LUT case.
@@ -1094,44 +1121,65 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * duration of all steps.
 	 */
 	if (lpg->lut_base || lpg->lut_sdam) {
-		lo_pause = pattern[0].delta_t;
-		hi_pause = pattern[actual_len - 1].delta_t;
+		prep->lo_pause = pattern[0].delta_t;
+		prep->hi_pause = pattern[actual_len - 1].delta_t;
 	} else {
 		if (delta_t != pattern[0].delta_t || delta_t != pattern[actual_len - 1].delta_t)
-			goto out_free_pattern;
+			return -EINVAL;
+		prep->lo_pause = 0;
+		prep->hi_pause = 0;
 	}
 
+	prep->data = no_free_ptr(pattern);
+	prep->len = actual_len;
+	prep->delta_t = delta_t;
+	prep->ping_pong = ping_pong;
 
-	mutex_lock(&lpg->lock);
+	return 0;
+}
+
+static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
+			   u32 len, int repeat)
+{
+	struct lpg_channel *chan;
+	struct lpg *lpg = led->lpg;
+	struct lpg_pattern pattern;
+	unsigned int lo_idx;
+	unsigned int hi_idx;
+	unsigned int i;
+	int ret;
+
+	ret = lpg_prepare_pattern(lpg, led_pattern, len, repeat, &pattern);
+	if (ret < 0)
+		return ret;
+
+	struct led_pattern *prep_data __free(kfree) = pattern.data;
+
+	guard(mutex)(&lpg->lock);
 
 	if (lpg->lut_base)
-		ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+		ret = lpg_lut_store(lpg, prep_data, pattern.len, &lo_idx, &hi_idx);
 	else
-		ret = lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+		ret = lpg_lut_store_sdam(lpg, prep_data, pattern.len, &lo_idx, &hi_idx);
 
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];
 
-		chan->ramp_tick_ms = delta_t;
-		chan->ramp_ping_pong = ping_pong;
+		chan->ramp_tick_ms = pattern.delta_t;
+		chan->ramp_ping_pong = pattern.ping_pong;
 		chan->ramp_oneshot = repeat != -1;
 
-		chan->ramp_lo_pause_ms = lo_pause;
-		chan->ramp_hi_pause_ms = hi_pause;
+		chan->ramp_lo_pause_ms = pattern.lo_pause;
+		chan->ramp_hi_pause_ms = pattern.hi_pause;
 
 		chan->pattern_lo_idx = lo_idx;
 		chan->pattern_hi_idx = hi_idx;
 		chan->has_lut = true;
 	}
 
-out_unlock:
-	mutex_unlock(&lpg->lock);
-out_free_pattern:
-	kfree(pattern);
-
 	return ret;
 }
 
@@ -1151,50 +1199,196 @@ static int lpg_pattern_single_set(struct led_classdev *cdev,
 	return 0;
 }
 
-static int lpg_pattern_mc_set(struct led_classdev *cdev,
-			      struct led_pattern *pattern, u32 len,
-			      int repeat)
+/* Caller must hold lpg->lock. Stop all readers before releasing their LUTs. */
+static int lpg_pattern_stop(struct lpg_led *led)
 {
-	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
-	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	struct lpg *lpg = led->lpg;
+	struct lpg_channel *chan;
 	unsigned int triled_mask = 0;
-	int ret, i;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < led->num_channels; i++)
 		triled_mask |= led->channels[i]->triled_mask;
-	triled_set(led->lpg, triled_mask, 0);
-
-	ret = lpg_pattern_set(led, pattern, len, repeat);
-	if (ret < 0)
+	ret = triled_set(lpg, triled_mask, 0);
+	if (ret)
 		return ret;
 
-	led_mc_calc_color_components(mc, LED_FULL);
-	lpg_brightness_set(led, cdev, mc->subled_info);
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		ret = lpg_sdam_configure_triggers(chan, 0);
+		if (ret < 0)
+			return ret;
+		ret = regmap_update_bits(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG,
+					 LPG_ENABLE_CONTROL_OUTPUT |
+					 LPG_ENABLE_CONTROL_RAMP_GEN, 0);
+		if (ret)
+			return ret;
+		ret = lpg_clear_pbs_trigger(lpg, chan->lut_mask);
+		if (ret)
+			return ret;
+
+		chan->enabled = false;
+		chan->ramp_enabled = false;
+	}
 
 	return 0;
 }
 
-static int lpg_pattern_clear(struct lpg_led *led)
+/* Caller must hold lpg->lock. */
+static int lpg_pattern_mc_preflight(struct lpg_led *led)
 {
+	struct led_classdev_mc *mc = &led->mcdev;
+	struct lpg_pattern *pattern = &led->pattern;
+	struct lpg *lpg = led->lpg;
 	struct lpg_channel *chan;
+	unsigned int idx;
+	unsigned int i;
+	int len;
+
+	bitmap_copy(lpg->lut_bitmap_tmp, lpg->lut_bitmap, lpg->lut_size);
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		if (!chan->has_lut)
+			continue;
+
+		len = chan->pattern_hi_idx - chan->pattern_lo_idx + 1;
+		bitmap_clear(lpg->lut_bitmap_tmp, chan->pattern_lo_idx, len);
+	}
+
+	for (i = 0; i < led->num_channels; i++) {
+		if (!mc->subled_info[i].brightness)
+			continue;
+
+		idx = bitmap_find_next_zero_area(lpg->lut_bitmap_tmp, lpg->lut_size,
+						 0, pattern->len, 0);
+		if (idx >= lpg->lut_size)
+			return lpg->lut_base ? -ENOMEM : -ENOSPC;
+
+		bitmap_set(lpg->lut_bitmap_tmp, idx, pattern->len);
+	}
+
+	return 0;
+}
+
+/* Caller must hold lpg->lock. */
+static int lpg_pattern_mc_update(struct lpg_led *led)
+{
+	struct led_classdev_mc *mc = &led->mcdev;
+	struct led_classdev *cdev = &mc->led_cdev;
+	struct lpg_pattern *pattern = &led->pattern;
+	struct led_pattern *scaled = led->scaled_pattern;
 	struct lpg *lpg = led->lpg;
-	int i;
+	struct lpg_channel *chan;
+	unsigned int lo_idx, hi_idx;
+	unsigned int i, j;
+	int ret;
 
-	mutex_lock(&lpg->lock);
+	ret = lpg_pattern_mc_preflight(led);
+	if (ret)
+		return ret;
 
-	chan = led->channels[0];
-	lpg_lut_free(chan);
+	ret = lpg_pattern_stop(led);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < led->num_channels; i++)
+		lpg_lut_free(led->channels[i]);
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];
-		lpg_sdam_configure_triggers(chan, 0);
-		lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
-		chan->pattern_lo_idx = 0;
-		chan->pattern_hi_idx = 0;
-		chan->has_lut = false;
+
+		/* Ignore pattern config for 0 brightness channel */
+		if (!mc->subled_info[i].brightness)
+			continue;
+
+		/* Rebuild the pattern based on component brightness. */
+		for (j = 0; j < pattern->len; j++) {
+			scaled[j].brightness =
+				DIV_ROUND_CLOSEST((u32)pattern->data[j].brightness *
+						  mc->subled_info[i].brightness,
+						  cdev->max_brightness);
+			scaled[j].delta_t = pattern->data[j].delta_t;
+		}
+
+		if (lpg->lut_base)
+			ret = lpg_lut_store(lpg, scaled, pattern->len, &lo_idx, &hi_idx);
+		else
+			ret = lpg_lut_store_sdam(lpg, scaled, pattern->len, &lo_idx, &hi_idx);
+		if (ret < 0)
+			goto out_free;
+
+		chan->ramp_tick_ms = pattern->delta_t;
+		chan->ramp_ping_pong = pattern->ping_pong;
+		chan->ramp_oneshot = led->pattern_oneshot;
+		chan->ramp_lo_pause_ms = pattern->lo_pause;
+		chan->ramp_hi_pause_ms = pattern->hi_pause;
+		chan->pattern_lo_idx = lo_idx;
+		chan->pattern_hi_idx = hi_idx;
+		chan->has_lut = true;
 	}
 
-	mutex_unlock(&lpg->lock);
+	return 0;
+
+out_free:
+	for (i = 0; i < led->num_channels; i++)
+		lpg_lut_free(led->channels[i]);
+	return ret;
+}
+
+static int lpg_pattern_mc_set(struct led_classdev *cdev,
+			      struct led_pattern *led_pattern, u32 len,
+			      int repeat)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	struct lpg *lpg = led->lpg;
+	struct lpg_pattern pattern;
+	int ret;
+
+	ret = lpg_prepare_pattern(lpg, led_pattern, len, repeat, &pattern);
+	if (ret < 0)
+		return ret;
+
+	struct led_pattern *prep_data __free(kfree) = pattern.data;
+
+	if (pattern.len > lpg->lut_size)
+		return -EINVAL;
+
+	guard(mutex)(&lpg->lock);
+
+	memcpy(led->pattern.data, prep_data, pattern.len * sizeof(*prep_data));
+	pattern.data = led->pattern.data;
+	led->pattern = pattern;
+	led->pattern_oneshot = repeat != -1;
+
+	ret = lpg_pattern_mc_update(led);
+	if (ret) {
+		led->pattern.len = 0;
+		return ret;
+	}
+
+	lpg_brightness_set(led, cdev, mc->subled_info);
+
+	return 0;
+}
+
+static int lpg_pattern_clear(struct lpg_led *led)
+{
+	struct lpg *lpg = led->lpg;
+	unsigned int i;
+	int ret;
+
+	guard(mutex)(&lpg->lock);
+
+	ret = lpg_pattern_stop(led);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < led->num_channels; i++)
+		lpg_lut_free(led->channels[i]);
+	led->pattern.len = 0;
 
 	return 0;
 }
@@ -1433,6 +1627,17 @@ static int lpg_add_led(struct lpg *lpg, struct fwnode_handle *fw)
 
 		/* Register pattern accessors if we have a LUT block or when using PPG */
 		if (lpg->lut_base || lpg->lpg_chan_sdam) {
+			led->pattern.data = devm_kcalloc(lpg->dev, lpg->lut_size,
+							 sizeof(*led->pattern.data), GFP_KERNEL);
+			if (!led->pattern.data)
+				return -ENOMEM;
+
+			led->scaled_pattern = devm_kcalloc(lpg->dev, lpg->lut_size,
+							   sizeof(*led->scaled_pattern),
+							   GFP_KERNEL);
+			if (!led->scaled_pattern)
+				return -ENOMEM;
+
 			cdev->pattern_set = lpg_pattern_mc_set;
 			cdev->pattern_clear = lpg_pattern_mc_clear;
 		}
@@ -1549,6 +1754,9 @@ static int lpg_init_lut(struct lpg *lpg)
 	lpg->lut_bitmap = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
 	if (!lpg->lut_bitmap)
 		return -ENOMEM;
+	lpg->lut_bitmap_tmp = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
+	if (!lpg->lut_bitmap_tmp)
+		return -ENOMEM;
 
 	return 0;
 }

-- 
2.43.0


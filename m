Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907954;
	b=yF9FUdYJ8s0XErLiVrRxldsEJyDLOodO+zFEeqLNCjUFS38/m3+c1NqB/op6oSgxZkeV
	 kcFw+4fA/cLBjX0rHR6MwPKsCdNivA+B5VYnZ3NaGKnuEANt0Lm3e1x1Bh3fDnkp/ibKH
	 y8oZzq1ljPAbvbfghF4rkVHrF8G5U9T4bmwB01zmHcrMEvzNQuB53mNNxb/3iknnTm0PX
	 FHq7iWCHnj2GvoT7vTRPo3MXBTy8EqjJtnLNoR4k2zRcIJq3H4QUYeuBUsCUDW2bwFaWO
	 CTPKQh5nDJwToS0UHsA32oBgWjrx9KC1VP7zIZyWCU818+16Oz5c+fS/qtCZ+LLfngw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907954;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zkgm1t7dXdy8TcgUYM4rsV7MD9YhFwG+4zqMKohsKV0=;
	b=Bd5WypW0b6vfJHFBnpUk4k8i9mjY56J3uhzgyi5nwAA6Pk02SfrfQ0PtAg/0sNzOxb30
	 FH10p2V+5Ac2iCKRmWuEY8Xhenc+GtWQDDYBVe1U0XVLmD2EX7b10YMNwyy2rOI1T3B9N
	 A7FtfBVZ8ImUgzgcyE9Q4ZdqeDUoberyL8AXTG5Z824Yvq3rru585kNwa8QGaCh/3M4fQ
	 Jh4Z7MNsO6jaRnRFQGVxSeD96WNZev+uecO3leH+LC1XyW2oQVi1vnBpKz6XVsV91IhAF
	 qJ65cVtzXtZFSym+9UoT4dEba/drh2lT99zi4UbP/5sMlKqMb6JFIDLy3NmeY7aQq+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPxwQKau;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B9pmi6fV;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AF606A88A
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 365AF606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPxwQKau;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B9pmi6fV
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH6f0vV2998611
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zkgm1t7dXdy8TcgUYM4rsV7MD9YhFwG+4zqMKohsKV0=; b=ZPxwQKauFs7WJ+4Y
	EMyRHC/myb44S9B132SesqbUeZ7Mr+9zbODjeFUUhtTLhcFZEqghODfYctZiWY4K
	K8hQddKPu3OU7r4q+mSZY3E5l+BJLCzj4ziA8PXiAETq3IZ3fvWdu58j+YH9GnYB
	3SiUY0qxgCgMNg1U/wDYNtNdFg568+4cyDa9yQteAbeDExbsWDrXP7xt5HEPig7R
	QLIv9nsS34lammcc0fNthESM8Y4w3oJP7ksvc8SskFM5xd+sGxvhrg+qZ3AMeA1o
	OaCqSelXp5WQKNLKx2F9YGF4fo6jdCjq5RUc+pOzqxtX6CjoQGrDo2w/Ps+jd3bx
	MqA+bg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve0pax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:32 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-49e5451d6a5so4225159fac.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 01:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794907952; x=1795512752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkgm1t7dXdy8TcgUYM4rsV7MD9YhFwG+4zqMKohsKV0=;
        b=B9pmi6fVsFFYGYwnqBA0lWSugbglm3nX9DDobrRokxpBxUImHuVhnal5w11zKFkb11
         PZzH2nqbArvvZnwC5kEaXo4TUEx0dgZZ7VbGvFEdQhNPN1FtnINszI4xXMJrpPsEvUNc
         PepE5Reqxt9aV5rtVNV93bY7zXLt/QCjjNRS9+bivppQpnzPHlQ8wpzqrj789B7YynDm
         RyIepe6Qxm8MDo5biR93lGahoKp+Q23Hg86+1W56x+JQaTgv8NOoGPntNQkVrdM0wuMn
         tImx4okIFMVBXTiTQWLUn2zWaOh1w4tDBBqk+r4471d3yDu/f62Gd0hF5cNnl2gnPh7n
         Jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907952; x=1795512752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkgm1t7dXdy8TcgUYM4rsV7MD9YhFwG+4zqMKohsKV0=;
        b=yC7NzQ4onsasS8O1wict1t9WdYygMcY/6EaTunBoQCCAOScEP8vV5ux9Ekd+qzyIrO
         Cw2r6JNHe6RJZ0Cl/y2/EKSpXpv+i470bFYQB4R/Unt2KJ1cadrFWCWA1F8tEZue44+t
         bdw7Y6iVCda9EQj03oHJZXIqoSQN8DNMRLmXRxeamrejSxWTw55j1M8X1zLCgrSi05+b
         62MDzNkkPeALxYtbzQSqhG7vyEiMsGZYTHouWP4L9fbmr6Fxj1Z0n5vuJ3XcZVPCI3Ed
         /jclCmJTebXkHsI8G0xFt1YBJRkGR1G1sQu+uD5NviyO5x0HA37PTq7PRnqQ5XM/Zwfr
         OgRQ==
X-Forwarded-Encrypted: i=1; AL+hErGLksZSFs8vLPQpS1L/Fi+hEyCrMTrjbWzCIY3ZXwhKBSuhTyFrGEHLd2RdsZbql7YlDjmzKjHUfAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L8NRW5MUuluXKfYAfaCA46pw14d8SjstM4Gv6dFj99G3T1iGY
	9F0Vx+ujF45vFal+Eui6B2bOdhLYizkOz32g1pfXtnH2cNQoCML9Ly1XSxC/uSOd4C6CAcqYDRc
	STYBzpMiJl0akVfCqbeY1+5Bp3ygurMoIhCSuz633MucRnPzJSNcuX5CRgxTYxWqCFWbgDxh/Mw
	==
X-Gm-Gg: AYBFou2EpRLtGHyomejEZOsNX0E/AhjtJatKkq6oniY8B1wdNxFiJ2REIsW3h+nof4j
	Bs2rFR5bpPvBKjQjXTK3Uh8O0nBtSkPm6mgzXQOUZPrIZG1Xo5rnJqs+ZN22PdYnf2khfwM6/b4
	mjsyOCnbecPrvkY8XkDDshJpI8wjgEYb86Z7hqbtOfNsBTGTgKN0wZVDtTvSBZcOu3nHxPwMudy
	ThoBNJbovjsG+99ZHX9YZ8LF+Se6YcnRojBbwiXbiL2LQakSOarFYMecMUUraVRr9D+pOpUHHF5
	enTE1JaqXjVt01/p17p4hbUOhn8wrrBg+Jxc/ZZKV32qzQap20+um8vnu+dTOTKcN0nxF9eCC+S
	BK6R2zAGmAlfMOLQHboamGToFxFeQnE6Cj/AsxvrISMKHuAA/d5O+wry+nPXqR3SmwVlGDUWPlr
	tuSauPOjjU/8qZ2vLjPzIu5Ffb
X-Received: by 2002:a05:6870:c2a8:b0:4a7:4324:1814 with SMTP id 586e51a60fabf-4afdf4eed55mr10942754fac.59.1794907951674;
        Tue, 17 Nov 2026 01:32:31 -0800 (PST)
X-Received: by 2002:a05:6870:c2a8:b0:4a7:4324:1814 with SMTP id 586e51a60fabf-4afdf4eed55mr10942736fac.59.1794907951129;
        Tue, 17 Nov 2026 01:32:31 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2206dc0sm8678928fac.5.2026.11.17.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:32:30 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 01:31:33 -0800
Subject: [PATCH 1/4] leds: rgb: leds-qcom-lpg: Fix single-entry LUT leak
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
Message-Id: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-1-7a862240683f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907947; l=2942;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=bMmJtTuFOhspQ50/s2y2wIQI3rsaWPAH5XFVb9ltZa8=;
 b=5RZKvwuLTDfyyHFtUe+m8WLbDkFyGodk1XemXgtwcBiJQkYhFq+E/FYdTR4CXMLo8e4Qk8ekD
 y5UI9w5nj5JBMWbOO1BLavbfpwnC/qTHQcaA0yiq3rGfBrZzaqcxwbX
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXxZfZQKnLDMTo
 TTYaJCwly30aTIdup/VIckSdGjX8iipIVC2NKCRnhfs+d+M4FyviKXV7qeWPTthLrR+SjJ3wF/A
 jYYmBoDAEuY29hLx6L5NO+Ei32+4YNI=
X-Proofpoint-GUID: 6soq7Bj1txYmbkxXZ1q-ZCY7Iw9sPeec
X-Proofpoint-ORIG-GUID: 6soq7Bj1txYmbkxXZ1q-ZCY7Iw9sPeec
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc1f30 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kaEj7Wm-z18sYFa5t94A:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX2EfuSkVyKTnG
 26RgVS3djHHOrjnSH5vCw2l7JQag5kdkdfkeT2J3IE+elDwQuXw+2W3vgdTgnmaDCo+Wm/RdYvy
 FGUpdzaIlqyb6ZKwhbuVqpHFpV5inlVpFSllTC68Z8tERrd2F8/v7B1W6uRAD4vrFQ0A5Oqwerv
 5Hac/GJ5WIwD4oIY3lFNq7c/AHIBu29pvOaW+s5RtNocdgnWvR+BwX4u0fUm7kOUoJ1Rova0kGi
 BEXkGmw+8TK1xdyJTd76wicmQzN5i9heX205/t3YPHaRPqVA4OBL/xD20SQrneed7+ZH9i9BAS+
 PHknT8h+g/4pAcJebdUsU3WgWNtajtZvnmZ9aaakoUnWWYmwADPSHtsB2pfLygDFT5UsYQEw6sO
 MN2OdvyYPbHwsdWNxkkgSh70DlFuu8IHlz1D/wFGZ8JtNjtUu0jVEwogyff4KAC2NLAH3J6Cl/P
 Fzm/c/HLv2S0dEHZicA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170037

The LUT resource cleanup path currently treats identical high and
low indices as an unallocated range and skips clearing the bitmap
allocation. However, with a 2-step palindrome pattern, the high
and low indices are identical, which can leak the LUT resource
because the bitmap allocation remains uncleared.

Resolve this by tracking LUT ownership separately from the index
range. Designate the first channel as the owner of shared
allocations and each active multicolor channel as the owner
of its per-channel allocation, then track this ownership state
for both normal cleanup and allocation.

Fixes: 24e2d05d1b689 ("leds: Add driver for Qualcomm LPG")
Closes: https://lore.kernel.org/linux-leds/7e474cdf-fcb2-468d-844d-f8afb5976d16@oss.qualcomm.com/
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 24ffe079f221..e14a3316bf22 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -111,6 +111,7 @@ struct lpg_data;
  * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over pattern
  * @pattern_lo_idx: start index of associated pattern
  * @pattern_hi_idx: last index of associated pattern
+ * @has_lut: channel has the associated LUT allocation
  */
 struct lpg_channel {
 	struct lpg *lpg;
@@ -147,6 +148,7 @@ struct lpg_channel {
 
 	unsigned int pattern_lo_idx;
 	unsigned int pattern_hi_idx;
+	bool has_lut;
 };
 
 /**
@@ -393,15 +395,19 @@ static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
 	return 0;
 }
 
-static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_idx)
+static void lpg_lut_free(struct lpg_channel *chan)
 {
+	struct lpg *lpg = chan->lpg;
 	int len;
 
-	len = hi_idx - lo_idx + 1;
-	if (len == 1)
-		return;
+	if (chan->has_lut) {
+		len = chan->pattern_hi_idx - chan->pattern_lo_idx + 1;
+		bitmap_clear(lpg->lut_bitmap, chan->pattern_lo_idx, len);
+	}
 
-	bitmap_clear(lpg->lut_bitmap, lo_idx, len);
+	chan->pattern_lo_idx = 0;
+	chan->pattern_hi_idx = 0;
+	chan->has_lut = false;
 }
 
 static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
@@ -1118,6 +1124,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 
 		chan->pattern_lo_idx = lo_idx;
 		chan->pattern_hi_idx = hi_idx;
+		/* The 1st channel owns the LUT while other channels share it */
+		chan->has_lut = i == 0;
 	}
 
 out_unlock:
@@ -1176,7 +1184,7 @@ static int lpg_pattern_clear(struct lpg_led *led)
 	mutex_lock(&lpg->lock);
 
 	chan = led->channels[0];
-	lpg_lut_free(lpg, chan->pattern_lo_idx, chan->pattern_hi_idx);
+	lpg_lut_free(chan);
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415317;
	b=i+YRwYHjJC5w00Gpr4jd+VVUSPJ7xSpOC2cegodc3MWEiBJpzTXhNyHbGhHyX/FY68i7
	 L1N5WV0nMIs+esur4Ge9oezMjg89UJMkkMUjwKT7nrGh0eq+M+puvqQz55hO+w33kNVme
	 zu1Owgog+f5KKhfp3Y8k5e7jgCdnCdAGrZvmaDzYIGSHqBLXd1iMyGhXY90iMep6oyVuz
	 qqGwY/4pPvnv8Yb8aaGc/Q859Qdof9bKs7+UL9gHq7wxb++DgjJLSRjtd72A2MVkZjc45
	 JPFe/cGEkFBCvjrIe0M2/1rrrmL+JU/XEoM+BRxS/bemyUGSnj0u3YLYIrqsyZQsRhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415317;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7jE14HdSGUxu+kNCgz8YCByS2YjxAG/unxVTFjowcmo=;
	b=DC6BjNWlZNT3q0pkXl+EUkDpZhm3FKWXpC0ZaBlYnQnixOqKEBttM2GJbXWkcajgWDbJ
	 7wnawErp8sYjdm4wWJ7swfHynzIseGK+TeACcDWReExsqAjRO86mZcGj7+jsW8Fuu4wUJ
	 j1O+XoZgU+K6FhHqHOhElXHHvweILWU/9FvNdRP8LDQKLRe9TKHKXW3IiBRbsIrprwbb3
	 4o4QrD2pHZMGgLAG2oCKYWW6cgY30svY0QojiPbmGJz4ke96QKDyaCcBlr4uDIY8osP76
	 MFg3a9xjIryYOn51zBvU3S/ETBY7+TV9IXXTDluf4k7jKiwLTfsOdxebTckvMYJKa1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hm9ZovAq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KGp2X6d5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6905606A337
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6905606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hm9ZovAq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KGp2X6d5
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN514kB831447
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7jE14HdSGUxu+kNCgz8YCByS2YjxAG/unxVTFjowcmo=; b=Hm9ZovAq/ieEPtL5
	SmzBAIDzw90zsmsdJjDNC7NMZzqg36hQkHgfI0chlmuHzMydev3InfEATmvLJQZP
	4caBimnxm2c2ZjdOahFQ1xc/VK/ygZAVntLiSq756PBE3R72PL5wazFCI5hEmTTM
	W7UXIsvjR9f4nWvxC27KgH/V/S+GP7iN7qWSSKzUeG4ZzBNZEaWEa8m2XBG3pcGr
	wu05SP1M5SnAYgKJ6lgA7bO1xXisxiJT4b3wLOvDx57enc0anMcnsUVQR5HvxGzO
	2rqExpD3YyLMIxmrr0fuxucgSjVwsLuDBpBykwKJEVIscMl2PqRHzzVORUwGulXj
	gg66oA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx08r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:35 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-46a5954cdfcso2595507fac.3
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 22:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795415315; x=1796020115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jE14HdSGUxu+kNCgz8YCByS2YjxAG/unxVTFjowcmo=;
        b=KGp2X6d5nHvUlmS0s8+abOhN02YZxjsb+w0UH4pye1OSlcrFimgsBJj2ShBAD5Ra+b
         jhO9wKR2r7KtdJaj+aIoGQISJmGPAvNvj4tVUjrS2GFfUhcHZk0Svzg/xUr3EFhdzwBR
         sib69Ydf5eriPP2Gsmdh9ubLbc9Hx2qfjBjZtfeLqL1JuqbN1BcrR6DByPvFXbP4QKxv
         a4VFw2aTG1FYWkUustnvbMGmzN/lT+TxIcYBs/CwuSGR2UbEFulAWgfuEb09vUXVcEKn
         /s6afaFBq2XlK4jUzM2qChOHbioIIM0nNEQxNaJNvWBJoWhCHJLKO3C+0nIfPuQsdoPz
         9QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415315; x=1796020115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jE14HdSGUxu+kNCgz8YCByS2YjxAG/unxVTFjowcmo=;
        b=PJcppzZEPtVc1oIVDOxSifCtm6ZvIq2CtX1DeKETlayCJzpsVx74jNiedGtwmPNjDL
         BCVazuTtIdEfOXsvqLlLYIKDO/+wkBaBsOWlMtCiSZHQUAC+aXiM5rTvXUDWaTAoZRgx
         i3Z487MmV4wX0bdxblMAlGhiMfjRlb6+jhJhzxgYK2F9BjkXQ3rT1yDIDAgldp7YChq9
         0SkePNKjL7yzWb2/swBye5M3Y73i1JBbm9cnhrq2L2q5gEdG8EY0mwk71acC7dOHY4Lw
         efYkM1I0tWRP9NcyeFnoW00SC6ejYedB1EW3fwXC0zCGgCduv2oqJhOM/QDaiIrqrCs8
         X9bQ==
X-Forwarded-Encrypted: i=1; AL+hErETPzHo/HL1AGfCaxDqfWZ/in3Ln9JpBkvpSnI4JjHF3eV76c6DtMrNUnB8ki3wtgHEdO0QXjJJWhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xMS1F61FyJRH0rrF7qRwZ1bTEgZgACMjrhJP2qmdbLY15/BF2
	fbxH/1yxsqiIuQtRnHcCSkfhANCVa4LrVo/Yb0i92t4O8Ux7K0NSAcinjJyF5UYNoyuOblj2Tpp
	xAbJCcDzEYdQiggPmEwnVHJIq3AjMfO0YLNrhdgWu0RQ3njYYoTrO4S7GYTzksrw=
X-Gm-Gg: AZFdTZcVjg1oq9NLe+frf2DBeKk2s1hiIgmh+UU5IuKWiscbc5tOXtSii3vZVhDVCOn
	knU/bDN9pe1cInTSX7RLHx+CESZBVmTeYfjdB8c6woTCWLgC6r2CChJtx9AWb6Yy0efrDmv1NDa
	8XFsYOgdjMtJq3zRIEWL61MpZo2UvxJslzb1P3rGYoZLqggOltxH0H4GVRMsHSe2l3ikhoDWH+m
	HIate/7WmImU/ziB1IR+3HPgy9S2JovyCjyJIiYLUkULTcez7s5j3kVkJwYdpJ20DT0dUG1XQoM
	A4Gf3Fob2361929B32Pz3xIQEsC+hIZWH2S3HhzL8hEYGRM79Nl3Pei/ewfA7r9NQXJ0xfiEjHO
	Pl3DvptpN85U/LiYgS1SFvFoUt8mZGNNLcPxeFp2sQdOIzq8DhzuSlz1FAnAlMBbiJEG/aumPKN
	XLRyEQZwHZRn0TKjqmTC8kdujz8Q==
X-Received: by 2002:a05:6808:4f09:b0:4b9:a8ac:479 with SMTP id 5614622812f47-57a0a517207mr11469710b6e.23.1795415314914;
        Sun, 22 Nov 2026 22:28:34 -0800 (PST)
X-Received: by 2002:a05:6808:4f09:b0:4b9:a8ac:479 with SMTP id 5614622812f47-57a0a517207mr11469693b6e.23.1795415314442;
        Sun, 22 Nov 2026 22:28:34 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8762533b6e.17.2026.11.22.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:28:34 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 22:28:07 -0800
Subject: [PATCH v2 1/4] leds: rgb: leds-qcom-lpg: Fix single-entry LUT leak
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
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-1-2e885f60fbeb@oss.qualcomm.com>
References: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-0-2e885f60fbeb@oss.qualcomm.com>
In-Reply-To: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-0-2e885f60fbeb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795415310; l=4509;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=qdbu+eG7Y65JRKBsJusLOMxB0Z1QznzOHG3Z+dDHywo=;
 b=qGZNnnmUF82PoseQ1K+NRaghLNnQ6Ot66Eycw9RdO1AUhm6Za3EsVf4ZEIt4i2t/V1sTrevy+
 oP8YUK2hs2BB+60P70UdHk5pqMu9lynzegX1DLViy4tIj8J7lBEnnGX
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b03dd13 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MAa_CHwBwOMXYDkmoIMA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: Tsrf789qJlnviB-TsSdd2Cjp3kbA53hv
X-Proofpoint-GUID: Tsrf789qJlnviB-TsSdd2Cjp3kbA53hv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX8B7GD1vJz71m
 WFphySCZlm4g9Q8PsrUq1pHetDWoYHkCSxCeMHZF1hSTsZlnngXd3rbMG5w49RnIz5U1ZoFc+2n
 1O1FICeXwnEWQKcBnztnYxFIm7kPGPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX8nK4STJILiOZ
 XlrU4T+CepIfBFeNxOxIyATbXuxDtRUYZQzdY6W1FD87A34IS45BCkvpKOE+mxm5iWdU1PFd1ci
 YAOEkvkhVzC+FpoKqrPfUWD6SKbDt6gmZtuZt1TK7XCegHT9JzUjF4iGCCZdVS0xU31wpd1HCYI
 bEbYfGwytUd/F6Z8/G/dZ/wPAmtf2HBypNtbbdxO0lZQ/2y47SyOcQ73ZkOeFLJcY1xn4qVFRvD
 SDDufqzJKKrqbF43pKaGUM9NIbGzQtWqD0vyW7yTOP0y52+uOVbPKb7da7FJ6NtdX2wlhWtZCxg
 2bxfONMvxfMtMxTdCK6v/3A16t5JTnc/B6fwVE7C5pwZsWv+A2FgKw8n2RXqkxQ9xZLVBeyeNNp
 OhkuouGu56pJa8R077AX8QefaOpl0mQH0jPXPIM8Ur4SHpjnWRuVaX8mD6ERGI2GetPsF8rjBjW
 ZY/JbEoNu5WchC+h9gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230025

The LUT resource cleanup path currently treats identical high and
low indices as an unallocated range and skips clearing the bitmap
allocation. However, with a 2-step palindrome pattern, the high
and low indices are identical, which can leak the LUT resource
because the bitmap allocation remains uncleared.

Resolve this by tracking whether each channel uses a LUT separately
from the index range. Mark every channel using the shared allocation,
release the bitmap allocation once through the first channel, and clear
the LUT state for all channels during cleanup.

Fixes: 24e2d05d1b689 ("leds: Add driver for Qualcomm LPG")
Closes: https://lore.kernel.org/linux-leds/7e474cdf-fcb2-468d-844d-f8afb5976d16@oss.qualcomm.com/
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 24ffe079f221..5d0d015d67e7 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -111,6 +111,7 @@ struct lpg_data;
  * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over pattern
  * @pattern_lo_idx: start index of associated pattern
  * @pattern_hi_idx: last index of associated pattern
+ * @has_lut: channel uses the associated LUT allocation
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
@@ -624,7 +630,7 @@ static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
 	unsigned int hi_pause, lo_pause;
 	struct lpg *lpg = chan->lpg;
 
-	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
+	if (!chan->ramp_enabled || !chan->has_lut)
 		return;
 
 	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, chan->ramp_tick_ms);
@@ -668,7 +674,7 @@ static void lpg_apply_lut_control(struct lpg_channel *chan)
 	unsigned int hi_idx = chan->pattern_hi_idx;
 	u16 step = chan->ramp_tick_ms;
 
-	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
+	if (!chan->ramp_enabled || !chan->has_lut)
 		return;
 
 	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
@@ -709,7 +715,7 @@ static void lpg_apply_control(struct lpg_channel *chan)
 	if (chan->enabled)
 		ctrl |= LPG_ENABLE_CONTROL_OUTPUT;
 
-	if (chan->pattern_lo_idx != chan->pattern_hi_idx)
+	if (chan->has_lut)
 		ctrl |= LPG_ENABLE_CONTROL_RAMP_GEN;
 	else
 		ctrl |= LPG_ENABLE_CONTROL_SRC_PWM;
@@ -818,7 +824,7 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
 		if (brightness == LED_OFF) {
 			chan->enabled = false;
 			chan->ramp_enabled = false;
-		} else if (chan->pattern_lo_idx != chan->pattern_hi_idx) {
+		} else if (chan->has_lut) {
 			lpg_calc_freq(chan, NSEC_PER_MSEC);
 			lpg_sdam_configure_triggers(chan, 1);
 
@@ -1118,6 +1124,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 
 		chan->pattern_lo_idx = lo_idx;
 		chan->pattern_hi_idx = hi_idx;
+		chan->has_lut = true;
 	}
 
 out_unlock:
@@ -1176,7 +1183,7 @@ static int lpg_pattern_clear(struct lpg_led *led)
 	mutex_lock(&lpg->lock);
 
 	chan = led->channels[0];
-	lpg_lut_free(lpg, chan->pattern_lo_idx, chan->pattern_hi_idx);
+	lpg_lut_free(chan);
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];
@@ -1184,6 +1191,7 @@ static int lpg_pattern_clear(struct lpg_led *led)
 		lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
 		chan->pattern_lo_idx = 0;
 		chan->pattern_hi_idx = 0;
+		chan->has_lut = false;
 	}
 
 	mutex_unlock(&lpg->lock);

-- 
2.43.0


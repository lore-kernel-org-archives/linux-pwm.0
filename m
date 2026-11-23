Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415320;
	b=GoAVgWKrnIlwMfSUyeHBcvfojEhNpIbcame1KWC4q/VF+hDoiAKqHx/rcgf51opKsrTb
	 G7h2DaGyoDB+Pers3AqXFRAH+1LusBdl5rmrXbXZIYWlXJ7Rt8949eFxz6zu7ysucUH05
	 U+mANcjSN9CWM6QRWzSnM1sNW+GDwjRWqhkq9Jc+nBBuBqc2lJwpWeaLnigH0hVx0GURk
	 yfnS+bXrM12dCJrQL5ma3TnBZk7pJqqtutayJxwZ3E0d3G8O0IjXKnRe6GP5Fpx7UWbcc
	 48HM5n6Ja9mQrVbrr0Vvfn+AX69AOfK4+x4G+uSo77F2fWLFb32VSx7JvPsD8YQtBSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415320;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DW12okt755HtwVLpnWjRB9wGxkDaJvfH8W6M6BhHEO8=;
	b=wGeAADv/Hb7CDxZA4q3HMaIWYKBw2uuMk6DnKKl5WGK5OdCJasvTeN/xUA32rtfqPvLu
	 uYJzAUexH4vq3R02+OLydzj3TW2WwXWdQoaIbYMzqqbcl0wpNgh/jQo3D7T2dypfe/s7l
	 rBGoz4Wd7ewh5oH/7fczDDb22ti+2wn1qjkjQN6WOAw7d8lbQNZ3xPmBL8UeA72Y24fLY
	 lOekNoptCGi4OtTiKOg9uZfj8yAMHj+lQ21tMOwOI2eoNIlgnMSKIPn/SnXD3F9hmn8cJ
	 7waLbg7zDQ3WrfIseXggF/pwCGzaK7PxupwbvO0EVvZZt9zH3b/h8FFKWxbuaX6Dzng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kOJ5iFQx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zxtl5aDS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A88606A32E
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A88606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kOJ5iFQx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zxtl5aDS
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN50xNJ355306
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DW12okt755HtwVLpnWjRB9wGxkDaJvfH8W6M6BhHEO8=; b=kOJ5iFQxLqGnHt5G
	VtkhBb7vWjdmQUvSoffpIXHnPnT1xZc3pChrOPDCA8IM+j68rf8y9NmiLY7PM4NX
	ye4kDncIjSYqRLJ+pnGw+3PawUnq2AwR5aTP9GN0lx1R2IrqLt8pOVLY1+omkcLM
	AUGcXEXtFYaoGuCZ5bWGOzWOBcc4cQgtZQJrrWgCikz33L1JY7k1xegUtBmyjSpz
	xU1R06AqKUTKUTAld6nsi2KGtPHyAxWtGNeebnhxTxMftVP9f8WixUJUziJLn1uB
	9HzKl324iREdwY2iP9qdL+/THh8Lp1SvsGs7O9OAQRKAy3ndFgv6qCc7coEjEcTb
	WaluRQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka5aqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:39 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-862b952fb06so2363898a34.0
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795415318; x=1796020118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DW12okt755HtwVLpnWjRB9wGxkDaJvfH8W6M6BhHEO8=;
        b=Zxtl5aDScmU6mMpS6Oz9R9LvEdGSf5DFyyd1bf1zg0LXccdY8bya2wvtiT/+/capkQ
         ETTNDb2W15+6Yp6QJhdFtYTq12/FS1De9g5gnoZzB9eiQDLFYQ3JA3MlyeXUwRBXkoGJ
         58l6Fsx7PpGXFpDiz6ZpKaZ9pZFva71gL4xiEksoirlCtXpZqOKUZ6Rk5wqLxYWgwOdO
         Qm6ru0i/0ktlzFvbl1SoEtnj9Nlz2UglDFOYMu8Hn0p8/LbaF4F5ye/Opq5S7hOgPYWS
         SVjKeBkvZBNZNPcEDjAQgzTItXcwBeE3tsKwusDVx10A+FWHK1rJrYnERDvbjBmRfskv
         x4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415318; x=1796020118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DW12okt755HtwVLpnWjRB9wGxkDaJvfH8W6M6BhHEO8=;
        b=s9ykols8xhllCMUysqGXzFMPN51Da/6C7Tk+UEMGfpdWgp9RYKOz3ymYVvv5CTtVgq
         gGD7a63xovRFhnT10VavGqZrgEeQgnCZ9025flzmLnMMLRkZHNKloRWNZHcf9W4O8dKl
         GYQbscU4Knz2gaIW+lYMzk9MhZdvHyYQ/jBTmwB6XqwnIzEJUCBzuFJd+cXukPNMqXk4
         FxIlKTr6xOnLmZ/2VltdnEuMSv9E1/t2C2MZqc1ezegDyjn7rHyTc9O9GNgKsw6OBCwI
         nkuHuO5StxmKHgBZ2PiDX/PcN8ikPNniOHwhIiuo3cJuDson1F4yf2cThwKlW74Rk/qX
         mC3w==
X-Forwarded-Encrypted: i=1; AL+hErFjvy10COLBDjrhIdZkzyy/vF9WDueyOMRJ8IdtjXojtReTxJC4Z5RGjDBJI4RaT381AOGIeq5rIqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sOR6f3+lvOAiQykNs98GWppaqIPuET51/0uln5c514GS00d8A
	7QdDV7//3074+fGMM6jY4DKCXKVkf/uezKMr/2cKMc6HWMrxcIaFlhO1ZibGuaBG4TWzf6swnLD
	6s32m5lFAKFQVEiYnF2smSGaN2MD4s/MsQ3LD9NXO1+jN12LocakQuTkdfm/dl1Q=
X-Gm-Gg: AZFdTZda9CRqfkd7pMxQBStnqNqMFGU6DRTmDl583ImBYTnk5sX8TcVgYTVhK6lNlRk
	1i4SrxPK1/rFjyT7+RM8KeiX81+atIDnEq8VFglGnEnqIkiQMK9tFUvbft4C8/jAKUP9VfdDAYf
	otxEHWXlNl2GcpKNrGf++a/K42aYHN+GedOlKVRIku28PVNISWKZI6nbuaxtCXfzWkmQM6Z0czE
	thRY28iNuke2QUqj8MpWtd4y+RVvWJBjuPpKJj3dHCKj041mPwXSAKBVoP8jP4zzQZW7EPbKu3c
	VLQ5XRNOkaBbXQ1CQqS48kilZbsNqs6eAol8KfkBIqTIG8WHljrA4RYNKDz81cjinQqAgnGxRFo
	LxRahosx6v0SzCl5xVG8wI7UV46tOPm+7qRRT4jTGRzrbZ6z6m64PQX+y/K2g6vsdjxydrgvKjJ
	NcrdbRClWjXoCWVb8rL8u4QqAMGg==
X-Received: by 2002:a05:6808:6413:b0:574:9463:5511 with SMTP id 5614622812f47-57a0b64e63emr10305948b6e.48.1795415318506;
        Sun, 22 Nov 2026 22:28:38 -0800 (PST)
X-Received: by 2002:a05:6808:6413:b0:574:9463:5511 with SMTP id 5614622812f47-57a0b64e63emr10305924b6e.48.1795415317985;
        Sun, 22 Nov 2026 22:28:37 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8762533b6e.17.2026.11.22.22.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:28:37 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 22:28:09 -0800
Subject: [PATCH v2 3/4] leds: rgb: leds-qcom-lpg: Add mutex lock in
 lpg_pwm_get_state()
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
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-3-2e885f60fbeb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795415311; l=812;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=E9cLjwDx5BK+zqMQtgOEwMzmeW7XdmjYZZoDgxpPWPY=;
 b=ehXU+osAStcKgvOmBX+U39c081WCbpCMsxGMgWGRC4JcPzKSYDLvwF00BsXf/XqO2HVbLJ1Ms
 Myww3XaRcV/AX9Kgqh1dmfCyAefHpUPgvwQzNxiIiL+uNoVHerQl8di
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX+RCSKU1xeeNp
 aKvfY1LA9as3GYjm+quzkvmj8xA7PKYjX26KVUmsH5WqP6PSjjBqN2caEazJ1PZ0Iwp22N4DtlH
 YOEsYtR/0O/vGquCeE2DgmVjas0l99THFB9oekn46xGAjZJf2Jnakm+jj+c75P8tqckhxjA7nnJ
 FftZc+JkMKgNk9lK/7rZpvQc+Sge1O74/A5P4AUZrF1xrAszT1ZXd2BUM59OtvjbSsKjK21AmyA
 p+KWaw/mReJbgaTo1SmgZyr523Njveq8Kg4zh8725lX5sKFfOdTHc6PeQE5rFTwDWPgQInm9Gab
 CqxvdbGtrOeCgaBsw8A21mqm3bex3xs0l1N9K4KFa7fxycXagypNaHZPTTGsMmOSEP1A0X3Tvjq
 ISMoU+jklTi6eMlWsFalHzCMJnGx0L7qfWxd0iyJdN17NgxOh7JdJKpz8zEqwwMzl6UCovLAMbf
 HyElMh0Sp2GCTTV6DmQ==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b03dd17 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_SGh9dyU8YcHfL2lJxYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: WKT6PoX_Khq7YFK2t2WtzRgCt94kkAqO
X-Proofpoint-ORIG-GUID: WKT6PoX_Khq7YFK2t2WtzRgCt94kkAqO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX12tJVzHGjjkE
 U3kNSUd+zt/urB9q2280iBqyhlJhtwZriHwPnWrdKuJl4FXCmsZEW/59kD0+RrtRd5v78DdrwB3
 F+IZQF2CnHRZdSaL2CviptqW76pBPQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230025

Guard mutex lock at the top of lpg_pwm_get_state(), to make the
register read atomic against the register write in LED callbacks.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 763d6379bd2e..5d8f82ed228a 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1470,6 +1470,8 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u16 pwm_value;
 	int ret;
 
+	guard(mutex)(&lpg->lock);
+
 	ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
 	if (ret)
 		return ret;

-- 
2.43.0


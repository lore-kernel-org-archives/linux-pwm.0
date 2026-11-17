Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907956;
	b=kiimdXe+CngWZeMiMAaryHQnno56itPSjMM8ZwWFXWsdX6r6zest948wh63mQuyXeOGg
	 3wtFe9Uf5gbU+Iam4uCSwUwmIPTq0U5r5wkvvGrCqkQu8WSZfPLmDg4jYt6GBSaF5lox0
	 8sdsGtqfb/vUNvBCH35Vs26Mzwcxro32sYgzMSJmU7SRLIZNAFM4VM5J5aXZ5Dii4vvCO
	 zAq+Vj4/i0Bz3J4K1Lduuy76TXVKIi4Yzi0QG5WEBQMV2SAE/GCl4r4qidgCNRS602B4a
	 Cw1Lu84V0qcdeHAic6aO3IJI+4rQiU6c/l61pfRCwwr6FIQuCTqaeynZji6JVNhUP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907956;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TnflasjgAFjotaDQqEyA4/p8xi/qVGkxIP9nL0N6bYI=;
	b=CEXqiMcpzbcHygQA57+0TrcbAb0w0FxNSSt6HUBhw5YXrLWk+eYP9ZXb0/JOdk22DLtS
	 43sfKMco8WfUmsCrYfMYfo3zsrFMHvy2KmdmX+01KcuAHs9JZCJdVeEvk83aFSD27t5S5
	 IoU03ODLokYMvzRKcofuxyFoD4j+FTtCBXzaNe4MAOyF3Pl44/wdp7VPM3t38gFyToOSd
	 cQRC3z67dk75udnLQod7bLWuqWIDgaIau4p+Zfq7JK7IFHvsrb2AzUwkpAmD8S52HKpm6
	 YOdx9DwufGuH4lNHCQ5F5AIrZIlPXy+KY0bb3mrZvx7pSHCBaaTju4PtSkY5j8RtHhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Evso+/sJ";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hLr4iMd3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B41606A8B2
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B41606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Evso+/sJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hLr4iMd3
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8pxbZ3624129
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TnflasjgAFjotaDQqEyA4/p8xi/qVGkxIP9nL0N6bYI=; b=Evso+/sJcdVYDmRw
	Fr1FJhuFcUPL1gRGk6yRsPkXKo4aBEJz5laFGNPRVF97il4T0f4lKHxlzKP2MFGU
	UQUYF0IJ4TDJP5qVGGKACqSOY6leY/m/cj/TH1uPpmmh5HOE9bbHuud3BJdbembn
	mAt/PuymZWY5khHDh1udIIrPZS5pon5Kbpntk90gaThSkYheC1bWDGPlyB7uyH/O
	SDIz6YIrBPAPlKQUEjORIz9OsqVZnMBkkAv2fILCr0QoLCG1BVP4X8xP83GUyDmi
	sRT+sPXV3qSkF0GjHT6s5dBokg6pctHrJq1rrNJsgh2HVmEUHXWGCZQGxA/vtRRJ
	hEhG7w==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07rejvms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:35 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-71af90057faso920965eaf.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794907955; x=1795512755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnflasjgAFjotaDQqEyA4/p8xi/qVGkxIP9nL0N6bYI=;
        b=hLr4iMd3D1duxtNOTbl1eJ3Tn6E20l0hFVK65GHe440Wu0R5pdg9Q0rDPSWPvbf+BW
         OYF9sVpln6BajSqDo5IC/bPhI8hVcgQ5QDeuikcyXUciBrDRR1+Hig62HTfjemubXdTA
         CWnSF2DjYvbiVCEYooq+OEUULXP6G+gONUcGMMvyleSz/9sxodvppJEcASclskfaFWUV
         tlO6TcoGcDiRLNj5gs6PKqTAsnHpjypK3DQvH8wLEbp0UENuzYuttAPnDoOkXkq9Z71/
         WVOcf+EntZs6p9c9B8kLJMSW00Lwe2kvB6sdMV5GKHJgqbOm96sskHDqgC7i8b4yRSQN
         3XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907955; x=1795512755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnflasjgAFjotaDQqEyA4/p8xi/qVGkxIP9nL0N6bYI=;
        b=fmyZh7IcHdMqREwy1fhb41HfPXcbJTL9hSXXyG3clRyoVmilM3UsFEtGAosZyzoRgp
         Y59c66pSyEi5vmuT1BhC3YwXWyUQlcfzmnALprz0+456/VfNYkKwMUpgoYNWHq8Ef9uL
         UTCDIkNBsZyHpP/X2T8fcA/aC8uXOIPmhEIZ8MV96gzCgu9qBkjG7Fpa/BMeIUNG+dGn
         aJwLjiH+mDX8qzrbLbeHXj4sDnF3UqwJAD7UjS3fgbWWGb/NB3Q6MIulJGRuSkAyLiIW
         3JcFarPH8g//qaFIyqaev9af0XCZQ5dPNxfWf2W3ZBHOEzOS4nyPbMl+HpdZriqesGne
         aRYA==
X-Forwarded-Encrypted: i=1; AL+hErEnYB8LJaMBc9UpzhHbs05PohxFSLoOXcbKl2pp14fxT5BP13kL77Tet24/DYDAUspjJtaK40jaE/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zoMIGmNLSfND94L84vt1uXrVOcie5xdFltOj0jUqrCVqZNAla
	tRScglEVdySsOJJ3P4/kMIty335xkV/z5VaMWElmKVnjkIkLSivkhVhmXH2eTb16lbPJ4aN3yPf
	grwlGKmqt2+55P4fWn84/4wqF01kHwb8amEsAZ0xHFC/5O9skxqws0HZzQWQG48oRiK8pu1U2LQ
	==
X-Gm-Gg: AYBFou1rUs5HQlcEngN2KuHzhwdUzEXTFFQ+++fuSjBUgK+dSn2i4GQJZI/2SSHgWkA
	txcc1QFsgR1B2OKsuxwklhWFjW4F89z1UbQ5AQ45x8+qzk0cKRKbXS2HswnL0NnWL01fyk71k76
	p8BG2OM/yqlYgSblKd1k+pAJqCoVfN7H+KmiSYYaW3UbvmL6iS280xHyMNV09mnF6nSyLvuMXjF
	DmcU2BDvL68WkLweELx1KIr3kgfovZ5b7AgDlwFXTT7lUs8c+BsGx30DaFIbOS6BxloYzG9KpH3
	+5qxLLSVi64AmIXcEOjVMYWXUd29t5qLp1oREtRL6I4l7UAaRYXXPATH2nvo1DCj2QeP1W6vB90
	Zbd4j9DIdJXCO8gghgFNYhqK5B0TrTRYcze6sI6EVEyO4iarKENmyLaF1Glq6kNIYJWGet7yS+Q
	gSh5p9W9uvBzzMPDl2fCODf9Mh
X-Received: by 2002:a05:6820:1908:b0:71a:ed44:18b with SMTP id 006d021491bc7-71b024f1588mr1482569eaf.1.1794907954733;
        Tue, 17 Nov 2026 01:32:34 -0800 (PST)
X-Received: by 2002:a05:6820:1908:b0:71a:ed44:18b with SMTP id 006d021491bc7-71b024f1588mr1482550eaf.1.1794907954166;
        Tue, 17 Nov 2026 01:32:34 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2206dc0sm8678928fac.5.2026.11.17.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:32:33 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 01:31:35 -0800
Subject: [PATCH 3/4] leds: rgb: leds-qcom-lpg: add mutex lock in
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
Message-Id: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-3-7a862240683f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907947; l=814;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=5eJRVgibwxyaZg2NtEGplKeEYP5chIPBpI0Kdh3stDg=;
 b=Scy+zu91VxFdrh8IFbguc1SsFdfGNcpXXmuPo0ivwEPYow4yX2bP6irzC5dnDhIL85ixkDCMX
 qBFF/fayGYHCWMYRyWyRzhCcBzr3pKk/6L9iPPKxueOxy7oGNrxiQeU
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX/p4vN59DZ/xF
 BiMbSfPYqwI451F7SF/t25rtWMZ0se14kTSEOu39cVWRsXvdSvwO0JKMx93/Lg7riHzW3G2judh
 ji0ZhaELdLYuKQqeCaRgMw5zd3KmhQQ=
X-Proofpoint-ORIG-GUID: PfeAVJhgEQZbc3BRostuCVS6g4XdthWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXyeDrneXzYUJ4
 zbXr8xbdvDYyTMxIY30OsW60/U4C4R/SFKrRvR9gc6C7D6xSB6G3j7SvZUAzrNH96FevK+NXQnI
 yne6uc+zeB4SuBG0a40zczmtI57qZ2degilMG7ND9pT0Om2UOw6NSce+5raEoOR8VyEECLjNsjx
 I1wBgZ1I+0vrZ/M7ZGTvyopKQos/bmwcZtKDGV2nUsFySONJGDUQaIgB8qSF0ocn4/2jJJLwEdX
 GOCBiMpaXGwgT4emPAeke13WCXbhSo2NrRhthp+nLa+t8DqIZKLullUQ2gssSLCHFeGowJ0kGdO
 EGboUaA8QjZKi6k1gothU9kV+FsIDhVbJqmFxVnGfUtK8WZR8EzYAvPFsE8ke+bPi8D1hYRsxSq
 VTQw48aSQI+F5hKoLsUnrCRcn0QZFJPOqBy1E/M8GVrd0SeWkJOuaLewR3HSDtPJOMDWsYFf6k0
 25QukZdwjun+9aLWSOg==
X-Proofpoint-GUID: PfeAVJhgEQZbc3BRostuCVS6g4XdthWO
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afc1f33 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_SGh9dyU8YcHfL2lJxYA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170037

Guard mutex lock at the top of lpg_pwm_get_state(), to make the
register read atomic against the register write in lpg_pwm_apply().

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 175b3680766f..971f92911606 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1425,6 +1425,8 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u16 pwm_value;
 	int ret;
 
+	guard(mutex)(&lpg->lock);
+
 	ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
 	if (ret)
 		return ret;

-- 
2.43.0


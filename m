Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417337;
	b=IpeQmabkLTQzMLFARQiyuJvf/FF3MMX8ECC8VGB4JcfVyI2Xnn0MvtReRTvjP0cDl98X
	 XjXQEYMZfVMBY+foGR4fQWXLCmVtoOKOLi0vAC26TBi1T4PnRRug4cnHwyy1dOQ66vRIh
	 JOB16DhkToJ9XALlhO2DWFyHuIBs0IckECdSSja5hz1y0ZyA2LVXZ9JkgS6ZhnoJ9eGGl
	 Ck90kbhp9Q27ijkSaMIelo0j3Fdys/TD7OilyWCYDsXoN6/Xo45+QgRI+Go93KMeb1jJz
	 6dnQSV89NztsUNCslcbzer7TWqtACcLiobiszyyOm1fHhs0lMtjJGOYhVHSscXkbEVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bsRPgW9mQ21aSAVZKJ+ymHnZ9DWbLkBxYrEyO4B5rA8=;
	b=n4Yd+W+SF3TPnjkpuJ0bBqlDcFVdWdR8JlRayfiND7GviYrFz517EYaxF5Sw+SCImyZb
	 9YtlycyopdKRKWSlWNlLJulXuY6I4g4AJjm5z1hemfYvL0QwySztqjqei6ZiMOuhVLFAR
	 nGp5rohB3m7zEkLIh+BquqM5ADI+ob3CHOqOCvr0e9pY5vj9kkEpKbXGtIETrQmwq7lC9
	 BJtIC0JDuE3YyZugJbE4cpugAYQgDaPNmFqKDmCrGg7tqrvzM8Vw5DNEnses4x+lE2418
	 HhJXY4rn511rmpcQWNEkn+Z/LUZq7bU0RadgKZfpxImFoqQtSdvwGC6PNeDmkpPUPjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pyEvdx8T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcDDrPgv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43753606A697
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43753606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pyEvdx8T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcDDrPgv
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN50xrX1961026
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bsRPgW9mQ21aSAVZKJ+ymHnZ9DWbLkBxYrEyO4B5rA8=; b=pyEvdx8TkAh/8ger
	ZxjsoxlIAuuAaXkGtM4sz4BZxg9A2nUbz8LVl8reFZLc4odKnOq9xwwneriE91wU
	gtg4Edua1WKbOp+iBDd8abAYCULQYHMDGozVGbS8x0TkMl+uMnKfSgCFly+j6vBf
	VFhsqUCFQafzCJze24GqRKfVCBoIEU34/aTG5+FjIPrWCsSg8oLUs9zymP9VyUl0
	KGlA2ye2JQQlubljzcl5f8yAcTnC1Z8Zbwl5Da+cJK5RsHCP6Edvm/lGP4djbpfN
	fabsOIoPm0n0H2cUVfoPP46UUUVF9EeYpWmw8oDOtZbzZByKmhcGoAuEEQjXPBKb
	Eojj/w==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6nphs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:15 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4f8281066c4so3966941b6e.2
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 23:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795417334; x=1796022134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsRPgW9mQ21aSAVZKJ+ymHnZ9DWbLkBxYrEyO4B5rA8=;
        b=XcDDrPgvYbRjH+bLPE/TPb5MVKmSIOSnzqsn2XZNFi8nyMkDl9MSiQS2auPyyXojs3
         OGVyBYJNq1VjHuZ6ApeNaeUJRJbP+0ThaT6Bo/OsrfjFsD+DBSWpXheKTWiivpJ23X5t
         d+LYqGcY1/667okOVvH7RkqwByi9DIxPsoPN8qau2SXPQVwCBnBNx9RmAddJNMXoWzFa
         f4mnx0tEUSostDgRsd1FBZtjEFXuXFEepWu6TyhznhD89Wzm/OIpzAe6ZWqVvk7k85Br
         TG/33z7NKDwD26PuTXmjSMWIN3VDfNuRlMViZsCzQAbeWXOOBFF6LNvoAvpD7BDxMtCw
         8L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417334; x=1796022134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsRPgW9mQ21aSAVZKJ+ymHnZ9DWbLkBxYrEyO4B5rA8=;
        b=cERGrRo6iz4RjQfp47BhO6050j/iMNKSQu0CML1raL7nf0y4wktZyP0nsQ6qgfZfay
         EfhRhw1BUbDN95L8p/Vg0gLZMHhze/Y2XldsDp+v3mcxdVZBzsinGkePPNHFGIgxEdEp
         N00AWngv6hamin9nTDGX+E98YD2koTtNrh0sU1ukPKW7h8qnjtz4ytLcUmRyhx91Gulv
         M/GxQA2v8fm09eGAEtBN/R4uwKHr+B7f571ay0w1gqvGhb7oiDtYJ2devrd6jdQlcVBe
         jtNnCy2BEstBwM2oB2J4x7bkb1cT4vp0Z1rdWg/NVcJ0GdOXjo/nH8/xx33UTAOgMC2R
         7J1Q==
X-Forwarded-Encrypted: i=1; AL+hErHqKjz0zsnJefkrWavwDOLj5QSn4mesSKxU5KMmNvjkW6sA3BmibonE/jLjNBoYaStZ2ZK8gWyE6jI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jo9aAZKEaWzbCX3x63Tjy1hmWL0dv2FgYhHs1+U6DOpmIdIvN
	0lgu3O6r2sUHQ6Vg6LSHCX3Ima2+b3g9EHp4sRXpWFAT3DF2MSSyuzg1GxPWKK8nJJA9E5Vjt4j
	agI6jEO6+BSqbzgs4/xh2tKZrrju818Sbcx1wHgyIWH2u0IvwKvCIUvjo1ccGhAQ=
X-Gm-Gg: AZFdTZc7PeyxK1gJwndBvcSamhJ3pqLoQ8hYYXhwh+6dQGoC/DiQlTy4yQisEVOhznh
	3xcYnnLWghTTmj+YqVUqxnRcNZQQ4ax/ekjRHMeXrDO8LQW7iDr7l94TIKZUPYupokoBffGCCu2
	9163dHh1HAakof8i1nr58cn1Az76eS3B7NpFRLtBMor4lMz8hlewOK7mu+fm/nLP28tE8dpNJyz
	tzqh6nNfOaiSXfsWgeRuuhRX3OvpsdNOaUSy4CH6P8H1Q1De2wkDz9zsmZvbBjpmLHWNTf832kQ
	TKxjDa5QBxsKnGE4S9DUgGhnH8GsdgnzjsbVQ9xLIzZ8Bhm2GiXwkHskSUfKRkit3hTof47NUeQ
	czuh4RZ5lUdKQAzwqbCepC4yVi8QWCw/UUeucFftiCP+5WeIakbLwrYCp1NphTVfampAohrH8ra
	nH5VGiGx89L9/H0wLC3c4Nt7UvBA==
X-Received: by 2002:a05:6808:199e:b0:572:f8ec:532d with SMTP id 5614622812f47-57a0a927e28mr11458637b6e.23.1795417334548;
        Sun, 22 Nov 2026 23:02:14 -0800 (PST)
X-Received: by 2002:a05:6808:199e:b0:572:f8ec:532d with SMTP id 5614622812f47-57a0a927e28mr11458602b6e.23.1795417334124;
        Sun, 22 Nov 2026 23:02:14 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8817213b6e.17.2026.11.22.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:13 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 23:02:05 -0800
Subject: [PATCH v3 3/4] leds: rgb: leds-qcom-lpg: Add mutex lock in
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
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v3-3-f911edd40a31@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795417325; l=812;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Bnb2so3/IwoLbKEtelemwhyUAsH+oEhrfqUv3ro2zRk=;
 b=BWcOshcISQpzbqHudIE5kDAuvxuIyaC3/EeLxUN1kmCnDJUgGZ1U5To2CRAeVXdNzlWsPeS3X
 0ysWKD+WCQZB6eDMl5Tk/3ZcOyDsxRKl1Lzd3t6cOAnduEBFnaUAKod
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: 9IVlfcrcRXevSgoSYBQSz_B80m4Zk0sC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX3WO4s//lzzoF
 54RNoh39AypZHVJCzvxT/kRmoAdmuFiXPM+RDQwek/40tiaVR+qjxar0q6TXwJKR1qxXTHRDqo4
 EC9VF2dEsYgNel0s590e8mgUK8AsLik=
X-Proofpoint-ORIG-GUID: 9IVlfcrcRXevSgoSYBQSz_B80m4Zk0sC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX5nvfA0K9OuBX
 slOeDUhWEkhesVw4MoQpmQ8V9FObIZaFAyHvCjpG0cYDfDUe7tOlFK0Nvwj0COr/82VmVhYatnh
 SE2hhBVZRcvZ6xfI5cMBLl9XqnPZJG7FKilLkNz3lOeN3CZWJTeT8ZoM59MjVkLK3zSfpCvo439
 uk31UPi/k8tFUIJqQxPault6eA3DzdBVqVtfQ9ZYZd5ngnAatJ+y7k4m/toHFS+J0+GbOIrowUZ
 scx98QRm6O1Jsr1mrAB5XdcsWsTxAwsMtPbfRIus5cqH6nNytGbTrlq++jgvc/1JzTUBqeF8aKT
 1ofDRX2QmMraW0AlJPL3Sv/Dhxx6cvYXysy4eRufo9CtVujJzuBrRLYzuAAG18aHPVYoKqFQMVL
 Wd0SZUxU6B6hwCgGb3byiOvOsowyKUeyF4l4Mx+axFFFDDFrhfRJ95Iwer7ImZ/3fgE967BMJWA
 L3VgUHSKXBE8lbNP3Uw==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03e4f7 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_SGh9dyU8YcHfL2lJxYA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Guard mutex lock at the top of lpg_pwm_get_state(), to make the
register read atomic against the register write in LED callbacks.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index eec942f2af6c..06588cd0b3ae 100644
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


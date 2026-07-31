Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CF43CE54
	for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511645; cv=none; b=QbOkiBy8lD9dLsDVWjTjSNrMaVKFM5/Okin5FJELQsar8vvch5/1RlHB1XZoO70AOF24xc98PHGopMHNxgKJlspcRe0bP+H/ICnIMHkEroT5dFncGhdLEjBrCJP94WLjSEQPro1hZveE1Ji2XYu5xwByDnxt44v1RHnf2Qcu/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511645; c=relaxed/simple;
	bh=7klZEho0H83j8ylpjNW4TH0V0nFQueKsAusCKPgOKBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ew977f+WdJLCjFyCwtUV0JQnY68y8p91al8pJpehFevATnYVmkfDWL70qPqxZtKV/cwDtj4OtRV2IbpWB4E/ZXLPKUQytceDsPXoOF7BQAOu+HBUjyTkeVMgRCoOq7htGhHr+ALZsg6lQ3hCydX/F3Ygdhb6YyrcmM8tBFNIChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ot8syubV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RELFfAQu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ot8syubV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RELFfAQu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOEAS1399713
	for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 15:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7uFsYuCwq0Qx2h2L72I1/1dKPl18cLwGQgBX9DoqR+E=; b=ot8syubVxIKhBaXY
	GbPyChFT7d9PiDexEP7CrEwOpsRi04eXQ0sXIz0aj+UnJtEDIRMWEafWe4EZENP9
	fiwNniIZ+8HMU8SdoY2NEi4wIruZDsnkqBu+tOgNgQ5HClFzpZII4DHoN5rRyweP
	wPAhFj3UaBiAMiuTzjVN79DhDzL50NrehJvU0Czkr/q4drmt4rDAxdRI1wiiodeH
	JptdpRGBAaRcMEHsL5PUbyioKRf/4kjA9DoUCfwYftiYjlcHd2G3eowN47I7gtXO
	soJKm1+8HJWAGTb+N5Ly1C/dWOnYiJzZeosHZifZA+DyP54z6pG88hoV8qgrJSCd
	lhA56g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1x8yec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 15:27:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e777a15so1705761cf.2
        for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785511642; x=1786116442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7uFsYuCwq0Qx2h2L72I1/1dKPl18cLwGQgBX9DoqR+E=;
        b=RELFfAQuGwVTMoPjQW0CkpzoY3qZ5rAD64tfmeYLQ7YmAQquRNDOgV4H/mIVgHpL5J
         kK7EnFyrjfDrrWa7Xt6YnBxCKDJt2SHrUPhz3mXYA1ZEVNWPhjc7PTkZ92k8x8z6Eprn
         HComGYtsU7AfvEkbz7SJ5q/qQh+FB1i/gcNkd5J1RptyFc1zMAJ1B9RsbDDBE8F+St7p
         kJmcWRsW1iA+E8R6oL92NjteY/Jhmqyrotn/Tiba1W9RFET7IoMYq+HlzJbygr1ERF1E
         hEhsyiELJ5N+6lk0URri/JKVTif4v4svjL4y9uNcqorKlPbnvXfjHACFm1VfiT0gkzPn
         4pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511642; x=1786116442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7uFsYuCwq0Qx2h2L72I1/1dKPl18cLwGQgBX9DoqR+E=;
        b=Cxjb5PAniAsIt1TRwo6IcaYziIncY3o7SYYjHI12qi0aYjSQTOusK/MgH5E1yKEFw+
         SNB0nBbZ3HXyibmuxedlUjy9ddLltnM2yjcU/3u5KuthuYT779naRZFjuhjB3SpQFJOF
         rYhHIOSsOhv8W7Dwv6Ls4EkyKwLlQVanfFsMoH5/aqS1bYZz4aPCtWzWIdtPbTpMEgOO
         c52QCQIZpZFOOWAXSp7Mdv4p2RYd2mYn+QkM3+9jbhzbp4mvm04tDyZCfIR3H+H41dPB
         hkK0K4xzNaVdPYxYRqutKsODmseZEVughSELIou89s45aidwsSdcqtLsd6ijCWWXDhIM
         PIjg==
X-Gm-Message-State: AOJu0Yyhd4prR+AbH8EsVh0yJ1P8CEFjJvOzN6qzGe2E8iQCQ96p7iFv
	VL3IhZnco+QBCXb2GGVW6E4NyxNAfEybgBUXFbw5WhDVFbB5KIRF7Togdbi5yvKcUx2AiMm3BMq
	gxV9GzWy5RfwvVL5rYJDmiEPskP5woPio+MCi0cIjL3Bh1/b2rssS4GFIZ8hbt8s=
X-Gm-Gg: AR+sD11bVt5eTpos7QW74DHvHXP+2h2LAV2xCdP+zw7UonKNg26rcv+d7ynVqlMCYoO
	NmcCd/owUZBzQSmpgHMYAgl6hjzXfcb7oMsla4HYQlF7+D4ne3d01tvIWVQzNJRyW3RAER61rAD
	s6QmKkWMQVWFoSTsdNN4YiE4ZjokEs6iRHHDlj8TzYT4+MKDQbtmuMRrYZZSeZulUR8mRjAkuS2
	svfXI7vNWry7XWauQ1GQR5AvD+ha4Z4OMC/AShbkCW9FcInkCog48/mOVLvdBlqqtrQuXct0QoT
	DT4qqY4smnmHYyYfHa07GxLRaQg9C66Z5TR9qNB//uYd5j/soAmjUtqXGzxnoz33NuMZJKnYC2g
	G34jiMBESb1vPYzgzbXrcvsHc
X-Received: by 2002:a05:622a:e198:10b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-52b567b3aafmr5993561cf.4.1785511641996;
        Fri, 31 Jul 2026 08:27:21 -0700 (PDT)
X-Received: by 2002:a05:622a:e198:10b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-52b567b3aafmr5993261cf.4.1785511641664;
        Fri, 31 Jul 2026 08:27:21 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c655446sm1975608a12.21.2026.07.31.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:27:20 -0700 (PDT)
Message-ID: <db3c439b-d5b2-41c5-a3f0-bb528843a85c@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 17:27:19 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: ipq: fix period calculation
To: Stephane Lepain <stephanelepain@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Kenneth Kasilag <kenneth@kasilag.me>,
        George Moussalem <george.moussalem@outlook.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Baruch Siach
 <baruch.siach@siklu.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260731070542.155398-1-stephanelepain@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731070542.155398-1-stephanelepain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfX6xyIU1eoplPD
 wm8TYt6ebFordO8163Xvabkud+FnwJUcIGyg+DDCIb0ia97U24G9dB9MI6c2zmXyV//9OTUzHC9
 CgaXLPYQ7IZscdQqJ5A/rysmDE5g4Jg=
X-Authority-Analysis: v=2.4 cv=GpByPE1C c=1 sm=1 tr=0 ts=6a6cbedb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=nVPmijOAcTPNv26JQuwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfX5Vj7udqGwlfz
 FKQAMP+Cn7WkRjOBsMEDJyGPvTXT2HPHr1/9aPvx7q/HOH0CVg730CivVcU10kSa87SmocGXKTw
 ywG+haqYtpdOmgaf+oLRhf6D/cbbTyDli9ilE2qyvSP3HE7zwNlezL8glySuCV1aQrob8716gR+
 0bjI8aBOVgfXv+H1vZzo3R1VJitr67g9PwaGfVeWzvh4X3UMbP6QtxYJ6nn+SwsNU7Vf8Cx7Q5v
 6JLPVLi+qBY1mp+dvCiHN5T7q1Qy/fehuOrRQ/zaUbLqoJjRI63dYmzh9WLsogomUgoZ6VhE5zK
 VUR/STqTTccQeWkf+c2dVE9xq3+2x4lKNmw2TI0E7MeiU3tw+x3V3LZ2ESj8xB9+MKZkynSxhbC
 IPePgqE5Bz5/p6FaIEtYZRosQXqt+m7+hpKA2h++t5JqWKGd5L13VrBkMAqxHiP7u5VlvN4J+4p
 lm/ekPncB2V2yjdTTPA==
X-Proofpoint-ORIG-GUID: hprBziXbCzYQMotQy04AQnHhoBQKP0Hc
X-Proofpoint-GUID: hprBziXbCzYQMotQy04AQnHhoBQKP0Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310117

On 7/31/26 9:05 AM, Stephane Lepain wrote:
> From: Kenneth Kasilag <kenneth@kasilag.me>
> 
> ipq_pwm_apply() fixes pwm_div at its maximum and derives only pre_div
> from the requested period. Since the period spans
> (pre_div + 1) * (pwm_div + 1) input clocks, pinning pwm_div near its
> maximum forces pre_div towards zero for short periods: once pre_div
> rounds to 0 the shortest representable period is (pwm_div + 1) / clk_rate,
> and any shorter request is rejected outright:

[...]

>  	/*
> -	 * Pick the maximal value for PWM_DIV that still allows a
> -	 * 100% relative duty cycle. This allows a fine grained
> -	 * selection of duty cycles.
> +	 * The period spans (pre_div + 1) * (pwm_div + 1) input clocks. Rather
> +	 * than fixing pwm_div at its maximum (which gives usable duty
> +	 * resolution only for long periods and collapses to ~0% for short
> +	 * periods) search for the (pre_div, pwm_div) split whose period best
> +	 * approximates the request while leaving pwm_div large enough to
> +	 * resolve the duty cycle.
>  	 */

I think the comment can just go

> -	pwm_div = IPQ_PWM_MAX_DIV - 1;
> +	if (ipq_chip->clk_rate > 16ULL * GIGA)
> +		return -EINVAL;

That's a very fast clock..

[...]

> -	hi_div = hi_dur * (pre_div + 1);
> +	hi_div = (u64)hi_dur * (pre_div + 1);

This looks like a separate fix

Konrad

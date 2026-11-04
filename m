Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751650;
	b=GPalnZ1U9hbShhEeucixFVGnE4YytTOlc7j61u8456h8DNiVnYoJwoMavTyNaNOj7lQq
	 GR5IhRoFsbPyy0axrD7LTW6IOzI0SiAy6inl1B8RIfYWrKZrqIhgCwv0tPrlUV3zooSxR
	 EemVGit6OSlZLrH6RaqxOhbprdq4saR04cV6skGNegiw5i4so4wkHKz0pKB0QkHR+xZdp
	 loB5Iuo7ZWanygv98+nz1+JXRNKqX+LFjGGESOSnc9AAB2ipWWbX4MUThAfPP9vJ1POkN
	 TtnzqBadmgEcUsirLe2IlSTglHGg18jbUO7mZK/p28B8QcP6ILuiA6GBQNpF9o94c3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751650;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
	b=ZqHzR0ckqLAknSlzLe6q2RxRUcbvLZCg/Nq1TvG/XJJOet5FmZFj0pUNxegq7UWAt8/x
	 LZGX+9mMDbxZSjIb233AsJH8GvQNedaK9XiPZnthhNrsaVAjiu+1G6TawAKIs9gj+qpxY
	 FhKb9H1/IK9f5Ksnd9dqnhUnLpaZ6M3XLIJvGaFvbzCEHYMrSfuHXSG+hFct6Wg1NQWp/
	 tA2WV5Ij2dAJ9kORv1zXgk1u9RdkE/k6AU5cXxsxB5KfATlCP2cujljDdaZ5LBNCTJg26
	 J3inm+W5ovSl+CIO2NAuDpxLq3+NwCZBVqwJpQpIAFLBK308twVQ59Bf/3eFa9Vx8rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9aA2zlY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RLUqwSFw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D6606A324
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 00:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50D6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9aA2zlY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RLUqwSFw
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKswR4033553
	for <linux-pwm@vger.kernel.org>; Wed, 4 Nov 2026 00:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=; b=O9aA2zlY2c8+9sxr
	hXQL4F6wd2IkKQ+VwK7lMQzQ46GiOvIpxp91H2p0JDnpQL8YFnWTpiDbyrffdXu7
	ypY463gCS0OkSDzuxQzxK/Fbbir96u+n7p0fYBJeRuc9C875OBzhe9jDYuN2NPjL
	kvpKI4W6w90/l1N8jpg98FvxduvmBFocU8BHFyTU0S89lQLzNwifnlKqgytRaF6h
	mIYsWzV32M5cjjVSu7FDv46pqfrwr8BKkbkjOeqD7M8Vvy2X4rdwzkuJrz6tPmTT
	+4mKx6bfXbBsk9xVem0omadSRCKRthgz4+7mXvn7GJecdizYtWODemcR+ODHZpA3
	ou5kgw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhypj8ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 00:20:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so201245a91.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793751647; x=1794356447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
        b=RLUqwSFws3Dk/TVnyMsu3XCtjEopxlJ1ZJra9BqcCI99FxJDGKT4o15ovhSBhreDnf
         tVNjo6zJnrxDuSfeoks1QsTSxKbna06Ouy/905k/tBSfxXaaBZ75rKekUNAkE0dTGMJi
         x0Ii42OhC05cf5TfcTLI4fPKdLxbVNM7xm+1HeIGzXESQxa/JpdipvVLam9UU5GaNg83
         zRbVZqlVnJtHQPpPac6flOHqv3gIEjAF69na+VBJApNBzj8nWmFcg0tC4EAiAwdFHkT0
         +zMLF02ENakSaC2LA5A/3Vdf4YpeuBLkyBlTG89LSrNitQyRwFuegsRbv/EbjYAHtpjM
         BnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751647; x=1794356447;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
        b=JCnlVsORbecfBCabgdjo0u1FaFSuyBCDmjbnD5Sg9UuBc7rqsTOTXQB3cMptsTcNOK
         xlctEfT3aX/cRuFYU75hk/dzyMuv71IJaQO92UWw91bISKWHqXjvIB2+VHJrUHYB68jX
         sVZDXWcSQAyy+oO377R8ZLLdEM+pBjyyzmJ7ZuQ/J795mtEETS3cEesCFkFfYNRBpwJx
         oqNU7vSMUyoQqPFtapgmyB0BKOCkTezDRnubQ/fyKL6toJ8Ixe/6k7niuZwVETMr8dBc
         p3bCzik9AkwrxpH1CwN9zPDR6BWmbCxctagrDAzUtS+RwWiPaNSqjGYQbqLgubfh61lQ
         cLIQ==
X-Forwarded-Encrypted: i=1; AKwUvByeg3ALU0eA6mZyuwM/5uDrp+Km0Gc9CxS4F8whXVREdfCA6pzWi6U65ku3n9pgPR36lYaR46zmD2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GeKFRovVzr0PEesswRO20Fg0KRIT4KiEqBAlXCRIA1a8HouaG
	rKTHnh12kaGAUfarqKLjwX36J+HcgfQ7vyE3Vd2q9a0BPyPQp3olc5RKbiTEVBS7wtp24NdVsNS
	vjdiqiH84VsLvIVtHW7zoma1GzUR5I7buAXewxU2CgFIIxreZ2ZbKBugLeLHarD8=
X-Gm-Gg: AYBFou0NLNZsIQYN018whvWYqmqxIr7hiDGFLP9n7NCD/iqViXoP5BsyeknHCdUlKr8
	zV4qiaKT0gTQe0ageSW4yqig6IFZ23/TfIenN6kbIlFKM1LvU7NrgxAJ63B6t+Y/ucCyduauBtZ
	LAsl9RsZqBa67c+G6Ul0zjway1FmCpvG5kiobzjU10fp7K+NC74oPsTJWvgPPKx68UZFhWDx/uR
	OggG413z7MZ402DgsiV96QCmtxbHnJMD4nL90Bnkv41TQWzJj4Wy509HmJPbxZEnYGiBkG8h6sW
	Prz7PbmGSOAYI+EK2B0278zcn00JdGmXSbYZDzvaBsUoIEZsoxyWxKVPCItvEutSaQUoKWtQI1h
	ndhVD640PCkO1kw0K2hk/BKQ3xNwM2emaTw6qPlBMR2H8NTyheio0aa4JjVW0mN4SPQ==
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr13180543a91.62.1793751647527;
        Tue, 03 Nov 2026 16:20:47 -0800 (PST)
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr13180527a91.62.1793751647042;
        Tue, 03 Nov 2026 16:20:47 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094453532sm1090412a91.3.2026.11.03.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:20:46 -0800 (PST)
Date: Wed, 4 Nov 2026 00:20:42 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Olivier Moysan
 <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 01/10] iio: frequency: ad9910: powerdown fix
Message-ID: <20261104002042.10064e8b@jic23-hlaptop>
In-Reply-To: <20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
	<20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfX6I3m1RuPop4S
 4vuNLtecvIb95YcqkQ9GUUJPmfcU8T8n8gGQDsJ9qPBniJwEYJyYbTXJ5yMbsc9aJRqgMHk0j/W
 URHnRr6/q05sRwnqNnUX4w53pH9OJt0=
X-Proofpoint-ORIG-GUID: bSPxgo63u5ymXzjcNCLKOkaNaKxOcY_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfXwcMkUu264TT7
 EfMDH0AcQMO+s0hneNTwrYxgZSVjRDFSZowwfk1H2TftZtVK2QRreHkNmYgIXwQv+l0iblm1Wc8
 ByE85oQ4nXSpiLWHviv0iIXr1s9YphXpMADQ8xrALjXTZ6fodP4YbTf/+dfp6w2zT9WpXbFzXzI
 ohR9oAE0cwmhbRPJBXa9ezcQCFwhLlgz0olxAxbbK1ja4rc+g/L/x4og/CEoDIz01fgwdGtn7KM
 qsC/pp6F6RdTpD3k2noFOVCZVp7nNFzsDW0sjLp6iTzGY9ceAVlD+ZUxYABzslnfpRZzjLRS5MU
 S414xJnpvYzSp4VYo7ij//TpkCMsEVxA4Yk+OCUdQvhnCcB4TEWra4coHg1j+rqIHtVjl8We66T
 CgHkuti3y4fnt2DcsBf0yhhMO82VG6ANhI8PLsOJo+4MeTdJEt9aWmG9SIFbZjlF7nNX0Xs/9EE
 04D4jbAcRNhtfEafUug==
X-Proofpoint-GUID: bSPxgo63u5ymXzjcNCLKOkaNaKxOcY_H
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aea7a60 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=Pob1JPmMRzAnXopCxDUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040000

On Tue, 03 Nov 2026 11:52:57 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Enable the software powerdown on all the applicable CFR1 register bits at
> once with an IO update.
>=20
> It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
> when enabling the powerdown, but that is not the case when powering it up
> again. It is an asymmetric behavior, which was observed while profiling
> power consumption in the lab.

Just to be absolutely sure I understand this right... The bug today
wastes power but otherwise doesn't break using the device?

I'm just trying to judge urgency of applying this. Is it fine
to go with the changes that follow later in the series or do
I need to rush it in, potentially delaying the rest.

Thanks

Jonathan

>=20
> Fixes: 22452fe6cd08 ("iio: frequency: ad9910: initial driver implementati=
on")
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/frequency/ad9910.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad991=
0.c
> index 04a4e184b873..8bc24d0b7442 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -621,26 +621,16 @@ static int ad9910_sw_powerdown_set(struct ad9910_st=
ate *st, bool enable)
>  	if (ad9910_sw_powerdown_get(st) =3D=3D enable)
>  		return 0;
> =20
> -	/*
> -	 * When powering down, the DAC and AUX_DAC (SW1) must be powered down
> -	 * first, as they require an I/O update to take effect. The opposite is
> -	 * true when powering up, the DAC and AUX_DAC must be powered up last,
> -	 * i.e., after the DIGITAL and REFCLK_INPUT (SW0) power up.
> -	 */
> -	if (enable) {
> -		ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
> -					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> -					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> -					  true);
> -		if (ret)
> -			return ret;
> -
> +	if (enable)
>  		return ad9910_reg32_update(st, AD9910_REG_CFR1,
> -					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> -					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> -					   false);
> -	}
> +					   AD9910_CFR1_SW_POWER_DOWN_MSK,
> +					   AD9910_CFR1_SW_POWER_DOWN_MSK,
> +					   true);
> =20
> +	/*
> +	 * When powering up, the DIGITAL and REFCLK_INPUT (SW0) must be powered
> +	 * up first, as they do not require an I/O update to take effect.
> +	 */
>  	ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
>  				  AD9910_CFR1_SW0_POWER_DOWN_MSK, 0, false);
>  	if (ret)
>=20


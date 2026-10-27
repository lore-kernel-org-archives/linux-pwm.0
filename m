Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123588;
	b=Py97XjF3AGCmCEASvFgiDLLzUTHa6EX2pKXo/tsKbWR52a41WxA8jk5CRcP3LlPGyr1s
	 RuGSRgoxPc63aDnOf8n5+MpWi8qHO1x4eILYeVUVdD+u7IWQT7eDDWUebUy9ZQGO7vXp2
	 fLjxY7PnK+ZhI5L2mj7Xy7ycPrUHgd3hsKfzi59PyXDg5pnHaOEMZkbkDGvkvLce4SjGX
	 PkOM7sF+spP0ws/BjuefHco5KdmAl+7Z4nPcUvZggP97CXVmBv5foDUcHHXOHrSx14jeQ
	 ghiTeUQK7pPGRDWJkBvIWiMpFyeBNC8Ke9raqV0kM+gxQiyyq8/gS+Y1ifFCBJuEwMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123588;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=b3m0F+WvDuJINnJ7GkvHTx0Xqp13L22xT4XAuXwi3ok=;
	b=BQSP931tJhBnHbimsuZITLwGdrx6xr733rztaeSbGVTEdPAq8u155Y2eE9C8Gf5zfnU9
	 NVVeqClPB1Qs7HiazY+aYEk5tmsQMeMd8pCsutf0yGHKhzq9IlXx7zPZwnFrTfqjykn4B
	 6MeEnEE6/XOWOHUaiJq9/CXdf1i365FYvI7eh9E2b3VlENsER+6D02VaEmsaDdR009bvv
	 iaXygzuwUbCOj+/dWE+hTDOJijTAAMpR+53Wwvk84j0TWyALfPLBMUFkG+YLA07MyvxrV
	 0o212GxkS5awS5s9NSGbZuhLRMU+GQb1je8VOtSaLRZl+qnhHLvdq0AgEuHHKTK9GTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k8I5eHhx;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D4606A31F;
	Tue, 27 Oct 2026 17:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06D4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k8I5eHhx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 99088C79AB6;
	Tue, 27 Oct 2026 17:54:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D887E603BD;
	Tue, 27 Oct 2026 17:53:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D509F1032907F;
	Tue, 27 Oct 2026 18:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793123577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=b3m0F+WvDuJINnJ7GkvHTx0Xqp13L22xT4XAuXwi3ok=;
	b=k8I5eHhxIwSbD6Mv8BfBl1QaWaWFOcWbwTOqJSkQth16cxa936Hx52QgdUzyWJQ/n4kcur
	gJCY4sONExuYE9K4z0oRam20yS+jp/5YKoHVUN6g83mEYG44G8++o1o4nS6vXj9PDqR6eT
	ClVhpeXa+9EjzvZo5+U0kX6pqJ0tLR73RaUPQNuXg+L+v9JBqYt1ZsbmJNNpfhY36NFrau
	jKOoMOJi5lfBwp1fEFfHqRNneSv67OdGGLpuQ3lH/t7Q5IvvQXqRNtBGDCkfF+ZEQYOpHi
	HEEp2Psgk5Q1qN0kdCLBpjYNUtYrSY1MKjh4Pe1EOWXZN82n3JfBWYcF6xwmFg==
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=466219900224659f40c92d0c0f2d2ecfa86efcc1b91140ad1780941a0644;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 27 Oct 2026 18:52:48 +0100
Message-Id: <DMFT97DWMREU.2S2E4MOTT54I7@bootlin.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Chen Wang" <unicorn_wang@outlook.com>,
 "Inochi Amaoto" <inochiama@gmail.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, <linux-pwm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <sophgo@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Jingbao Qiu" <qiujingbao.dlmu@gmail.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: "Hiago De Franco" <hfranco@baylibre.com>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
 <auCsaQt0kda01tZ4@hiagonb>
In-Reply-To: <auCsaQt0kda01tZ4@hiagonb>
X-Last-TLS-Session-Version: TLSv1.3

--466219900224659f40c92d0c0f2d2ecfa86efcc1b91140ad1780941a0644
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello !

> On Fri, May 09, 2025 at 11:45:42AM +0200, Thomas Bonnefille wrote:
>> The Sophgo CV1800 chip provides a set of four independent
>> PWM channel outputs.
>> This series adds PWM controller support for Sophgo cv1800.
>>=20
>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>> [Thomas since v8]
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>
> I see this series is abandoned. I worked on a patch to enable PWM for
> cv1800b reusing pwm-sophgo-sg2042.c driver [1], as Uwe asked.
>
> Is it ok if I take over this patch?
>
> If yes, I will wait v7.4-rc1 and send the new series.

Yes of course go ahead, I already worked on something like this but never
had the time to send it :
https://github.com/Taumille/linux/commits/b4/pwm_sophgo/

Best regards,
Thomas

> [1] https://github.com/hiagofranco/linux/tree/v7.3-milkv-duo-pwm
>
>> ---
>> Changes in v8:
>> - Rewrote supported frequency
>> - Hardcoded HLPERIOD_BASE and PERIDO_BASE
>> - Change usage of update_bits to set/clear bits when needed
>> - Rewrote construct of enablement of PWM
>> - Fixed OE activation
>> - Fixed hw state modification in case where pwm value cannot be reached
>> - Renamed variables
>> - Errors out for new cases
>> - Reworded some comments
>>=20
>> v7: https://lore.kernel.org/linux-pwm/20240501083242.773305-1-qiujingbao=
.dlmu@gmail.com/
>>=20
>> Changes in v7:
>> - add detailed Limitations
>> - using BIT(n) instead BIT(0) << n
>> - use 0 instead of disable macro
>> - modify OE judgment criteria
>> - add devm_regmap_init_mmio error message
>> - delete unused variable
>>=20
>> v6: https://lore.kernel.org/all/20240406063413.3334639-1-qiujingbao.dlmu=
@gmail.com/
>>=20
>> Changes in v6:
>> - delete the OE function because we plan to use the counter subsystem
>>   instead of capture, so there is no need to reuse this code.
>> - fix set polarity reverse error.
>>=20
>> v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu@=
gmail.com/
>>=20
>> Changes in v5:
>> - drop filename
>> - fix macro
>> - optimize cv1800_pwm_set_polarity()
>> - optimize cv1800_pwm_set_oe()
>> - add comment for cv1800_pwm_set_oe()
>> - use ticks replace tem
>> - fix duty_cycle larger than period_val
>> - use devm_clk_rate_exclusive_get() replace
>>   clk_rate_exclusive_get()
>> - map linux polarity to register polarity=20
>>=20
>> v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlmu=
@gmail.com/
>>=20
>> datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/dat=
asheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> page 614
>>=20
>> Changes in v4:
>> - use macro instead of npwm number
>> - add support for polarity feature
>> - add support for Output-Enable/OE feature
>>=20
>> v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@=
gmail.com/
>>=20
>> Changes in v3:
>> - use 0x08 instead of macro
>> - split if statements based on conditions
>> - in order to round up, first calculate the
>>   number of high-level cycles, then subtract
>>   it from the PERIOD to obtain the number of HLPERIOD
>> - use new pwmchip_alloc() API instead of old style
>>=20
>> v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu=
@gmail.com/
>>=20
>> Changes in v2:
>> - drop full stop from subject
>> - re-order maintainers and description
>> - pass checkpatch.pl --strict
>> - fix naming errors
>> - add "Limitations" section
>> - use a driver specific prefix for all defines
>> - using bool instead u32 in cv1800_pwm_enable
>> - check and set state->polarity
>> - use mul_u64_u64_div_u64
>> - use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
>> - using macro definitions instead of shift operations
>> - remove shift operation on 0
>> - use priv replace cv_pwm
>> - hardcode npwm
>> - set atomic to true
>> - remove MODULE_ALIAS
>>=20
>> v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@=
gmail.com/
>>=20
>> ---
>> Jingbao Qiu (2):
>>       dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
>>       pwm: sophgo: add pwm support for Sophgo CV1800 SoC
>>=20
>>  .../devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml |  45 ++++
>>  drivers/pwm/Kconfig                                |  10 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-cv1800.c                           | 294 ++++++++++++++=
+++++++
>>  4 files changed, 350 insertions(+)
>> ---
>> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
>> change-id: 20250407-pwm_sophgo-5032b3858c27
>>=20
>> Best regards,
>> --=20
>> Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>=20
>
> Best regards,



--466219900224659f40c92d0c0f2d2ecfa86efcc1b91140ad1780941a0644
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTQT2V0EKPIM2RnVpHcsfBJI7PEOgUCauDk8AAKCRDcsfBJI7PE
OgofAQDybuOAzQehyj4uWoDlxxAhJvgAFUSOFKewcZ3kbWlx/QEAv1EmaRDiVfoW
l/I1vmcaueNFxv6Vc3wZOvObW7w9zQM=
=5e20
-----END PGP SIGNATURE-----

--466219900224659f40c92d0c0f2d2ecfa86efcc1b91140ad1780941a0644--

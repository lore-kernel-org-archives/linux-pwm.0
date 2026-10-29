Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.233.34.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265932;
	b=PFG/TVQIH4D0C3d6D/WtjeeUgy9h0kXIdbIJQEzmYyiwyCwyl9f01f/X8SsiiCa/wMJU
	 JjF23JYIvbDYrrIHGwfCRMeco6tKgB7PnZ0fr29gidHXEg5cs01CpZ5oZjb+20vcT9Z62
	 VIB+NXpNgNAUUbpak/XmudzAMyUaJCCq9bX9eXtMnK+MF3xSDTAfl2DQm1DwnbNnbtL/0
	 JBNw6QOEGqsr6wIy3UtMHRYx3RAhu1sbED0DXtZ7xu+6vCeWvp/+/CSpVKuE0Puj0ZIbE
	 usxPb/MAdXlhepDf0EpxsSLBT5XF26ZDplU98hAktstE/twWhFv61/Vite/8hfe+zow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265932;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-CM-Envelope:
	 X-Soverin-Id:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:References:
	 X-Spampanel-Class;
	bh=lmBuoMUfPtdILzvdThWk+I2StXUMo6PgR05OK0TYJQ4=;
	b=cMZcTLYm9GaMVGyDUBCtmImVLKr9hC2eQTCXkgMn7MSPB0e2LDwhLhixuz16sd0IrSoJ
	 +iuXO1IJIYjH0b/T58jpcGlC1shTbIlav5TuGjADRBdv9NAlqMu+Jo8zKu7JCB7eKXPOD
	 NxzepA/zqfV5IV4Mvb3tJwuw1qHR65haanmPNVJ55hJoWDSQxSwYeqn+9WgKbd0m9scDO
	 zDDOHRwdETKNb4OK1vHrK2dSw9O1bPt/GcF8epJgxKzMRFV2HGcv7qi455ESanN4TLfEw
	 35eAIP5ndE9EUl4RLOBU5ZmO1M+5r1nQ3FgeKkb2AywNJIZd+iQ34UrTWwl1HHEgQyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blackstar.nl;
	spf=pass smtp.mailfrom=blackstar.nl;
	dkim=pass header.d=blackstar.nl header.i=@blackstar.nl header.a=rsa-sha256 header.s=soverin header.b=brejh+2y;
	arc=none smtp.remote-ip=185.233.34.146
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A48606A31A;
	Thu, 29 Oct 2026 09:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackstar.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackstar.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackstar.nl header.i=@blackstar.nl header.a=rsa-sha256 header.s=soverin header.b=brejh+2y
Received: from smtp.freedom.nl (unknown [10.102.10.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4jFf374QNPzXTT;
	Thu, 29 Oct 2026 09:25:23 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.102.10.153]) by freedom.nl (Postfix) with ESMTPSA id 4jFf372mfvz1Fmh;
	Thu, 29 Oct 2026 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blackstar.nl;
	s=soverin; t=1793265923;
	bh=mPcH9yUJR8Lq6Viwwx8vM8rEwIePxRgjFV0ZYkyNql4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brejh+2y6hqzLX63zDzi34bIaFMOoIaGxFxKN004YKZYe6T781WtXEBsBxzh4JngI
	 vDrq7TrjL7vdRIrFGCovZEkLztHmXohw5vzR1n+bwKG+utErYgagnbsv9tlGubtPtY
	 J+7wWtv857qeUglV2a6IIYvCvHn+c69ygv3ND2XwZZAKix09uB/2seIw54qIdlPE0N
	 qnZv9GTksozeX2ZDezQFqOh6fk1rkj0ENXziA/EM+z6vG5QG6inwrgnkm5kDi/g2yb
	 MXosi3dwDPlEcM3iqf0t+KR+qER4uvZis+qsmV4OPvqjbkwLUozWtTMqEC08Y8zQUc
	 McDKK2REC/Ajg==
X-CM-Envelope: MS4xfGhtgRHNjV/Y7PxulfcY31YnGRcDgXHoO4rsoQgcrPSH0vjkd497HF5N09wbnKa1pajdJ3yXRPC7uB2oXcwkwc10CtIJctelfMKsSxVM/nNRNfxsYsoE pEeYLSJO93yUjgo2RZCih2k8DQMD2FY2xMcuNVUIYccNxbSvUUp1RP3ilLye104ZS+eihWnyanA5MO1bXaxu9vNu/KZxXspU9kDs+UUd4P05h/eHJsjLRdHV Bja6idH+BZvVH6eUPq8ZvvY2Ykr3hfUMIF0S16WX48wkQjT4Mf4wddyGFv4x+HRbBbdbPmTnGSlBCPyMCtWe5+bTjGMEDJBxsD9JpliG83fD0r57n8mph5yM slIS+XHpu1mNzP3YRpA1zuLhrhw26aDCqBYtpTsU9rqX+hYcupADjws9aZQirCzNxPglggvWbypQkYn7SbU7pidrftqFRDg9LCigCoyPzr6gzKH6evQC73Vc lOrtnPG58TRoIkpN9MySt3/by57f0eJeZZ8oOBetOrTSlf1o3QqLmzvyFOztrbZl45fxBt3L2EV7Fgapnbe9nRXgs+ZBh4BQ9ASGdQ==
X-Soverin-Id: 01a186fa-73b8-7625-910d-49e7a653716d
Received: from blackstar.nl (m17r5.blackstar.nl [192.168.3.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.blackstar.nl (Postfix) with ESMTPS id CE5A63FA91;
	Thu, 29 Oct 2026 10:25:22 +0100 (CET)
Date: Thu, 29 Oct 2026 10:25:22 +0100
From: Bas Vermeulen <bas.vermeulen@blackstar.nl>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com,
	linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
Message-ID: <auMRAj9wGYmH6ZI1@blackstar.nl>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
X-Spampanel-Class: ham

Hi Nicolas,

On Mon, Apr 20, 2026 at 06:52:40 PDT, Nicolas Frattaroli wrote:
> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> referred to as "v4". This new IP is different enough from the previous
> Rockchip IP that I felt it necessary to add a new driver for it, instead
> of shoehorning it in the old one.

The same IP block is in the RK3506 (Cortex-A7, arm32), where I am
carrying this series on top of 7.3. It works there, driving a PWM
backlight and a pwm-regulator for the core voltage, but two things in
this patch need adjusting for it to build on a 32-bit kernel and on
current mainline:

> +	if (rate) {
> +		wf->period_length_ns = DIV_ROUND_UP((u64)wfhw->period * NSEC_PER_SEC, rate);
> +		wf->duty_length_ns = DIV_ROUND_UP((u64)wfhw->duty * NSEC_PER_SEC, rate);
> +		wf->duty_offset_ns = DIV_ROUND_UP((u64)wfhw->offset * NSEC_PER_SEC, rate);

DIV_ROUND_UP() with a u64 numerator is a plain 64-bit division, which on
arm32 becomes a call to __aeabi_uldivmod that the kernel does not
provide:

  pwm-rockchip-v4.o: undefined reference to `__aeabi_uldivmod'

DIV_ROUND_UP_ULL() goes through div_u64() and works on both:

-		wf->period_length_ns = DIV_ROUND_UP((u64)wfhw->period * NSEC_PER_SEC, rate);
-		wf->duty_length_ns = DIV_ROUND_UP((u64)wfhw->duty * NSEC_PER_SEC, rate);
-		wf->duty_offset_ns = DIV_ROUND_UP((u64)wfhw->offset * NSEC_PER_SEC, rate);
+		wf->period_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->period * NSEC_PER_SEC, rate);
+		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty * NSEC_PER_SEC, rate);
+		wf->duty_offset_ns = DIV_ROUND_UP_ULL((u64)wfhw->offset * NSEC_PER_SEC, rate);

Since MFD_ROCKCHIP_MFPWM allows COMPILE_TEST this will also show up in
32-bit allmodconfig builds.

> +	/*
> +	 * For referencing the PWM in the DT to work, we need the parent MFD
> +	 * device's OF node.
> +	 */
> +	dev->of_node_reused = true;

struct device no longer has that member: since 7.2 the flag lives in
the device flag word (commit 4aca5e62f37d "driver core: Replace
dev->of_node_reused with dev_of_node_reused()"), so this does not compile
against current mainline. The accessor is:

-	dev->of_node_reused = true;
+	dev_set_of_node_reused(dev);

With those two changes the driver builds and runs on the RK3506 with
7.3.y; happy to add a Tested-by for that if useful.

Regards,
Bas

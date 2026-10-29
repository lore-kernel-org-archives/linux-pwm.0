Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.233.34.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265762;
	b=z62UXctMb4Q6DctbFQHXaUHhrv9Co/PyWx/uaUpRf8ibm0v1fuhTYOeO0JreHTiavEQy
	 zMPT+9XJXLlV0GZqSq3BR15d5m5HXnkvb+ISwaKS6ZUyTsTzxgvfOz6wVUnaqbopHIIZA
	 OWAUQ8hxr2WsGAumiH+vXvG4XuThmEXnh3kpK6Y4Se+YvEergQg1mYq404m6tY56EbZyZ
	 BFM6Lf7Bprp09R8ZrKLpbjeQ93CPjpi5NlL1sT/hxX8ZF9MQTGcj7BRiZ5YcjgW/DOD3v
	 QPAyf5Hc+5zSDMNMKw+NI5Pj5/Q6bzWvnNtbqn5p+MRKsyQe5FhkVrTmDjMjdisgeog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265762;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-CM-Envelope:
	 X-Soverin-Id:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spampanel-Class;
	bh=lmBuoMUfPtdILzvdThWk+I2StXUMo6PgR05OK0TYJQ4=;
	b=w1xPIeRs8zpfmLoOaV93bu+u56PSV5jVry8iPpLAjPaSRqxH/lSPtBeb9isUmr/7u1Ke
	 /g5rpTUZRH0Wvttix3umnbB+b88VvceJFzcOU7uqLKrXoR5Zk1SSnZNhgfjbIjZDO6NBC
	 JDXj3dFLInVKsQLAQWEF412PXyc/SEomi+3yeS+sVBLBLBXHrIsnV0RAv1C29fFGv+fAf
	 5NWy9MLMurz+QfDuJWH/IHFRZWZGqgPZAOCKdubFNliLXtvh1xJqNfRnJ3dsFfM2ZF8gl
	 8DoekMmP1NkfkdDGUAo1sVD12ygU4mmLaQLvL9SXx8QaimaD8Ly3McSjMvUuiTh2pFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blackstar.nl;
	spf=pass smtp.mailfrom=blackstar.nl;
	dkim=pass header.d=blackstar.nl header.i=@blackstar.nl header.a=rsa-sha256 header.s=soverin header.b=Xp9mItBp;
	arc=none smtp.remote-ip=185.233.34.18
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFF606A31C;
	Thu, 29 Oct 2026 09:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AAFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackstar.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackstar.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackstar.nl header.i=@blackstar.nl header.a=rsa-sha256 header.s=soverin header.b=Xp9mItBp
Received: from smtp.freedom.nl (unknown [10.103.10.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4jFdzq0gk6z1NH0;
	Thu, 29 Oct 2026 09:22:31 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.103.10.152]) by freedom.nl (Postfix) with ESMTPSA id 4jFdzp5lKJz1DBX;
	Thu, 29 Oct 2026 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blackstar.nl;
	s=soverin; t=1793265751;
	bh=mPcH9yUJR8Lq6Viwwx8vM8rEwIePxRgjFV0ZYkyNql4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp9mItBpjh/pxgWpegBfAurtunamUF70aud0SJXY9Su4c+7JsT/e8y/cqUeqKd+WU
	 p57x/IAFLS+azpdboKNGY0uxbYhS3pvlYBzWoKSspz7CS3xwAuh93FrsqhVj8suk9/
	 sFFCD8XHHlFURy1WeXSGryw/gmpKvoiRiC15Icdy3SCl7BKmiROPBfRYd24bFpWzl0
	 7x31PUXCncoy0PBd8k+G/BYabWRez5vORbqned7QVLs6NOOdEDJ0CNjWoOIlnC1e7G
	 qgebL2cSyRgA3CZKbJofmA7zfYvRAVVbMHmSx1u1Ug/eHlXrO//HzQJHiNMW/8rdpq
	 fSIDE0ig6Iu9A==
X-CM-Envelope: MS4xfMVHYTJlhsrIp3dayFAJ3bdUU8/zYSur98eWcaQArq5n3dIy5cT3GmElwlcF0CZwaDmoiVrHOC4X7Y+eNno2nm2LxBbzj6+glBi0ALh20Iq1ZEPu4pnt aEtV9HJ39eO1tmeyKJ8cgSFehOjFn+FEfovV4DU9VF3bYnckXaDoavC0D4mcXAhTFSFK6JZL7tj3h5fKNiwNRwjwunif7636U3QX0oxMlRZuJSC0yCjYwWfS km3XEDhpGtRSBIpSewYboplHIPVQvYRv5kUfVck7EMjD4CYRxGOEyxkEZ6bj/Tx9F/BxMNlL+62KmsXwVvbSfVXJr9QNEb0+89tnVPtFmooP6tgLdTd8soJi YA4FZoSnlbxiH0U2BkmqMD++I5qQaGenpfi1/kxEVW8sHCQndU+urRLHzBFT/Xb7dvBf06jKNTi6jvGG3KfryjhaCsvyjwfNAKW2GZmnHex+ejxtPahMxE0e Cquv5lHigwcW2heGXACdzbe/mfSe7xO/8ymECn2X1Izf0kTcgA1fOE/6aYP9/undzFzE9Hw+Frk2B26n+13y3NLbh6ZenVmCrkcF7Q==
X-Soverin-Id: 01a186f7-cff0-7f6d-b1a2-6ab1d5091462
Received: from blackstar.nl (m17r5.blackstar.nl [192.168.3.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.blackstar.nl (Postfix) with ESMTPS id 1C5CA3FA91;
	Thu, 29 Oct 2026 10:22:30 +0100 (CET)
Date: Thu, 29 Oct 2026 10:22:30 +0100
From: Bas Vermeulen <bas.vermeulen@blackstar.nl>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com,
	linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
Message-ID: <auMQVkm3liY6C2GU@blackstar.nl>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
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

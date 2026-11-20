Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189514;
	b=dRDzoY641U93NZmKO+t/0Igai/wmS3U7kTwlVEX/sWK+u5RfIpFkf/MSu/CszfzHuurq
	 B1KluW3CjjViG4kGzedZPG2d6pjRJpxUeOIOx5pRyr5fRHb3V6I0nMUDBzL92eNx0ZnWV
	 ervE8NtdZAVxLor4ZerJE8NgSK8Zi4IEBfcd3wOyDOLcsLTMGusBZ5nsRvlI9miqP85Jf
	 v5cI+hu9jw3hQl1FmDYizbZZFbpJ5Factm2KrzDXtsDGFwvUyOmPVuH21p3HEh06W2dIy
	 CIc1dA+HrufU9bkvDXfFlalZ3fPDqJO3MnNiAWr182aN12hV0VIbfRmlKSYud4PJswg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189514;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9CxTExrzL3kATeAM6ygWp3ufG5hvlr8xzSC5e3ulCyQ=;
	b=Ip8KChlya3MVouAOoIOXpMKrXRA8qP8JAldDf1egEP4zCrf2zKbhC4rh3aR+BNrrhEfm
	 xaYcGX5ZPpcVz+JganoykWa7IJSHDgEeW99nXhsWgSv4KxU5bIFyvqdBD4zpjHSFb5k7Y
	 81Zr//R7fLy9cVnem3Xjywl1fYIwc3Zn2EonMETz01uoMKdAJYrZ69qDjqY8HYu9VzRid
	 7/K0RUHbUBMNRItxqMU2+HcDNS7dez5WqUfB/qiLmzKcACTqL481yU3VuXfh28SNhXoNT
	 mpK/O9aYAea+jB59/zAzA1j1Wn7QEQlC6avvGU54wGquIjLyxYIK7tSl7+5A2UJYeaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYfkIXaQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7C959606A32A;
	Fri, 20 Nov 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYfkIXaQ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 72EE61F000C4;
	Fri, 20 Nov 2026 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189514;
	bh=9CxTExrzL3kATeAM6ygWp3ufG5hvlr8xzSC5e3ulCyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NYfkIXaQ7K9996vy7S3LxJCGXvh73w6a9/xv+XlVLTSOdlQecNdrelyJKMG5PRRMv
	 71/tC33C4YOxotc56Y4VJW7L6PpRh50mCRXHdakmnrMsk/IrBqEcf4/LHPMu2lopC+
	 iXqDhydmRiLH+7Jsz4R5wSeeOPcw5DeCP47Yhc28ddzKwzTao7gvDzPxbGLk+/ouUP
	 CRXcSDjkYnGyWqFh2+r2v/IXFwMLHRQzXyLMfnAwrsRTLWybrNEZuY8lSnvTt5OVqB
	 Uu0Fze9Bw4DsF0ii36eXHZdjT5EAuJ394EASPmZSjfUvEi64Cup2AMZDYySlYq+rPg
	 s6y439xcJK5+A==
Date: Fri, 20 Nov 2026 16:45:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v6 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Message-ID: <awBfa9jMlhCTR5xV@monoceros>
References: <20260914110739.203479-1-cwweng.linux@gmail.com>
 <20260914110739.203479-3-cwweng.linux@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghj4wwdna3eordl2"
Content-Disposition: inline
In-Reply-To: <20260914110739.203479-3-cwweng.linux@gmail.com>


--ghj4wwdna3eordl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
MIME-Version: 1.0

Hello,

just some nitpicking left ...

On Mon, Sep 14, 2026 at 07:07:39PM +0800, Chi-Wen Weng wrote:
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define MA35D1_REG_PWM_CTL0			0x00

The manual calls this EPWM_CTL0, so I suggest to name this:

	MA35D1_REG_EPWM_CTL0

> +#define MA35D1_REG_PWM_CTL1			0x04
> +#define MA35D1_REG_PWM_CLKPSC(ch)		(0x14 + 4 * ((ch) / 2))
> +#define MA35D1_REG_PWM_CNTEN			0x20
> +#define MA35D1_REG_PWM_PERIOD(ch)		(0x30 + 4 * (ch))
> +#define MA35D1_REG_PWM_CMPDAT(ch)		(0x50 + 4 * (ch))
> +#define MA35D1_REG_PWM_WGCTL0			0xb0
> +#define MA35D1_REG_PWM_WGCTL1			0xb4
> +#define MA35D1_REG_PWM_POLCTL			0xd4
> +#define MA35D1_REG_PWM_POEN			0xd8
> +
> +#define MA35D1_PWM_CTL0_CTRLD(ch)		BIT(ch)

I like it if the register this bit field is defined for is a proper
prefix of the name, so please rename to MA35D1_REG_EPWM_CTL0_CTRLD().

> +#define MA35D1_PWM_CTL0_WINLDEN(ch)		BIT(8 + (ch))
> +#define MA35D1_PWM_CTL0_IMMLDEN(ch)		BIT(16 + (ch))
> +
> +#define MA35D1_PWM_CTL1_CNTTYPE_MASK(ch)	(0x3 << (2 * (ch)))

The reference manual calls this CNTTYPEx, so please rename to

	MA35D1_EPWM_CTL1_CNTTYPE(ch)

> [...]
> +static int nuvoton_pwm_config_channel(struct nuvoton_pwm *nvtpwm,
> +				      unsigned int ch)
> +{
> [...]
> +	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CTL0, ctl0_mask, 0);
> +	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CTL1, ctl1_mask, 0);
> +	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL0,
> +			wgctl0_mask, wgctl0_val);
> +	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL1,
> +			wgctl1_mask, wgctl1_val);

I think these lines are short enough to not break them.

> +	return 0;
> +}

Best regards
Uwe

--ghj4wwdna3eordl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAawMACgkQj4D7WH0S
/k5Bogf+I9+wjvPp6RamXalq4J4R7DZ5hp2Jlexu1TfyjL9nyTVT/kY6M1IuN9IB
LfLIYkgHk/eW9wWejLQVdbh1zyMonOnaGfRsL7eK81qeX2HjBxNnbnzd7y6qy7lI
9n/uuaaJ+fVw/5jGmhuhgmrIwd8wiCD2N02u9fm2Yv6c4TlFVfn1nn4oRNQ7UQ1M
40tHBzcYV+Le7+SgIMU4BvtsZAD+vbaNFx6HY488zG8PuKOptKrGQhOGvTvXQ4Na
C/AdG7SR03mlxLKf/i+2B13lNSFFY2vudsTpzhkKYQ55cIrk+0BMCv0oaK4qwJ7H
T/D0VdOZl7XQ+G91htlMluNddWRuJw==
=qdzv
-----END PGP SIGNATURE-----

--ghj4wwdna3eordl2--

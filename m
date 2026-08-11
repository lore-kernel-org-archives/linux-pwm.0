Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112837AA86;
	Tue, 11 Aug 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426781; cv=none; b=R1YuGnRWatOA2xKcIdU9eVQzZa3Gm7E35EMYcSsrTevMjNrrCUa8EyjVj1GDwO6VLOVGkGm2yTGhfEAfwPtykRMBouBZakSAqfTRhqcQ4/FDwSRtwD1fC1/zfxwVQ8y4polyblfPoApa7X3UHxF8YFv+zvucGancjsd1al2vgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426781; c=relaxed/simple;
	bh=dItY3Tma/dAnlPJRgSMaIt+PwfV7Q6Vb8/RBB1hX82Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZpJyvztJ904PNaRRXJDC/Ph/0xUq0UJXW/PmgjRzHDAsnp6+YVLoFi+RUlAfTFQiXYhFDDYk2gyAzwOsJBX96Jq9xiTGPSDUhH/P+DveYIaZZHj7jHhCoiUhttAwSjakCX762jjVJEXrb5+jdt2D6gBuT6RjqdSCpy/kI5JGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPo7jEk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPo7jEk+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CD2501F000E9;
	Tue, 11 Aug 2026 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786426780;
	bh=PVRjEd+kZhZg8HLXQAKGqisRTlxsYR6JFwMAr6Wsqlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPo7jEk+Q4mt8XfN0scsW2QTfWkzc0U4D5xzvVRdQQznTce91EFBloVj7y8Ap3AIo
	 bPehvJay4tMQM1QQSyHkWaxwgvsbHoDeMlw4SjlhikWyU0K5z5c2WFI7E57EMDo5No
	 Vm/RvpXilYC+aUVTaubikMbTDs3hh/dWC7Pi3Z0KlUV+RW3f+ZRohssJmDHimmhXzv
	 XltZK6kKLKmNOLzBlKt9njr+mXqB0Lshx/qXZEgGet+6Z23LpA30XgsgGLhM7OmIP+
	 it7tS1WiRJXLbH7/IAssOwdSYpjtePJw1j2eDwUwrq4v3ETp3duCRkfua4pGNzFuc2
	 bgys+9160W9VQ==
Date: Tue, 11 Aug 2026 07:39:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simon Glass <sjg@chromium.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 24/25] dt-bindings: pwm: rockchip: Add RV1106 compatible
Message-ID: <anq1YM2KzkycOzNm@monoceros>
References: <20260810121121.210040-1-vlad@zlab.su>
 <20260810121121.210040-25-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gpmqgtx6potrl4vk"
Content-Disposition: inline
In-Reply-To: <20260810121121.210040-25-vlad@zlab.su>


--gpmqgtx6potrl4vk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 24/25] dt-bindings: pwm: rockchip: Add RV1106 compatible
MIME-Version: 1.0

Hello,

On Mon, Aug 10, 2026 at 03:11:15PM +0300, Vladislav Leonov wrote:
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Some PWM channels (e.g. on rockchip,rv1106-pwm) additionally
> +      support capture mode and use a second interrupt for that.

Is it clear what the first irq is about? Maybe spend a word on that,
too?

Otherwise looks fine for me.

Best regards
Uwe

--gpmqgtx6potrl4vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp6tZcACgkQj4D7WH0S
/k5RHAf/R7W8O+VpQTenNcdbj3+MBzfCjU8fbsl3SWCqANP3kcF+wLHdOLbJmA1f
1/DvuQRZdCftgmaCPuCn3Vtt68ALFik0dc/wo8gHyZrjVaW0aaiR9GyoXG5Cj4Ud
2Pm6dV41hhDsJ9r8PuQxh8gxtaPm3bL1zSM5qTDLAbbh1zL/MImpZIHeYIwGKV9G
XmtJuvfIT4gswMpGQg+CWkUyeBcXx/BogpMNzLXMm39sFBaO93GFVS2VMreqiprs
qljd2zEMEtRAXKAwWfSZPdS/bEaOzcZYQyiCfkY4cDwbZuEAt+B91riWMh3KWc84
I3EB9kHeg4I8C+pPvuVD4E+bBBwTtw==
=BPVG
-----END PGP SIGNATURE-----

--gpmqgtx6potrl4vk--

Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F312D9EDB;
	Tue, 21 Jul 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638239; cv=none; b=LY+03FkYGrEe1yl9U0rPe1glx48nA5XOWwpMkC3MJozTacrE8jbVcXWz0x3S/LHcfYK3kLBLd4Eg6LKvub2kFC9u2DjgGYeDgr0MNblmkeztkaQGrlfWvs4jyzV4lF6rpiLrgX8aMDUlg9EcdyvEV/ZyXVOcag6RUxOOJAQ1rAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638239; c=relaxed/simple;
	bh=BwwIV+5r/65HpKpyxSowPtoXfYNPnuISEkkQrDHI6NE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dgVXSFJnXjg/xvZcY3URk7YZC4HvMCBZNTNr2IZXdjoPwuLcSBAbVY3V7rTOKkJ0fEWXHngRke+bAxCcKX63t2yZgo8WT304N8exUn+3asGuMTmumsXS7r+lnOL6FHmJ2XTr0q6f7FgYRmCmlUqjc+fUYaWWSYv6PmPMhMjzHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8A0AA2017D4;
	Tue, 21 Jul 2026 14:50:33 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm9vd-000ZdV-1Y;
	Tue, 21 Jul 2026 14:50:33 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm9vd-00000000Cjb-1cAJ;
	Tue, 21 Jul 2026 14:50:33 +0200
Message-ID: <08d7d89c6b373365555571d29a97b132aeb4fc0a.camel@pengutronix.de>
Subject: Re: [PATCH v12 1/4] dt-bindings: pwm: dwc: Document optional resets
 property
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ben-linux@fluff.org, 
	ben.dooks@codethink.co.uk, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 daniel.lezcano@kernel.org, tglx@kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 21 Jul 2026 14:50:33 +0200
In-Reply-To: <20260721120833.1192-1-dongxuyang@eswincomputing.com>
References: <20260721120757.1134-1-dongxuyang@eswincomputing.com>
	 <20260721120833.1192-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-07-21 at 20:08 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> The DesignWare PWM IP has two active-low reset inputs: presetn resets
> the register interface logic in the pclk (bus) domain, and
> timer_N_resetn resets the counter/timer logic in the timer_N_clk
> domain. The existing snps,dw-apb-timers-pwm2 binding does not
> describe either of these lines.
>=20
> Add the resets property and describe the function of each reset to
> support future use of resets.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm=
2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> index 7523a89a1773..213fdaef25d9 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -43,6 +43,11 @@ properties:
>        - const: bus
>        - const: timer
> =20
> +  resets:
> +    items:
> +      - description: Interface bus (presetn) reset
> +      - description: PWM timer logic (timer_N_resetn) reset
> +

I suggest adding a reset-names property. Without that the descriptions
are useless, as driver code will not be able to control the resets
individually.

regards
Philipp
